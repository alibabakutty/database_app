import 'package:database_app/models/atrip_sheet.dart';
import 'package:database_app/services/firebase_service.dart';
import 'package:flutter/material.dart';

class AhomePage extends StatefulWidget {
  const AhomePage({super.key});

  @override
  State<AhomePage> createState() => _AhomePageState();
}

class _AhomePageState extends State<AhomePage> {
  final FirebaseService firebaseService = FirebaseService();
  bool isApproved = false;
  bool isEmployer = false;
  bool isLoading = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController noController = TextEditingController();
  final TextEditingController jobNoController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController vehicleNoController = TextEditingController();
  final TextEditingController fromLocationController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // isEmployer = (ModalRoute.of(context)?.settings.arguments as bool?) ?? false;

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is bool) {
      // employee login case
      setState(() {
        isEmployer = args;
      });
    } else if (args is Map<String, dynamic>) {
      // employer login case
      if (args.isNotEmpty) {
        setState(() {
          isEmployer = args['isEmployer'] ?? false;
        });

        final tripSheetNo = args['tripSheetNo'] as int?;
        if (tripSheetNo != null && noController.text.isEmpty) {
          noController.text = tripSheetNo.toString();
          _fetchTripSheetData(tripSheetNo);
        }
      }
    }
  }

  // Fetch trip sheet data using the no value
  Future<void> _fetchTripSheetData(int tripSheetNo) async {
    AtripSheet? atripSheet =
        await firebaseService.getAtripSheetByNo(tripSheetNo);

    if (atripSheet != null) {
      setState(() {
        noController.text = atripSheet.no.toString();
        jobNoController.text = atripSheet.jobNo;
        dateController.text = atripSheet.date.toString().substring(0, 10);
        vehicleNoController.text = atripSheet.vehicleNo;
        fromLocationController.text = atripSheet.fromLocation;
        isApproved = atripSheet.isApproved;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Trip sheet not found.')),
      );
    }
  }

  // Fetch trip sheet data from Firestore by 'No.'
  Future<void> fetchTripSheetData() async {
    if (!isEmployer) return; // Fetch only for employer login

    if (noController.text.isNotEmpty) {
      int? enteredNo = int.tryParse(noController.text.trim());
      if (enteredNo == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid number')),
        );
        return;
      }

      AtripSheet? atripSheet =
          await firebaseService.getAtripSheetByNo(enteredNo);

      if (atripSheet != null) {
        setState(() {
          jobNoController.text = atripSheet.jobNo;
          dateController.text = atripSheet.date.toString().substring(0, 10);
          vehicleNoController.text = atripSheet.vehicleNo;
          fromLocationController.text = atripSheet.fromLocation;
          isApproved = atripSheet.isApproved;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No trip sheet found for this number')),
        );
      }
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      int? tripSheetNo = int.tryParse(noController.text);
      if (tripSheetNo == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid trip sheet number')),
        );
        return;
      }

      String jobNo = jobNoController.text.trim();
      DateTime date = DateTime.parse(dateController.text.trim());
      String vehicleNo = vehicleNoController.text.trim();
      String fromLocation =
          isEmployer ? fromLocationController.text.trim() : '';

      Map<String, dynamic> updatedData = {
        'jobNo': jobNo,
        'date': date,
        'vehicle_no': vehicleNo,
        'from_location': fromLocation,
        'is_approved': true,
        'is_employer': isEmployer,
        'timestamp': DateTime.now(),
      };

      bool success;
      if (isEmployer) {
        // Update existing document if 'isEmployer = true'
        success = await firebaseService.updateAtripSheetByNo(
            tripSheetNo, updatedData);
      } else {
        // Create new document if 'isEmployer = false'
        AtripSheet atripSheet = AtripSheet(
          no: tripSheetNo,
          jobNo: jobNo,
          date: date,
          vehicleNo: vehicleNo,
          fromLocation: fromLocation,
          isApproved: isApproved,
          isEmployer: isEmployer,
          timestamp: DateTime.now(),
        );

        success = await firebaseService.saveTripSheet(atripSheet);
      }

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Trip sheet submitted successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit trip sheet.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trip Sheet Entry')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: noController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'No.',
                  suffixIcon: isEmployer
                      ? IconButton(
                          onPressed: fetchTripSheetData,
                          icon: Icon(
                            Icons.search,
                            color: Colors.blue,
                          ),
                        )
                      : null,
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Enter a valid number' : null,
                onEditingComplete:
                    fetchTripSheetData, // Fetch data when user finishes typing
              ),
              TextFormField(
                controller: jobNoController,
                decoration: const InputDecoration(labelText: 'Job No.'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter job number' : null,
              ),
              TextFormField(
                controller: dateController,
                decoration:
                    const InputDecoration(labelText: 'Date (yyyy-MM-dd)'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter date in yyyy-MM-dd format' : null,
                keyboardType: TextInputType.datetime,
              ),
              TextFormField(
                controller: vehicleNoController,
                decoration: const InputDecoration(labelText: 'Vehicle No.'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter vehicle number' : null,
              ),
              if (isEmployer)
                TextFormField(
                  controller: fromLocationController,
                  decoration: const InputDecoration(labelText: 'From Location'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter from location' : null,
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
