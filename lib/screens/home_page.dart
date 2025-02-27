import 'package:database_app/models/trip_sheet.dart';
import 'package:database_app/models/user_model.dart';
import 'package:database_app/services/firebase_service.dart';
import 'package:database_app/utils/calculations.dart';
import 'package:database_app/utils/session_manager.dart';
import 'package:database_app/utils/submit_handler.dart';
import 'package:database_app/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:database_app/widgets/header_section.dart';
import 'package:database_app/widgets/input_field.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:database_app/authentication/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;
  final Auth _auth = Auth();
  UserModel? userModel;
  bool isApproved = false;
  bool isEmployer = false;
  bool isLoading = true;

  final FirebaseService firebaseService = FirebaseService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController noController = TextEditingController();
  final TextEditingController jobNoController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController vehicleNoController = TextEditingController();
  final TextEditingController fromLocationController = TextEditingController();
  final TextEditingController toLocationController = TextEditingController();
  final TextEditingController litersController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController driverNameController = TextEditingController();
  final TextEditingController cleanerNameController = TextEditingController();
  final TextEditingController containerNoController = TextEditingController();
  final TextEditingController actualAdvanceController = TextEditingController();
  final TextEditingController approvedAdvanceController =
      TextEditingController();
  final TextEditingController actualMtExpensesController =
      TextEditingController();
  final TextEditingController approvedMtExpensesController =
      TextEditingController();
  final TextEditingController actualTollController = TextEditingController();
  final TextEditingController approvedTollController = TextEditingController();
  final TextEditingController actualDriverChargesController =
      TextEditingController();
  final TextEditingController approvedDriverChargesController =
      TextEditingController();
  final TextEditingController actualCleanerChargesController =
      TextEditingController();
  final TextEditingController approvedCleanerChargesController =
      TextEditingController();
  final TextEditingController actualRtoPoliceController =
      TextEditingController();
  final TextEditingController approvedRtoPoliceController =
      TextEditingController();
  final TextEditingController actualHarbourExpensesController =
      TextEditingController();
  final TextEditingController approvedHarbourExpensesController =
      TextEditingController();
  final TextEditingController actualDriverExpensesController =
      TextEditingController();
  final TextEditingController approvedDriverExpensesController =
      TextEditingController();
  final TextEditingController actualWeightChargesController =
      TextEditingController();
  final TextEditingController approvedWeightChargesController =
      TextEditingController();
  final TextEditingController actualLoadingChargesController =
      TextEditingController();
  final TextEditingController approvedLoadingChargesController =
      TextEditingController();
  final TextEditingController actualUnloadingChargesController =
      TextEditingController();
  final TextEditingController approvedUnloadingChargesController =
      TextEditingController();
  final TextEditingController actualOtherExpensesController =
      TextEditingController();
  final TextEditingController approvedOtherExpensesController =
      TextEditingController();
  final TextEditingController actualTotalController = TextEditingController();
  final TextEditingController approvedTotalController = TextEditingController();
  final TextEditingController actualBalanceController = TextEditingController();
  final TextEditingController approvedBalanceController =
      TextEditingController();
  final TextEditingController verifiedByController = TextEditingController();
  final TextEditingController passedByController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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

  // fetch user data from firestore using uid
  Future<void> fetchUserData() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      userModel = await _auth.getUserData(firebaseUser.uid);
      setState(() {}); // Refresh UI after fetching data
    }
  }

  Future<void> _signOut(BuildContext context) async {
    await Auth().signOut();

    if (!context.mounted) {
      return; // Ensure the widget is still mounted before navigation
    } else {
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  // Fetch trip sheet data using the no value
  Future<void> _fetchTripSheetData(int tripSheetNo) async {
    TripSheet? tripSheet = await firebaseService.getTripSheetByNo(tripSheetNo);

    if (tripSheet != null) {
      setState(() {
        noController.text = tripSheet.no.toString();
        jobNoController.text = tripSheet.jobNo;
        dateController.text = DateFormat('dd-MM-yyyy').format(tripSheet.date);
        vehicleNoController.text = tripSheet.vehicleNo;
        fromLocationController.text = tripSheet.fromLocation;
        toLocationController.text = tripSheet.toLocation;
        litersController.text = tripSheet.liters.toStringAsFixed(3);
        amountController.text = tripSheet.amount.toStringAsFixed(2);
        driverNameController.text = tripSheet.driverName;
        cleanerNameController.text = tripSheet.cleanerName;
        containerNoController.text = tripSheet.containerNo;
        actualAdvanceController.text =
            tripSheet.actualAdvance.toStringAsFixed(2);
        approvedAdvanceController.text =
            tripSheet.approvedAdvance.toStringAsFixed(2);
        actualMtExpensesController.text =
            tripSheet.actualMtExpenses.toStringAsFixed(2);
        approvedMtExpensesController.text =
            tripSheet.approvedMtExpenses.toStringAsFixed(2);
        actualTollController.text = tripSheet.actualToll.toStringAsFixed(2);
        approvedTollController.text = tripSheet.approvedToll.toStringAsFixed(2);
        actualDriverChargesController.text =
            tripSheet.actualDriverCharges.toStringAsFixed(2);
        approvedDriverChargesController.text =
            tripSheet.approvedDriverCharges.toStringAsFixed(2);
        actualCleanerChargesController.text =
            tripSheet.actualCleanerCharges.toStringAsFixed(2);
        approvedCleanerChargesController.text =
            tripSheet.approvedCleanerCharges.toStringAsFixed(2);
        actualRtoPoliceController.text =
            tripSheet.actualRtoPolice.toStringAsFixed(2);
        approvedRtoPoliceController.text =
            tripSheet.approvedRtoPolice.toStringAsFixed(2);
        actualHarbourExpensesController.text =
            tripSheet.actualHarbourExpenses.toStringAsFixed(2);
        approvedHarbourExpensesController.text =
            tripSheet.approvedHarbourExpenses.toStringAsFixed(2);
        actualDriverExpensesController.text =
            tripSheet.actualDriverExpenses.toStringAsFixed(2);
        approvedDriverExpensesController.text =
            tripSheet.approvedDriverExpenses.toStringAsFixed(2);
        actualWeightChargesController.text =
            tripSheet.actualWeightCharges.toStringAsFixed(2);
        approvedWeightChargesController.text =
            tripSheet.approvedWeightCharges.toStringAsFixed(2);
        actualLoadingChargesController.text =
            tripSheet.actualLoadingCharges.toStringAsFixed(2);
        approvedLoadingChargesController.text =
            tripSheet.approvedLoadingCharges.toStringAsFixed(2);
        actualUnloadingChargesController.text =
            tripSheet.actualUnloadingCharges.toStringAsFixed(2);
        approvedUnloadingChargesController.text =
            tripSheet.approvedUnloadingCharges.toStringAsFixed(2);
        actualOtherExpensesController.text =
            tripSheet.actualOtherExpenses.toStringAsFixed(2);
        approvedOtherExpensesController.text =
            tripSheet.approvedOtherExpenses.toStringAsFixed(2);
        actualTotalController.text = tripSheet.actualTotal.toStringAsFixed(2);
        approvedTotalController.text =
            tripSheet.approvedTotal.toStringAsFixed(2);
        actualBalanceController.text =
            tripSheet.actualBalance.toStringAsFixed(2);
        approvedBalanceController.text =
            tripSheet.approvedBalance.toStringAsFixed(2);
        verifiedByController.text = tripSheet.verifiedBy;
        passedByController.text = tripSheet.passedBy;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No trip sheet found.')),
      );
    }
  }

  // Function to Fetch Data from Firestore by No. or jobNo.
  Future<void> fetchTripSheetData() async {
    if (!isEmployer) return; // Fetch only for employer login

    TripSheet? tripSheet;

    if (noController.text.isNotEmpty) {
      int? enteredNo = int.tryParse(noController.text.trim());
      if (enteredNo == null) {
        showSnackBar('Please enter a valid No.');
        return;
      }
      tripSheet = await firebaseService.getTripSheetByNo(enteredNo);
    } else if (jobNoController.text.isNotEmpty) {
      String enteredJobNo = jobNoController.text.trim();
      if (enteredJobNo.isEmpty) {
        showSnackBar('Please enter a valid Job No.');
        return;
      }
      tripSheet = await firebaseService.getTripSheetByJobNo(enteredJobNo);
    } else {
      showSnackBar('Please enter either No. or Job No.');
      return;
    }

    if (tripSheet != null && mounted) {
      setState(() {
        populateFields(tripSheet);
      });
    } else {
      showSnackBar('No data found for the entered details.');
    }
  }

  int? tripSheetNo; // tripsheet is the object containing 'no' field

// Helper function to populate fields
  void populateFields(TripSheet? tripSheet) {
    if (tripSheet == null) return; // Exit if null
    noController.text = tripSheet.no.toString();
    jobNoController.text = tripSheet.jobNo;
    dateController.text = DateFormat('dd-MM-yyyy').format(tripSheet.date);
    vehicleNoController.text = tripSheet.vehicleNo;
    fromLocationController.text = tripSheet.fromLocation;
    toLocationController.text = tripSheet.toLocation;
    litersController.text = tripSheet.liters.toStringAsFixed(3);
    amountController.text = tripSheet.amount.toStringAsFixed(2);
    driverNameController.text = tripSheet.driverName;
    cleanerNameController.text = tripSheet.cleanerName;
    containerNoController.text = tripSheet.containerNo;
    actualAdvanceController.text = tripSheet.actualAdvance.toStringAsFixed(2);
    approvedAdvanceController.text =
        tripSheet.approvedAdvance.toStringAsFixed(2);
    actualMtExpensesController.text =
        tripSheet.actualMtExpenses.toStringAsFixed(2);
    approvedMtExpensesController.text =
        tripSheet.approvedMtExpenses.toStringAsFixed(2);
    actualTollController.text = tripSheet.actualToll.toStringAsFixed(2);
    approvedTollController.text = tripSheet.approvedToll.toStringAsFixed(2);
    actualDriverChargesController.text =
        tripSheet.actualDriverCharges.toStringAsFixed(2);
    approvedDriverChargesController.text =
        tripSheet.approvedDriverCharges.toStringAsFixed(2);
    actualCleanerChargesController.text =
        tripSheet.actualCleanerCharges.toStringAsFixed(2);
    approvedCleanerChargesController.text =
        tripSheet.approvedCleanerCharges.toStringAsFixed(2);
    actualRtoPoliceController.text =
        tripSheet.actualRtoPolice.toStringAsFixed(2);
    approvedRtoPoliceController.text =
        tripSheet.approvedRtoPolice.toStringAsFixed(2);
    actualHarbourExpensesController.text =
        tripSheet.actualHarbourExpenses.toStringAsFixed(2);
    approvedHarbourExpensesController.text =
        tripSheet.approvedHarbourExpenses.toStringAsFixed(2);
    actualDriverExpensesController.text =
        tripSheet.actualDriverExpenses.toStringAsFixed(2);
    approvedDriverExpensesController.text =
        tripSheet.approvedDriverExpenses.toStringAsFixed(2);
    actualWeightChargesController.text =
        tripSheet.actualWeightCharges.toStringAsFixed(2);
    approvedWeightChargesController.text =
        tripSheet.approvedWeightCharges.toStringAsFixed(2);
    actualLoadingChargesController.text =
        tripSheet.actualLoadingCharges.toStringAsFixed(2);
    approvedLoadingChargesController.text =
        tripSheet.approvedLoadingCharges.toStringAsFixed(2);
    actualUnloadingChargesController.text =
        tripSheet.actualUnloadingCharges.toStringAsFixed(2);
    approvedUnloadingChargesController.text =
        tripSheet.approvedUnloadingCharges.toStringAsFixed(2);
    actualOtherExpensesController.text =
        tripSheet.actualOtherExpenses.toStringAsFixed(2);
    approvedOtherExpensesController.text =
        tripSheet.approvedOtherExpenses.toStringAsFixed(2);
    actualTotalController.text = tripSheet.actualTotal.toStringAsFixed(2);
    approvedTotalController.text = tripSheet.approvedTotal.toStringAsFixed(2);
    actualBalanceController.text = tripSheet.actualBalance.toStringAsFixed(2);
    approvedBalanceController.text =
        tripSheet.approvedBalance.toStringAsFixed(2);
    verifiedByController.text = tripSheet.verifiedBy;
    passedByController.text = tripSheet.passedBy;
  }

// Helper function to show SnackBar messages
  void showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  final SubmitHandler submitHandler = SubmitHandler();

  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> controllers = [
      noController,
      jobNoController,
      dateController,
      vehicleNoController,
      fromLocationController,
      toLocationController,
      litersController,
      amountController,
      driverNameController,
      cleanerNameController,
      containerNoController,
      actualAdvanceController,
      approvedAdvanceController,
      actualMtExpensesController,
      approvedMtExpensesController,
      actualTollController,
      approvedTollController,
      actualDriverChargesController,
      approvedDriverChargesController,
      actualCleanerChargesController,
      approvedCleanerChargesController,
      actualRtoPoliceController,
      approvedRtoPoliceController,
      actualHarbourExpensesController,
      approvedHarbourExpensesController,
      actualDriverExpensesController,
      approvedDriverExpensesController,
      actualWeightChargesController,
      approvedWeightChargesController,
      actualLoadingChargesController,
      approvedLoadingChargesController,
      actualUnloadingChargesController,
      approvedUnloadingChargesController,
      actualOtherExpensesController,
      approvedOtherExpensesController,
      actualTotalController,
      approvedTotalController,
      actualBalanceController,
      approvedBalanceController,
      verifiedByController,
      passedByController,
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trip Sheet Entry',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                (userModel?.userName != null && userModel!.userName.isNotEmpty)
                    ? userModel!.userName
                    : userModel?.phoneNo ?? 'User Info',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await SessionManager.logout(); // clear session
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const WidgetTree()),
                );
              }
            },
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 221, 235, 246),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  const HeaderSection(),

                  // Input Fields Section
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'No.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.60, // 50% of screen width
                            child: InputField(
                              label: '',
                              hintText: 'Enter Number (e.x) 123',
                              controller: noController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          if (isEmployer)
                            IconButton(
                              onPressed: fetchTripSheetData,
                              icon: const Icon(
                                Icons.content_paste_search_outlined,
                                color: Colors.black,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Job No.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: InputField(
                              label: '',
                              hintText: 'Enter Job Number. (e.x) K-123',
                              controller: jobNoController,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          if (isEmployer)
                            IconButton(
                              onPressed: fetchTripSheetData,
                              icon: const Icon(
                                Icons.content_paste_search_outlined,
                                color: Colors.black,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: InputField(
                              label: '',
                              controller: dateController,
                              keyboardType: TextInputType.datetime,
                              isDateField: true,
                              onTab: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                DateTime? pickDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2050),
                                );
                                if (pickDate != null) {
                                  dateController.text =
                                      DateFormat('dd-MM-yyyy').format(pickDate);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Vehicle No.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: InputField(
                              label: '',
                              hintText: 'Enter Vehicle No. (e.x) TN01-L1234',
                              controller: vehicleNoController,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'From Location',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: InputField(
                              label: '',
                              hintText: 'Enter From Location (e.x) Chennai',
                              controller: fromLocationController,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'To Location',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: InputField(
                              label: '',
                              hintText: 'Enter To Location (e.x) Bangalore',
                              controller: toLocationController,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Diesel inputs
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Align items vertically
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0), // Moves the Diesel label down slightly
                        child: const Text(
                          'Diesel',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: 'Liters',
                            hintText: '0.000',
                            controller: litersController,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d{0,3}$'),
                              ),
                            ],
                            centerLabel: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16), // Space between inputs
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: 'Amount',
                            hintText: '0.00',
                            controller: amountController,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                            formatToTwoDecimals: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Driver Name',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: InputField(
                              label: '',
                              hintText: 'Enter Driver Name',
                              controller: driverNameController,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Cleaner Name',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: InputField(
                              label: '',
                              hintText: 'Enter Cleaner Name',
                              controller: cleanerNameController,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Container No.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: InputField(
                              label: '',
                              hintText: 'Enter Container No. (e.x) A123X4',
                              controller: containerNoController,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // actual and approved input fields started
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: const Text(
                          'Advance',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(), // Push inputs to the right side
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: 'Actual',
                            hintText: '0.00',
                            controller: actualAdvanceController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                            formatToTwoDecimals: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (isEmployer)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InputField(
                              label: 'Approved',
                              hintText: '0.00',
                              controller: approvedAdvanceController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$')),
                              ],
                              centerLabel: true,
                              showRupeeSymbol: true,
                              formatToTwoDecimals: true,
                              onTab: () {
                                if (approvedAdvanceController.text == '0.00') {
                                  approvedAdvanceController.clear();
                                }
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: const Text(
                          'M.T.Expenses',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(), // Push inputs to the right side
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            hintText: '0.00',
                            controller: actualMtExpensesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                            formatToTwoDecimals: true,
                            onChanged: (_) {
                              calculateTotals(
                                actualMtExpensesController:
                                    actualMtExpensesController,
                                approvedMtExpensesController:
                                    approvedMtExpensesController,
                                actualTollController: actualTollController,
                                approvedTollController: approvedTollController,
                                actualDriverChargesController:
                                    actualDriverChargesController,
                                approvedDriverChargesController:
                                    approvedDriverChargesController,
                                actualCleanerChargesController:
                                    actualCleanerChargesController,
                                approvedCleanerChargesController:
                                    approvedCleanerChargesController,
                                actualRtoPoliceController:
                                    actualRtoPoliceController,
                                approvedRtoPoliceController:
                                    approvedRtoPoliceController,
                                actualHarbourExpensesController:
                                    actualHarbourExpensesController,
                                approvedHarbourExpensesController:
                                    approvedHarbourExpensesController,
                                actualDriverExpensesController:
                                    actualDriverExpensesController,
                                approvedDriverExpensesController:
                                    approvedDriverExpensesController,
                                actualWeightChargesController:
                                    actualWeightChargesController,
                                approvedWeightChargesController:
                                    approvedWeightChargesController,
                                actualLoadingChargesController:
                                    actualLoadingChargesController,
                                approvedLoadingChargesController:
                                    approvedLoadingChargesController,
                                actualUnloadingChargesController:
                                    actualUnloadingChargesController,
                                approvedUnloadingChargesController:
                                    approvedUnloadingChargesController,
                                actualOtherExpensesController:
                                    actualOtherExpensesController,
                                approvedOtherExpensesController:
                                    approvedOtherExpensesController,
                                actualTotalController: actualTotalController,
                                approvedTotalController:
                                    approvedTotalController,
                                actualAdvanceController:
                                    actualAdvanceController,
                                approvedAdvanceController:
                                    approvedAdvanceController,
                                actualBalanceController:
                                    actualBalanceController,
                                approvedBalanceController:
                                    approvedBalanceController,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (isEmployer)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InputField(
                              label: '',
                              hintText: '0.00',
                              controller: approvedMtExpensesController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$')),
                              ],
                              centerLabel: true,
                              showRupeeSymbol: true,
                              formatToTwoDecimals: true,
                              onTab: () {
                                if (approvedMtExpensesController.text ==
                                    '0.00') {
                                  approvedMtExpensesController.clear();
                                }
                              },
                              onChanged: (_) {
                                calculateTotals(
                                  actualMtExpensesController:
                                      actualMtExpensesController,
                                  approvedMtExpensesController:
                                      approvedMtExpensesController,
                                  actualTollController: actualTollController,
                                  approvedTollController:
                                      approvedTollController,
                                  actualDriverChargesController:
                                      actualDriverChargesController,
                                  approvedDriverChargesController:
                                      approvedDriverChargesController,
                                  actualCleanerChargesController:
                                      actualCleanerChargesController,
                                  approvedCleanerChargesController:
                                      approvedCleanerChargesController,
                                  actualRtoPoliceController:
                                      actualRtoPoliceController,
                                  approvedRtoPoliceController:
                                      approvedRtoPoliceController,
                                  actualHarbourExpensesController:
                                      actualHarbourExpensesController,
                                  approvedHarbourExpensesController:
                                      approvedHarbourExpensesController,
                                  actualDriverExpensesController:
                                      actualDriverExpensesController,
                                  approvedDriverExpensesController:
                                      approvedDriverExpensesController,
                                  actualWeightChargesController:
                                      actualWeightChargesController,
                                  approvedWeightChargesController:
                                      approvedWeightChargesController,
                                  actualLoadingChargesController:
                                      actualLoadingChargesController,
                                  approvedLoadingChargesController:
                                      approvedLoadingChargesController,
                                  actualUnloadingChargesController:
                                      actualUnloadingChargesController,
                                  approvedUnloadingChargesController:
                                      approvedUnloadingChargesController,
                                  actualOtherExpensesController:
                                      actualOtherExpensesController,
                                  approvedOtherExpensesController:
                                      approvedOtherExpensesController,
                                  actualTotalController: actualTotalController,
                                  approvedTotalController:
                                      approvedTotalController,
                                  actualAdvanceController:
                                      actualAdvanceController,
                                  approvedAdvanceController:
                                      approvedAdvanceController,
                                  actualBalanceController:
                                      actualBalanceController,
                                  approvedBalanceController:
                                      approvedBalanceController,
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: const Text(
                          'Toll',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(), // Push inputs to the right side
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            hintText: '0.00',
                            controller: actualTollController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                            formatToTwoDecimals: true,
                            onChanged: (_) {
                              calculateTotals(
                                actualMtExpensesController:
                                    actualMtExpensesController,
                                approvedMtExpensesController:
                                    approvedMtExpensesController,
                                actualTollController: actualTollController,
                                approvedTollController: approvedTollController,
                                actualDriverChargesController:
                                    actualDriverChargesController,
                                approvedDriverChargesController:
                                    approvedDriverChargesController,
                                actualCleanerChargesController:
                                    actualCleanerChargesController,
                                approvedCleanerChargesController:
                                    approvedCleanerChargesController,
                                actualRtoPoliceController:
                                    actualRtoPoliceController,
                                approvedRtoPoliceController:
                                    approvedRtoPoliceController,
                                actualHarbourExpensesController:
                                    actualHarbourExpensesController,
                                approvedHarbourExpensesController:
                                    approvedHarbourExpensesController,
                                actualDriverExpensesController:
                                    actualDriverExpensesController,
                                approvedDriverExpensesController:
                                    approvedDriverExpensesController,
                                actualWeightChargesController:
                                    actualWeightChargesController,
                                approvedWeightChargesController:
                                    approvedWeightChargesController,
                                actualLoadingChargesController:
                                    actualLoadingChargesController,
                                approvedLoadingChargesController:
                                    approvedLoadingChargesController,
                                actualUnloadingChargesController:
                                    actualUnloadingChargesController,
                                approvedUnloadingChargesController:
                                    approvedUnloadingChargesController,
                                actualOtherExpensesController:
                                    actualOtherExpensesController,
                                approvedOtherExpensesController:
                                    approvedOtherExpensesController,
                                actualTotalController: actualTotalController,
                                approvedTotalController:
                                    approvedTotalController,
                                actualAdvanceController:
                                    actualAdvanceController,
                                approvedAdvanceController:
                                    approvedAdvanceController,
                                actualBalanceController:
                                    actualBalanceController,
                                approvedBalanceController:
                                    approvedBalanceController,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (isEmployer)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InputField(
                              label: '',
                              hintText: '0.00',
                              controller: approvedTollController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$')),
                              ],
                              centerLabel: true,
                              showRupeeSymbol: true,
                              formatToTwoDecimals: true,
                              onTab: () {
                                if (approvedTollController.text == '0.00') {
                                  approvedTollController.clear();
                                }
                              },
                              onChanged: (_) {
                                calculateTotals(
                                  actualMtExpensesController:
                                      actualMtExpensesController,
                                  approvedMtExpensesController:
                                      approvedMtExpensesController,
                                  actualTollController: actualTollController,
                                  approvedTollController:
                                      approvedTollController,
                                  actualDriverChargesController:
                                      actualDriverChargesController,
                                  approvedDriverChargesController:
                                      approvedDriverChargesController,
                                  actualCleanerChargesController:
                                      actualCleanerChargesController,
                                  approvedCleanerChargesController:
                                      approvedCleanerChargesController,
                                  actualRtoPoliceController:
                                      actualRtoPoliceController,
                                  approvedRtoPoliceController:
                                      approvedRtoPoliceController,
                                  actualHarbourExpensesController:
                                      actualHarbourExpensesController,
                                  approvedHarbourExpensesController:
                                      approvedHarbourExpensesController,
                                  actualDriverExpensesController:
                                      actualDriverExpensesController,
                                  approvedDriverExpensesController:
                                      approvedDriverExpensesController,
                                  actualWeightChargesController:
                                      actualWeightChargesController,
                                  approvedWeightChargesController:
                                      approvedWeightChargesController,
                                  actualLoadingChargesController:
                                      actualLoadingChargesController,
                                  approvedLoadingChargesController:
                                      approvedLoadingChargesController,
                                  actualUnloadingChargesController:
                                      actualUnloadingChargesController,
                                  approvedUnloadingChargesController:
                                      approvedUnloadingChargesController,
                                  actualOtherExpensesController:
                                      actualOtherExpensesController,
                                  approvedOtherExpensesController:
                                      approvedOtherExpensesController,
                                  actualTotalController: actualTotalController,
                                  approvedTotalController:
                                      approvedTotalController,
                                  actualAdvanceController:
                                      actualAdvanceController,
                                  approvedAdvanceController:
                                      approvedAdvanceController,
                                  actualBalanceController:
                                      actualBalanceController,
                                  approvedBalanceController:
                                      approvedBalanceController,
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: const Text(
                          'Driver Charges',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(), // Push inputs to the right side
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            hintText: '0.00',
                            controller: actualDriverChargesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d{0,2}$'),
                              ),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                            formatToTwoDecimals: true,
                            onChanged: (_) {
                              calculateTotals(
                                actualMtExpensesController:
                                    actualMtExpensesController,
                                approvedMtExpensesController:
                                    approvedMtExpensesController,
                                actualTollController: actualTollController,
                                approvedTollController: approvedTollController,
                                actualDriverChargesController:
                                    actualDriverChargesController,
                                approvedDriverChargesController:
                                    approvedDriverChargesController,
                                actualCleanerChargesController:
                                    actualCleanerChargesController,
                                approvedCleanerChargesController:
                                    approvedCleanerChargesController,
                                actualRtoPoliceController:
                                    actualRtoPoliceController,
                                approvedRtoPoliceController:
                                    approvedRtoPoliceController,
                                actualHarbourExpensesController:
                                    actualHarbourExpensesController,
                                approvedHarbourExpensesController:
                                    approvedHarbourExpensesController,
                                actualDriverExpensesController:
                                    actualDriverExpensesController,
                                approvedDriverExpensesController:
                                    approvedDriverExpensesController,
                                actualWeightChargesController:
                                    actualWeightChargesController,
                                approvedWeightChargesController:
                                    approvedWeightChargesController,
                                actualLoadingChargesController:
                                    actualLoadingChargesController,
                                approvedLoadingChargesController:
                                    approvedLoadingChargesController,
                                actualUnloadingChargesController:
                                    actualUnloadingChargesController,
                                approvedUnloadingChargesController:
                                    approvedUnloadingChargesController,
                                actualOtherExpensesController:
                                    actualOtherExpensesController,
                                approvedOtherExpensesController:
                                    approvedOtherExpensesController,
                                actualTotalController: actualTotalController,
                                approvedTotalController:
                                    approvedTotalController,
                                actualAdvanceController:
                                    actualAdvanceController,
                                approvedAdvanceController:
                                    approvedAdvanceController,
                                actualBalanceController:
                                    actualBalanceController,
                                approvedBalanceController:
                                    approvedBalanceController,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (isEmployer)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InputField(
                              label: '',
                              hintText: '0.00',
                              controller: approvedDriverChargesController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$')),
                              ],
                              centerLabel: true,
                              showRupeeSymbol: true,
                              formatToTwoDecimals: true,
                              onTab: () {
                                if (approvedDriverChargesController.text ==
                                    '0.00') {
                                  approvedDriverChargesController.clear();
                                }
                              },
                              onChanged: (_) {
                                calculateTotals(
                                  actualMtExpensesController:
                                      actualMtExpensesController,
                                  approvedMtExpensesController:
                                      approvedMtExpensesController,
                                  actualTollController: actualTollController,
                                  approvedTollController:
                                      approvedTollController,
                                  actualDriverChargesController:
                                      actualDriverChargesController,
                                  approvedDriverChargesController:
                                      approvedDriverChargesController,
                                  actualCleanerChargesController:
                                      actualCleanerChargesController,
                                  approvedCleanerChargesController:
                                      approvedCleanerChargesController,
                                  actualRtoPoliceController:
                                      actualRtoPoliceController,
                                  approvedRtoPoliceController:
                                      approvedRtoPoliceController,
                                  actualHarbourExpensesController:
                                      actualHarbourExpensesController,
                                  approvedHarbourExpensesController:
                                      approvedHarbourExpensesController,
                                  actualDriverExpensesController:
                                      actualDriverExpensesController,
                                  approvedDriverExpensesController:
                                      approvedDriverExpensesController,
                                  actualWeightChargesController:
                                      actualWeightChargesController,
                                  approvedWeightChargesController:
                                      approvedWeightChargesController,
                                  actualLoadingChargesController:
                                      actualLoadingChargesController,
                                  approvedLoadingChargesController:
                                      approvedLoadingChargesController,
                                  actualUnloadingChargesController:
                                      actualUnloadingChargesController,
                                  approvedUnloadingChargesController:
                                      approvedUnloadingChargesController,
                                  actualOtherExpensesController:
                                      actualOtherExpensesController,
                                  approvedOtherExpensesController:
                                      approvedOtherExpensesController,
                                  actualTotalController: actualTotalController,
                                  approvedTotalController:
                                      approvedTotalController,
                                  actualAdvanceController:
                                      actualAdvanceController,
                                  approvedAdvanceController:
                                      approvedAdvanceController,
                                  actualBalanceController:
                                      actualBalanceController,
                                  approvedBalanceController:
                                      approvedBalanceController,
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: const Text(
                          'Cleaner Charges',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(), // Push inputs to the right side
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            hintText: '0.00',
                            controller: actualCleanerChargesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                            formatToTwoDecimals: true,
                            onChanged: (_) {
                              calculateTotals(
                                actualMtExpensesController:
                                    actualMtExpensesController,
                                approvedMtExpensesController:
                                    approvedMtExpensesController,
                                actualTollController: actualTollController,
                                approvedTollController: approvedTollController,
                                actualDriverChargesController:
                                    actualDriverChargesController,
                                approvedDriverChargesController:
                                    approvedDriverChargesController,
                                actualCleanerChargesController:
                                    actualCleanerChargesController,
                                approvedCleanerChargesController:
                                    approvedCleanerChargesController,
                                actualRtoPoliceController:
                                    actualRtoPoliceController,
                                approvedRtoPoliceController:
                                    approvedRtoPoliceController,
                                actualHarbourExpensesController:
                                    actualHarbourExpensesController,
                                approvedHarbourExpensesController:
                                    approvedHarbourExpensesController,
                                actualDriverExpensesController:
                                    actualDriverExpensesController,
                                approvedDriverExpensesController:
                                    approvedDriverExpensesController,
                                actualWeightChargesController:
                                    actualWeightChargesController,
                                approvedWeightChargesController:
                                    approvedWeightChargesController,
                                actualLoadingChargesController:
                                    actualLoadingChargesController,
                                approvedLoadingChargesController:
                                    approvedLoadingChargesController,
                                actualUnloadingChargesController:
                                    actualUnloadingChargesController,
                                approvedUnloadingChargesController:
                                    approvedUnloadingChargesController,
                                actualOtherExpensesController:
                                    actualOtherExpensesController,
                                approvedOtherExpensesController:
                                    approvedOtherExpensesController,
                                actualTotalController: actualTotalController,
                                approvedTotalController:
                                    approvedTotalController,
                                actualAdvanceController:
                                    actualAdvanceController,
                                approvedAdvanceController:
                                    approvedAdvanceController,
                                actualBalanceController:
                                    actualBalanceController,
                                approvedBalanceController:
                                    approvedBalanceController,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (isEmployer)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InputField(
                              label: '',
                              hintText: '0.00',
                              controller: approvedCleanerChargesController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$')),
                              ],
                              centerLabel: true,
                              showRupeeSymbol: true,
                              formatToTwoDecimals: true,
                              onTab: () {
                                if (approvedCleanerChargesController.text ==
                                    '0.00') {
                                  approvedCleanerChargesController.clear();
                                }
                              },
                              onChanged: (_) {
                                calculateTotals(
                                  actualMtExpensesController:
                                      actualMtExpensesController,
                                  approvedMtExpensesController:
                                      approvedMtExpensesController,
                                  actualTollController: actualTollController,
                                  approvedTollController:
                                      approvedTollController,
                                  actualDriverChargesController:
                                      actualDriverChargesController,
                                  approvedDriverChargesController:
                                      approvedDriverChargesController,
                                  actualCleanerChargesController:
                                      actualCleanerChargesController,
                                  approvedCleanerChargesController:
                                      approvedCleanerChargesController,
                                  actualRtoPoliceController:
                                      actualRtoPoliceController,
                                  approvedRtoPoliceController:
                                      approvedRtoPoliceController,
                                  actualHarbourExpensesController:
                                      actualHarbourExpensesController,
                                  approvedHarbourExpensesController:
                                      approvedHarbourExpensesController,
                                  actualDriverExpensesController:
                                      actualDriverExpensesController,
                                  approvedDriverExpensesController:
                                      approvedDriverExpensesController,
                                  actualWeightChargesController:
                                      actualWeightChargesController,
                                  approvedWeightChargesController:
                                      approvedWeightChargesController,
                                  actualLoadingChargesController:
                                      actualLoadingChargesController,
                                  approvedLoadingChargesController:
                                      approvedLoadingChargesController,
                                  actualUnloadingChargesController:
                                      actualUnloadingChargesController,
                                  approvedUnloadingChargesController:
                                      approvedUnloadingChargesController,
                                  actualOtherExpensesController:
                                      actualOtherExpensesController,
                                  approvedOtherExpensesController:
                                      approvedOtherExpensesController,
                                  actualTotalController: actualTotalController,
                                  approvedTotalController:
                                      approvedTotalController,
                                  actualAdvanceController:
                                      actualAdvanceController,
                                  approvedAdvanceController:
                                      approvedAdvanceController,
                                  actualBalanceController:
                                      actualBalanceController,
                                  approvedBalanceController:
                                      approvedBalanceController,
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: const Text(
                          'R.T.O./Police',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(), // Push inputs to the right side
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            hintText: '0.00',
                            controller: actualRtoPoliceController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                            formatToTwoDecimals: true,
                            onChanged: (_) {
                              calculateTotals(
                                actualMtExpensesController:
                                    actualMtExpensesController,
                                approvedMtExpensesController:
                                    approvedMtExpensesController,
                                actualTollController: actualTollController,
                                approvedTollController: approvedTollController,
                                actualDriverChargesController:
                                    actualDriverChargesController,
                                approvedDriverChargesController:
                                    approvedDriverChargesController,
                                actualCleanerChargesController:
                                    actualCleanerChargesController,
                                approvedCleanerChargesController:
                                    approvedCleanerChargesController,
                                actualRtoPoliceController:
                                    actualRtoPoliceController,
                                approvedRtoPoliceController:
                                    approvedRtoPoliceController,
                                actualHarbourExpensesController:
                                    actualHarbourExpensesController,
                                approvedHarbourExpensesController:
                                    approvedHarbourExpensesController,
                                actualDriverExpensesController:
                                    actualDriverExpensesController,
                                approvedDriverExpensesController:
                                    approvedDriverExpensesController,
                                actualWeightChargesController:
                                    actualWeightChargesController,
                                approvedWeightChargesController:
                                    approvedWeightChargesController,
                                actualLoadingChargesController:
                                    actualLoadingChargesController,
                                approvedLoadingChargesController:
                                    approvedLoadingChargesController,
                                actualUnloadingChargesController:
                                    actualUnloadingChargesController,
                                approvedUnloadingChargesController:
                                    approvedUnloadingChargesController,
                                actualOtherExpensesController:
                                    actualOtherExpensesController,
                                approvedOtherExpensesController:
                                    approvedOtherExpensesController,
                                actualTotalController: actualTotalController,
                                approvedTotalController:
                                    approvedTotalController,
                                actualAdvanceController:
                                    actualAdvanceController,
                                approvedAdvanceController:
                                    approvedAdvanceController,
                                actualBalanceController:
                                    actualBalanceController,
                                approvedBalanceController:
                                    approvedBalanceController,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (isEmployer)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InputField(
                              label: '',
                              hintText: '0.00',
                              controller: approvedRtoPoliceController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$')),
                              ],
                              centerLabel: true,
                              showRupeeSymbol: true,
                              formatToTwoDecimals: true,
                              onTab: () {
                                if (approvedRtoPoliceController.text ==
                                    '0.00') {
                                  approvedRtoPoliceController.clear();
                                }
                              },
                              onChanged: (_) {
                                calculateTotals(
                                  actualMtExpensesController:
                                      actualMtExpensesController,
                                  approvedMtExpensesController:
                                      approvedMtExpensesController,
                                  actualTollController: actualTollController,
                                  approvedTollController:
                                      approvedTollController,
                                  actualDriverChargesController:
                                      actualDriverChargesController,
                                  approvedDriverChargesController:
                                      approvedDriverChargesController,
                                  actualCleanerChargesController:
                                      actualCleanerChargesController,
                                  approvedCleanerChargesController:
                                      approvedCleanerChargesController,
                                  actualRtoPoliceController:
                                      actualRtoPoliceController,
                                  approvedRtoPoliceController:
                                      approvedRtoPoliceController,
                                  actualHarbourExpensesController:
                                      actualHarbourExpensesController,
                                  approvedHarbourExpensesController:
                                      approvedHarbourExpensesController,
                                  actualDriverExpensesController:
                                      actualDriverExpensesController,
                                  approvedDriverExpensesController:
                                      approvedDriverExpensesController,
                                  actualWeightChargesController:
                                      actualWeightChargesController,
                                  approvedWeightChargesController:
                                      approvedWeightChargesController,
                                  actualLoadingChargesController:
                                      actualLoadingChargesController,
                                  approvedLoadingChargesController:
                                      approvedLoadingChargesController,
                                  actualUnloadingChargesController:
                                      actualUnloadingChargesController,
                                  approvedUnloadingChargesController:
                                      approvedUnloadingChargesController,
                                  actualOtherExpensesController:
                                      actualOtherExpensesController,
                                  approvedOtherExpensesController:
                                      approvedOtherExpensesController,
                                  actualTotalController: actualTotalController,
                                  approvedTotalController:
                                      approvedTotalController,
                                  actualAdvanceController:
                                      actualAdvanceController,
                                  approvedAdvanceController:
                                      approvedAdvanceController,
                                  actualBalanceController:
                                      actualBalanceController,
                                  approvedBalanceController:
                                      approvedBalanceController,
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: const Text(
                          'Harbour Expenses',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            hintText: '0.00',
                            controller: actualHarbourExpensesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                            formatToTwoDecimals: true,
                            onChanged: (_) {
                              calculateTotals(
                                actualMtExpensesController:
                                    actualMtExpensesController,
                                approvedMtExpensesController:
                                    approvedMtExpensesController,
                                actualTollController: actualTollController,
                                approvedTollController: approvedTollController,
                                actualDriverChargesController:
                                    actualDriverChargesController,
                                approvedDriverChargesController:
                                    approvedDriverChargesController,
                                actualCleanerChargesController:
                                    actualCleanerChargesController,
                                approvedCleanerChargesController:
                                    approvedCleanerChargesController,
                                actualRtoPoliceController:
                                    actualRtoPoliceController,
                                approvedRtoPoliceController:
                                    approvedRtoPoliceController,
                                actualHarbourExpensesController:
                                    actualHarbourExpensesController,
                                approvedHarbourExpensesController:
                                    approvedHarbourExpensesController,
                                actualDriverExpensesController:
                                    actualDriverExpensesController,
                                approvedDriverExpensesController:
                                    approvedDriverExpensesController,
                                actualWeightChargesController:
                                    actualWeightChargesController,
                                approvedWeightChargesController:
                                    approvedWeightChargesController,
                                actualLoadingChargesController:
                                    actualLoadingChargesController,
                                approvedLoadingChargesController:
                                    approvedLoadingChargesController,
                                actualUnloadingChargesController:
                                    actualUnloadingChargesController,
                                approvedUnloadingChargesController:
                                    approvedUnloadingChargesController,
                                actualOtherExpensesController:
                                    actualOtherExpensesController,
                                approvedOtherExpensesController:
                                    approvedOtherExpensesController,
                                actualTotalController: actualTotalController,
                                approvedTotalController:
                                    approvedTotalController,
                                actualAdvanceController:
                                    actualAdvanceController,
                                approvedAdvanceController:
                                    approvedAdvanceController,
                                actualBalanceController:
                                    actualBalanceController,
                                approvedBalanceController:
                                    approvedBalanceController,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (isEmployer)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InputField(
                              label: '',
                              hintText: '0.00',
                              controller: approvedHarbourExpensesController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$')),
                              ],
                              centerLabel: true,
                              showRupeeSymbol: true,
                              formatToTwoDecimals: true,
                              onTab: () {
                                if (approvedHarbourExpensesController.text ==
                                    '0.00') {
                                  approvedHarbourExpensesController.clear();
                                }
                              },
                              onChanged: (_) {
                                calculateTotals(
                                  actualMtExpensesController:
                                      actualMtExpensesController,
                                  approvedMtExpensesController:
                                      approvedMtExpensesController,
                                  actualTollController: actualTollController,
                                  approvedTollController:
                                      approvedTollController,
                                  actualDriverChargesController:
                                      actualDriverChargesController,
                                  approvedDriverChargesController:
                                      approvedDriverChargesController,
                                  actualCleanerChargesController:
                                      actualCleanerChargesController,
                                  approvedCleanerChargesController:
                                      approvedCleanerChargesController,
                                  actualRtoPoliceController:
                                      actualRtoPoliceController,
                                  approvedRtoPoliceController:
                                      approvedRtoPoliceController,
                                  actualHarbourExpensesController:
                                      actualHarbourExpensesController,
                                  approvedHarbourExpensesController:
                                      approvedHarbourExpensesController,
                                  actualDriverExpensesController:
                                      actualDriverExpensesController,
                                  approvedDriverExpensesController:
                                      approvedDriverExpensesController,
                                  actualWeightChargesController:
                                      actualWeightChargesController,
                                  approvedWeightChargesController:
                                      approvedWeightChargesController,
                                  actualLoadingChargesController:
                                      actualLoadingChargesController,
                                  approvedLoadingChargesController:
                                      approvedLoadingChargesController,
                                  actualUnloadingChargesController:
                                      actualUnloadingChargesController,
                                  approvedUnloadingChargesController:
                                      approvedUnloadingChargesController,
                                  actualOtherExpensesController:
                                      actualOtherExpensesController,
                                  approvedOtherExpensesController:
                                      approvedOtherExpensesController,
                                  actualTotalController: actualTotalController,
                                  approvedTotalController:
                                      approvedTotalController,
                                  actualAdvanceController:
                                      actualAdvanceController,
                                  approvedAdvanceController:
                                      approvedAdvanceController,
                                  actualBalanceController:
                                      actualBalanceController,
                                  approvedBalanceController:
                                      approvedBalanceController,
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: const Text(
                          'Driver Expenses',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            hintText: '0.00',
                            controller: actualDriverExpensesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                            formatToTwoDecimals: true,
                            onChanged: (_) {
                              calculateTotals(
                                actualMtExpensesController:
                                    actualMtExpensesController,
                                approvedMtExpensesController:
                                    approvedMtExpensesController,
                                actualTollController: actualTollController,
                                approvedTollController: approvedTollController,
                                actualDriverChargesController:
                                    actualDriverChargesController,
                                approvedDriverChargesController:
                                    approvedDriverChargesController,
                                actualCleanerChargesController:
                                    actualCleanerChargesController,
                                approvedCleanerChargesController:
                                    approvedCleanerChargesController,
                                actualRtoPoliceController:
                                    actualRtoPoliceController,
                                approvedRtoPoliceController:
                                    approvedRtoPoliceController,
                                actualHarbourExpensesController:
                                    actualHarbourExpensesController,
                                approvedHarbourExpensesController:
                                    approvedHarbourExpensesController,
                                actualDriverExpensesController:
                                    actualDriverExpensesController,
                                approvedDriverExpensesController:
                                    approvedDriverExpensesController,
                                actualWeightChargesController:
                                    actualWeightChargesController,
                                approvedWeightChargesController:
                                    approvedWeightChargesController,
                                actualLoadingChargesController:
                                    actualLoadingChargesController,
                                approvedLoadingChargesController:
                                    approvedLoadingChargesController,
                                actualUnloadingChargesController:
                                    actualUnloadingChargesController,
                                approvedUnloadingChargesController:
                                    approvedUnloadingChargesController,
                                actualOtherExpensesController:
                                    actualOtherExpensesController,
                                approvedOtherExpensesController:
                                    approvedOtherExpensesController,
                                actualTotalController: actualTotalController,
                                approvedTotalController:
                                    approvedTotalController,
                                actualAdvanceController:
                                    actualAdvanceController,
                                approvedAdvanceController:
                                    approvedAdvanceController,
                                actualBalanceController:
                                    actualBalanceController,
                                approvedBalanceController:
                                    approvedBalanceController,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (isEmployer)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InputField(
                              label: '',
                              hintText: '0.00',
                              controller: approvedDriverExpensesController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$')),
                              ],
                              centerLabel: true,
                              showRupeeSymbol: true,
                              formatToTwoDecimals: true,
                              onTab: () {
                                if (approvedDriverExpensesController.text ==
                                    '0.00') {
                                  approvedDriverExpensesController.clear();
                                }
                              },
                              onChanged: (_) {
                                calculateTotals(
                                  actualMtExpensesController:
                                      actualMtExpensesController,
                                  approvedMtExpensesController:
                                      approvedMtExpensesController,
                                  actualTollController: actualTollController,
                                  approvedTollController:
                                      approvedTollController,
                                  actualDriverChargesController:
                                      actualDriverChargesController,
                                  approvedDriverChargesController:
                                      approvedDriverChargesController,
                                  actualCleanerChargesController:
                                      actualCleanerChargesController,
                                  approvedCleanerChargesController:
                                      approvedCleanerChargesController,
                                  actualRtoPoliceController:
                                      actualRtoPoliceController,
                                  approvedRtoPoliceController:
                                      approvedRtoPoliceController,
                                  actualHarbourExpensesController:
                                      actualHarbourExpensesController,
                                  approvedHarbourExpensesController:
                                      approvedHarbourExpensesController,
                                  actualDriverExpensesController:
                                      actualDriverExpensesController,
                                  approvedDriverExpensesController:
                                      approvedDriverExpensesController,
                                  actualWeightChargesController:
                                      actualWeightChargesController,
                                  approvedWeightChargesController:
                                      approvedWeightChargesController,
                                  actualLoadingChargesController:
                                      actualLoadingChargesController,
                                  approvedLoadingChargesController:
                                      approvedLoadingChargesController,
                                  actualUnloadingChargesController:
                                      actualUnloadingChargesController,
                                  approvedUnloadingChargesController:
                                      approvedUnloadingChargesController,
                                  actualOtherExpensesController:
                                      actualOtherExpensesController,
                                  approvedOtherExpensesController:
                                      approvedOtherExpensesController,
                                  actualTotalController: actualTotalController,
                                  approvedTotalController:
                                      approvedTotalController,
                                  actualAdvanceController:
                                      actualAdvanceController,
                                  approvedAdvanceController:
                                      approvedAdvanceController,
                                  actualBalanceController:
                                      actualBalanceController,
                                  approvedBalanceController:
                                      approvedBalanceController,
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: const Text(
                          'Weight Charges',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            hintText: '0.00',
                            controller: actualWeightChargesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                            formatToTwoDecimals: true,
                            onChanged: (_) {
                              calculateTotals(
                                actualMtExpensesController:
                                    actualMtExpensesController,
                                approvedMtExpensesController:
                                    approvedMtExpensesController,
                                actualTollController: actualTollController,
                                approvedTollController: approvedTollController,
                                actualDriverChargesController:
                                    actualDriverChargesController,
                                approvedDriverChargesController:
                                    approvedDriverChargesController,
                                actualCleanerChargesController:
                                    actualCleanerChargesController,
                                approvedCleanerChargesController:
                                    approvedCleanerChargesController,
                                actualRtoPoliceController:
                                    actualRtoPoliceController,
                                approvedRtoPoliceController:
                                    approvedRtoPoliceController,
                                actualHarbourExpensesController:
                                    actualHarbourExpensesController,
                                approvedHarbourExpensesController:
                                    approvedHarbourExpensesController,
                                actualDriverExpensesController:
                                    actualDriverExpensesController,
                                approvedDriverExpensesController:
                                    approvedDriverExpensesController,
                                actualWeightChargesController:
                                    actualWeightChargesController,
                                approvedWeightChargesController:
                                    approvedWeightChargesController,
                                actualLoadingChargesController:
                                    actualLoadingChargesController,
                                approvedLoadingChargesController:
                                    approvedLoadingChargesController,
                                actualUnloadingChargesController:
                                    actualUnloadingChargesController,
                                approvedUnloadingChargesController:
                                    approvedUnloadingChargesController,
                                actualOtherExpensesController:
                                    actualOtherExpensesController,
                                approvedOtherExpensesController:
                                    approvedOtherExpensesController,
                                actualTotalController: actualTotalController,
                                approvedTotalController:
                                    approvedTotalController,
                                actualAdvanceController:
                                    actualAdvanceController,
                                approvedAdvanceController:
                                    approvedAdvanceController,
                                actualBalanceController:
                                    actualBalanceController,
                                approvedBalanceController:
                                    approvedBalanceController,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (isEmployer)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InputField(
                              label: '',
                              hintText: '0.00',
                              controller: approvedWeightChargesController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$')),
                              ],
                              centerLabel: true,
                              showRupeeSymbol: true,
                              formatToTwoDecimals: true,
                              onTab: () {
                                if (approvedWeightChargesController.text ==
                                    '0.00') {
                                  approvedWeightChargesController.clear();
                                }
                              },
                              onChanged: (_) {
                                calculateTotals(
                                  actualMtExpensesController:
                                      actualMtExpensesController,
                                  approvedMtExpensesController:
                                      approvedMtExpensesController,
                                  actualTollController: actualTollController,
                                  approvedTollController:
                                      approvedTollController,
                                  actualDriverChargesController:
                                      actualDriverChargesController,
                                  approvedDriverChargesController:
                                      approvedDriverChargesController,
                                  actualCleanerChargesController:
                                      actualCleanerChargesController,
                                  approvedCleanerChargesController:
                                      approvedCleanerChargesController,
                                  actualRtoPoliceController:
                                      actualRtoPoliceController,
                                  approvedRtoPoliceController:
                                      approvedRtoPoliceController,
                                  actualHarbourExpensesController:
                                      actualHarbourExpensesController,
                                  approvedHarbourExpensesController:
                                      approvedHarbourExpensesController,
                                  actualDriverExpensesController:
                                      actualDriverExpensesController,
                                  approvedDriverExpensesController:
                                      approvedDriverExpensesController,
                                  actualWeightChargesController:
                                      actualWeightChargesController,
                                  approvedWeightChargesController:
                                      approvedWeightChargesController,
                                  actualLoadingChargesController:
                                      actualLoadingChargesController,
                                  approvedLoadingChargesController:
                                      approvedLoadingChargesController,
                                  actualUnloadingChargesController:
                                      actualUnloadingChargesController,
                                  approvedUnloadingChargesController:
                                      approvedUnloadingChargesController,
                                  actualOtherExpensesController:
                                      actualOtherExpensesController,
                                  approvedOtherExpensesController:
                                      approvedOtherExpensesController,
                                  actualTotalController: actualTotalController,
                                  approvedTotalController:
                                      approvedTotalController,
                                  actualAdvanceController:
                                      actualAdvanceController,
                                  approvedAdvanceController:
                                      approvedAdvanceController,
                                  actualBalanceController:
                                      actualBalanceController,
                                  approvedBalanceController:
                                      approvedBalanceController,
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: const Text(
                          'Loading Charges',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            hintText: '0.00',
                            controller: actualLoadingChargesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                            formatToTwoDecimals: true,
                            onChanged: (_) {
                              calculateTotals(
                                actualMtExpensesController:
                                    actualMtExpensesController,
                                approvedMtExpensesController:
                                    approvedMtExpensesController,
                                actualTollController: actualTollController,
                                approvedTollController: approvedTollController,
                                actualDriverChargesController:
                                    actualDriverChargesController,
                                approvedDriverChargesController:
                                    approvedDriverChargesController,
                                actualCleanerChargesController:
                                    actualCleanerChargesController,
                                approvedCleanerChargesController:
                                    approvedCleanerChargesController,
                                actualRtoPoliceController:
                                    actualRtoPoliceController,
                                approvedRtoPoliceController:
                                    approvedRtoPoliceController,
                                actualHarbourExpensesController:
                                    actualHarbourExpensesController,
                                approvedHarbourExpensesController:
                                    approvedHarbourExpensesController,
                                actualDriverExpensesController:
                                    actualDriverExpensesController,
                                approvedDriverExpensesController:
                                    approvedDriverExpensesController,
                                actualWeightChargesController:
                                    actualWeightChargesController,
                                approvedWeightChargesController:
                                    approvedWeightChargesController,
                                actualLoadingChargesController:
                                    actualLoadingChargesController,
                                approvedLoadingChargesController:
                                    approvedLoadingChargesController,
                                actualUnloadingChargesController:
                                    actualUnloadingChargesController,
                                approvedUnloadingChargesController:
                                    approvedUnloadingChargesController,
                                actualOtherExpensesController:
                                    actualOtherExpensesController,
                                approvedOtherExpensesController:
                                    approvedOtherExpensesController,
                                actualTotalController: actualTotalController,
                                approvedTotalController:
                                    approvedTotalController,
                                actualAdvanceController:
                                    actualAdvanceController,
                                approvedAdvanceController:
                                    approvedAdvanceController,
                                actualBalanceController:
                                    actualBalanceController,
                                approvedBalanceController:
                                    approvedBalanceController,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (isEmployer)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InputField(
                              label: '',
                              hintText: '0.00',
                              controller: approvedLoadingChargesController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$')),
                              ],
                              centerLabel: true,
                              showRupeeSymbol: true,
                              formatToTwoDecimals: true,
                              onTab: () {
                                if (approvedLoadingChargesController.text ==
                                    '0.00') {
                                  approvedLoadingChargesController.clear();
                                }
                              },
                              onChanged: (_) {
                                calculateTotals(
                                  actualMtExpensesController:
                                      actualMtExpensesController,
                                  approvedMtExpensesController:
                                      approvedMtExpensesController,
                                  actualTollController: actualTollController,
                                  approvedTollController:
                                      approvedTollController,
                                  actualDriverChargesController:
                                      actualDriverChargesController,
                                  approvedDriverChargesController:
                                      approvedDriverChargesController,
                                  actualCleanerChargesController:
                                      actualCleanerChargesController,
                                  approvedCleanerChargesController:
                                      approvedCleanerChargesController,
                                  actualRtoPoliceController:
                                      actualRtoPoliceController,
                                  approvedRtoPoliceController:
                                      approvedRtoPoliceController,
                                  actualHarbourExpensesController:
                                      actualHarbourExpensesController,
                                  approvedHarbourExpensesController:
                                      approvedHarbourExpensesController,
                                  actualDriverExpensesController:
                                      actualDriverExpensesController,
                                  approvedDriverExpensesController:
                                      approvedDriverExpensesController,
                                  actualWeightChargesController:
                                      actualWeightChargesController,
                                  approvedWeightChargesController:
                                      approvedWeightChargesController,
                                  actualLoadingChargesController:
                                      actualLoadingChargesController,
                                  approvedLoadingChargesController:
                                      approvedLoadingChargesController,
                                  actualUnloadingChargesController:
                                      actualUnloadingChargesController,
                                  approvedUnloadingChargesController:
                                      approvedUnloadingChargesController,
                                  actualOtherExpensesController:
                                      actualOtherExpensesController,
                                  approvedOtherExpensesController:
                                      approvedOtherExpensesController,
                                  actualTotalController: actualTotalController,
                                  approvedTotalController:
                                      approvedTotalController,
                                  actualAdvanceController:
                                      actualAdvanceController,
                                  approvedAdvanceController:
                                      approvedAdvanceController,
                                  actualBalanceController:
                                      actualBalanceController,
                                  approvedBalanceController:
                                      approvedBalanceController,
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: const Text(
                          'Unloading Charges',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            hintText: '0.00',
                            controller: actualUnloadingChargesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                            formatToTwoDecimals: true,
                            onChanged: (_) {
                              calculateTotals(
                                actualMtExpensesController:
                                    actualMtExpensesController,
                                approvedMtExpensesController:
                                    approvedMtExpensesController,
                                actualTollController: actualTollController,
                                approvedTollController: approvedTollController,
                                actualDriverChargesController:
                                    actualDriverChargesController,
                                approvedDriverChargesController:
                                    approvedDriverChargesController,
                                actualCleanerChargesController:
                                    actualCleanerChargesController,
                                approvedCleanerChargesController:
                                    approvedCleanerChargesController,
                                actualRtoPoliceController:
                                    actualRtoPoliceController,
                                approvedRtoPoliceController:
                                    approvedRtoPoliceController,
                                actualHarbourExpensesController:
                                    actualHarbourExpensesController,
                                approvedHarbourExpensesController:
                                    approvedHarbourExpensesController,
                                actualDriverExpensesController:
                                    actualDriverExpensesController,
                                approvedDriverExpensesController:
                                    approvedDriverExpensesController,
                                actualWeightChargesController:
                                    actualWeightChargesController,
                                approvedWeightChargesController:
                                    approvedWeightChargesController,
                                actualLoadingChargesController:
                                    actualLoadingChargesController,
                                approvedLoadingChargesController:
                                    approvedLoadingChargesController,
                                actualUnloadingChargesController:
                                    actualUnloadingChargesController,
                                approvedUnloadingChargesController:
                                    approvedUnloadingChargesController,
                                actualOtherExpensesController:
                                    actualOtherExpensesController,
                                approvedOtherExpensesController:
                                    approvedOtherExpensesController,
                                actualTotalController: actualTotalController,
                                approvedTotalController:
                                    approvedTotalController,
                                actualAdvanceController:
                                    actualAdvanceController,
                                approvedAdvanceController:
                                    approvedAdvanceController,
                                actualBalanceController:
                                    actualBalanceController,
                                approvedBalanceController:
                                    approvedBalanceController,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (isEmployer)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InputField(
                              label: '',
                              hintText: '0.00',
                              controller: approvedUnloadingChargesController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$')),
                              ],
                              centerLabel: true,
                              showRupeeSymbol: true,
                              formatToTwoDecimals: true,
                              onTab: () {
                                if (approvedUnloadingChargesController.text ==
                                    '0.00') {
                                  approvedUnloadingChargesController.clear();
                                }
                              },
                              onChanged: (_) {
                                calculateTotals(
                                  actualMtExpensesController:
                                      actualMtExpensesController,
                                  approvedMtExpensesController:
                                      approvedMtExpensesController,
                                  actualTollController: actualTollController,
                                  approvedTollController:
                                      approvedTollController,
                                  actualDriverChargesController:
                                      actualDriverChargesController,
                                  approvedDriverChargesController:
                                      approvedDriverChargesController,
                                  actualCleanerChargesController:
                                      actualCleanerChargesController,
                                  approvedCleanerChargesController:
                                      approvedCleanerChargesController,
                                  actualRtoPoliceController:
                                      actualRtoPoliceController,
                                  approvedRtoPoliceController:
                                      approvedRtoPoliceController,
                                  actualHarbourExpensesController:
                                      actualHarbourExpensesController,
                                  approvedHarbourExpensesController:
                                      approvedHarbourExpensesController,
                                  actualDriverExpensesController:
                                      actualDriverExpensesController,
                                  approvedDriverExpensesController:
                                      approvedDriverExpensesController,
                                  actualWeightChargesController:
                                      actualWeightChargesController,
                                  approvedWeightChargesController:
                                      approvedWeightChargesController,
                                  actualLoadingChargesController:
                                      actualLoadingChargesController,
                                  approvedLoadingChargesController:
                                      approvedLoadingChargesController,
                                  actualUnloadingChargesController:
                                      actualUnloadingChargesController,
                                  approvedUnloadingChargesController:
                                      approvedUnloadingChargesController,
                                  actualOtherExpensesController:
                                      actualOtherExpensesController,
                                  approvedOtherExpensesController:
                                      approvedOtherExpensesController,
                                  actualTotalController: actualTotalController,
                                  approvedTotalController:
                                      approvedTotalController,
                                  actualAdvanceController:
                                      actualAdvanceController,
                                  approvedAdvanceController:
                                      approvedAdvanceController,
                                  actualBalanceController:
                                      actualBalanceController,
                                  approvedBalanceController:
                                      approvedBalanceController,
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: const Text(
                          'Other Expenses',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            hintText: '0.00',
                            controller: actualOtherExpensesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                            formatToTwoDecimals: true,
                            onChanged: (_) {
                              calculateTotals(
                                actualMtExpensesController:
                                    actualMtExpensesController,
                                approvedMtExpensesController:
                                    approvedMtExpensesController,
                                actualTollController: actualTollController,
                                approvedTollController: approvedTollController,
                                actualDriverChargesController:
                                    actualDriverChargesController,
                                approvedDriverChargesController:
                                    approvedDriverChargesController,
                                actualCleanerChargesController:
                                    actualCleanerChargesController,
                                approvedCleanerChargesController:
                                    approvedCleanerChargesController,
                                actualRtoPoliceController:
                                    actualRtoPoliceController,
                                approvedRtoPoliceController:
                                    approvedRtoPoliceController,
                                actualHarbourExpensesController:
                                    actualHarbourExpensesController,
                                approvedHarbourExpensesController:
                                    approvedHarbourExpensesController,
                                actualDriverExpensesController:
                                    actualDriverExpensesController,
                                approvedDriverExpensesController:
                                    approvedDriverExpensesController,
                                actualWeightChargesController:
                                    actualWeightChargesController,
                                approvedWeightChargesController:
                                    approvedWeightChargesController,
                                actualLoadingChargesController:
                                    actualLoadingChargesController,
                                approvedLoadingChargesController:
                                    approvedLoadingChargesController,
                                actualUnloadingChargesController:
                                    actualUnloadingChargesController,
                                approvedUnloadingChargesController:
                                    approvedUnloadingChargesController,
                                actualOtherExpensesController:
                                    actualOtherExpensesController,
                                approvedOtherExpensesController:
                                    approvedOtherExpensesController,
                                actualTotalController: actualTotalController,
                                approvedTotalController:
                                    approvedTotalController,
                                actualAdvanceController:
                                    actualAdvanceController,
                                approvedAdvanceController:
                                    approvedAdvanceController,
                                actualBalanceController:
                                    actualBalanceController,
                                approvedBalanceController:
                                    approvedBalanceController,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (isEmployer)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InputField(
                              label: '',
                              hintText: '0.00',
                              controller: approvedOtherExpensesController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}$')),
                              ],
                              centerLabel: true,
                              showRupeeSymbol: true,
                              formatToTwoDecimals: true,
                              onTab: () {
                                if (approvedOtherExpensesController.text ==
                                    '0.00') {
                                  approvedOtherExpensesController.clear();
                                }
                              },
                              onChanged: (_) {
                                calculateTotals(
                                  actualMtExpensesController:
                                      actualMtExpensesController,
                                  approvedMtExpensesController:
                                      approvedMtExpensesController,
                                  actualTollController: actualTollController,
                                  approvedTollController:
                                      approvedTollController,
                                  actualDriverChargesController:
                                      actualDriverChargesController,
                                  approvedDriverChargesController:
                                      approvedDriverChargesController,
                                  actualCleanerChargesController:
                                      actualCleanerChargesController,
                                  approvedCleanerChargesController:
                                      approvedCleanerChargesController,
                                  actualRtoPoliceController:
                                      actualRtoPoliceController,
                                  approvedRtoPoliceController:
                                      approvedRtoPoliceController,
                                  actualHarbourExpensesController:
                                      actualHarbourExpensesController,
                                  approvedHarbourExpensesController:
                                      approvedHarbourExpensesController,
                                  actualDriverExpensesController:
                                      actualDriverExpensesController,
                                  approvedDriverExpensesController:
                                      approvedDriverExpensesController,
                                  actualWeightChargesController:
                                      actualWeightChargesController,
                                  approvedWeightChargesController:
                                      approvedWeightChargesController,
                                  actualLoadingChargesController:
                                      actualLoadingChargesController,
                                  approvedLoadingChargesController:
                                      approvedLoadingChargesController,
                                  actualUnloadingChargesController:
                                      actualUnloadingChargesController,
                                  approvedUnloadingChargesController:
                                      approvedUnloadingChargesController,
                                  actualOtherExpensesController:
                                      actualOtherExpensesController,
                                  approvedOtherExpensesController:
                                      approvedOtherExpensesController,
                                  actualTotalController: actualTotalController,
                                  approvedTotalController:
                                      approvedTotalController,
                                  actualAdvanceController:
                                      actualAdvanceController,
                                  approvedAdvanceController:
                                      approvedAdvanceController,
                                  actualBalanceController:
                                      actualBalanceController,
                                  approvedBalanceController:
                                      approvedBalanceController,
                                );
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: const Text(
                          'Total',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            hintText: '0.00',
                            controller: actualTotalController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                            formatToTwoDecimals: true,
                            readOnly: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      if (isEmployer)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InputField(
                              label: '',
                              hintText: '0.00',
                              controller: approvedTotalController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              centerLabel: true,
                              showRupeeSymbol: true,
                              formatToTwoDecimals: true,
                              readOnly: true,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (isEmployer)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: const Text(
                            'Advance',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(), // Push inputs to the right side
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InputField(
                              label: '',
                              hintText: '0.00',
                              controller: actualAdvanceController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              centerLabel: true,
                              showRupeeSymbol: true,
                              formatToTwoDecimals: true,
                              readOnly: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InputField(
                              label: '',
                              hintText: '0.00',
                              controller: approvedAdvanceController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              centerLabel: true,
                              showRupeeSymbol: true,
                              formatToTwoDecimals: true,
                              readOnly: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),
                  if (isEmployer)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: const Text(
                            'Balance',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InputField(
                              label: '',
                              hintText: '0.00',
                              controller: actualBalanceController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              centerLabel: true,
                              showRupeeSymbol: true,
                              formatToTwoDecimals: true,
                              readOnly: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InputField(
                              label: '',
                              hintText: '0.00',
                              controller: approvedBalanceController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              centerLabel: true,
                              showRupeeSymbol: true,
                              formatToTwoDecimals: true,
                              readOnly: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),
                  // Conditionally show "Verified By" field only for Employers
                  if (isEmployer)
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Verified By',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.60,
                              child: InputField(
                                label: '',
                                hintText: 'Enter Verified By Name',
                                controller: verifiedByController,
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),
                  if (isEmployer)
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Passed',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.60,
                              child: InputField(
                                label: '',
                                hintText: 'Enter Passed By Name',
                                controller: passedByController,
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),
                  if (isEmployer)
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Driver',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.60,
                              child: InputField(
                                label: '',
                                controller: driverNameController,
                                keyboardType: TextInputType.text,
                                readOnly: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  // Submit button
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        int? tripSheetNo;
                        if (isEmployer) {
                          tripSheetNo = int.tryParse(controllers[0].text);
                          if (tripSheetNo == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'No. is required for updating!',
                                ),
                              ),
                            );
                            return;
                          }
                        }
                        submitHandler.handleSubmit(
                          context,
                          _formKey,
                          controllers,
                          isEmployer, // Pass whether the user is an employer or employee
                          tripSheetNo, // Pass the 'no' value if updating or null for creating
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
