// lib/screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:database_app/widgets/header_section.dart';
import 'package:database_app/widgets/input_field.dart';
import 'package:database_app/services/firebase_service.dart';
import 'package:database_app/models/trip_sheet.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

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
  final actualOtherExpensesController = TextEditingController();
  final approvedOtherExpensesController = TextEditingController();
  final actualTotalController = TextEditingController();
  final approvedTotalController = TextEditingController();
  final actualBalanceController = TextEditingController();
  final approvedBalanceController = TextEditingController();
  final verifiedByController = TextEditingController();
  final passedByController = TextEditingController();

  final FirebaseService _firebaseService = FirebaseService();

  void _handleSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Convert displayed date (dd-MM-yyyy) to backend format (yyyy-MM-dd)
      try {
        List<String> parts = dateController.text.split('-');
        String formattedDate = '${parts[2]}-${parts[1]}-${parts[0]}';

        // Safe parsing for 'No.' field
        int? parsedNo = int.tryParse(noController.text);
        if (parsedNo == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid No. field!')),
          );
          return;
        }

        // Format liters to 3 decimal places
        double liters = double.tryParse(litersController.text) ?? 0.0;
        String formattedLiters = liters.toStringAsFixed(3);

        // Safe parsing for 'Amount' field
        double? parsedAmount = double.tryParse(amountController.text);
        if (parsedAmount == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid Amount field!')),
          );
          return;
        }

        // Safe parsing for 'actual Advance' field
        double? parsedActualAdvance =
            double.tryParse(actualAdvanceController.text);
        if (parsedActualAdvance == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid Actual Advance field!')),
          );
          return;
        }

        // Safe parsing for 'approved Advance' field
        double? parsedApprovedAdvance =
            double.tryParse(approvedAdvanceController.text);
        if (parsedApprovedAdvance == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid Approved Advance field!')),
          );
          return;
        }

        // Safe parsing for 'actual M.T.Expenses' field
        double? parsedActualMtExpenses =
            double.tryParse(actualMtExpensesController.text);
        if (parsedActualMtExpenses == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid Actual M.T.Expenses field!')),
          );
          return;
        }

        // Safe parsing for 'approved M.T.Expenses' field
        double? parsedApprovedMtExpenses =
            double.tryParse(approvedMtExpensesController.text);
        if (parsedApprovedMtExpenses == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Invalid Approved M.T.Expenses field!')),
          );
          return;
        }

        // Safe parsing for 'actual Toll' field
        double? parsedActualToll = double.tryParse(actualTollController.text);
        if (parsedActualToll == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid Actual Toll field!')),
          );
          return;
        }

        // Safe parsing for 'approved Toll' field
        double? parsedApprovedToll =
            double.tryParse(approvedTollController.text);
        if (parsedApprovedToll == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid Approved Toll field!')),
          );
          return;
        }

        // Safe parsing for 'actual Driver Charges' field
        double? parsedActualDriverCharges =
            double.tryParse(actualDriverChargesController.text);
        if (parsedActualDriverCharges == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Invalid Actual Driver Charges field!')),
          );
          return;
        }

        // Safe parsing for 'approved Driver Charges' field
        double? parsedApprovedDriverCharges =
            double.tryParse(approvedDriverChargesController.text);
        if (parsedApprovedDriverCharges == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Invalid Approved Driver Charges field!')),
          );
          return;
        }

        // Safe parsing for 'actual Cleaner Charges' field
        double? parsedActualCleanerCharges =
            double.tryParse(actualCleanerChargesController.text);
        if (parsedActualCleanerCharges == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Invalid Actual Cleaner Charges field!')),
          );
          return;
        }

        // Safe parsing for 'approved Cleaner Charges' field
        double? parsedApprovedCleanerCharges =
            double.tryParse(approvedCleanerChargesController.text);
        if (parsedApprovedCleanerCharges == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Invalid Approved Cleaner Charges field!')),
          );
          return;
        }

        // Safe parsing for 'actual R.T.O' field
        double? parsedActualRto =
            double.tryParse(actualRtoPoliceController.text);
        if (parsedActualRto == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid Actual R.T.O field!')),
          );
          return;
        }

        // Safe parsing for 'approved R.T.O' field
        double? parsedApprovedRto =
            double.tryParse(approvedRtoPoliceController.text);
        if (parsedApprovedRto == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid Approved R.T.O field!')),
          );
          return;
        }

        // Safe parsing for 'actual Hrbour Expenses' field
        double? parsedActualHarbour =
            double.tryParse(actualHarbourExpensesController.text);
        if (parsedActualHarbour == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Invalid Actual Harbour Expenses field!')),
          );
          return;
        }

        // Safe parsing for 'approved Harbour Expenses' field
        double? parsedApprovedHarbour =
            double.tryParse(approvedHarbourExpensesController.text);
        if (parsedApprovedHarbour == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Invalid Approved Harbour Expenses field!')),
          );
          return;
        }

        // Safe parsing for 'actual Driver Expenses' field
        double? parsedActualDriverExpenses =
            double.tryParse(actualDriverExpensesController.text);
        if (parsedActualDriverExpenses == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Invalid Actual Driver Expenses field!')),
          );
          return;
        }

        // Safe parsing for 'approved Driver Expenses' field
        double? parsedApprovedDriverExpenses =
            double.tryParse(approvedDriverExpensesController.text);
        if (parsedApprovedDriverExpenses == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Invalid Approved Driver Expenses field!')),
          );
          return;
        }

        // Safe parsing for 'actual Weight Charges' field
        double? parsedActualWeightCharges =
            double.tryParse(actualWeightChargesController.text);
        if (parsedActualWeightCharges == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Invalid Actual Weight Charges field!')),
          );
          return;
        }

        // Safe parsing for 'approved Weight Charges' field
        double? parsedApprovedWeightCharges =
            double.tryParse(approvedWeightChargesController.text);
        if (parsedApprovedWeightCharges == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Invalid Approved Weight Charges field!')),
          );
          return;
        }

        // Safe parsing for 'actual Loading Charges' field
        double? parsedActualLoadingCharges =
            double.tryParse(actualLoadingChargesController.text);
        if (parsedActualLoadingCharges == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Invalid Actual Loading Charges field!')),
          );
          return;
        }

        // Safe parsing for 'approved Loading Charges' field
        double? parsedApprovedLoadingCharges =
            double.tryParse(approvedLoadingChargesController.text);
        if (parsedApprovedLoadingCharges == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Invalid Approved Loading Charges field!')),
          );
          return;
        }

        // Safe parsing for 'actual Unloading Charges' field
        double? parsedActualUnloadingCharges =
            double.tryParse(actualUnloadingChargesController.text);
        if (parsedActualUnloadingCharges == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Invalid Actual Unloading Charges field!')),
          );
          return;
        }

        // Safe parsing for 'approved Unloading Charges' field
        double? parsedApprovedUnloadingCharges =
            double.tryParse(approvedUnloadingChargesController.text);
        if (parsedApprovedUnloadingCharges == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Invalid Approved Unloading Charges field!')),
          );
          return;
        }

        // Safe parsing for 'actual Other Expenses' field
        double? parsedActualOtherExpenses =
            double.tryParse(actualOtherExpensesController.text);
        if (parsedActualOtherExpenses == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Invalid Actual Other Expenses field!')),
          );
          return;
        }

        // Safe parsing for 'approved Other Expenses' field
        double? parsedApprovedOtherExpenses =
            double.tryParse(approvedOtherExpensesController.text);
        if (parsedApprovedOtherExpenses == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Invalid Approved Other Expenses field!')),
          );
          return;
        }

        // Safe parsing for 'actual Total' field
        double? parsedActualTotal = double.tryParse(actualTotalController.text);
        if (parsedActualTotal == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid Actual Total field!')),
          );
          return;
        }

        // Safe parsing for 'approved Total' field
        double? parsedApprovedTotal =
            double.tryParse(approvedTotalController.text);
        if (parsedApprovedTotal == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid Approved Total field!')),
          );
          return;
        }

        // Safe parsing for 'actual Balance' field
        double? parsedActualBalance =
            double.tryParse(actualBalanceController.text);
        if (parsedActualBalance == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid Actual Balance field!')),
          );
          return;
        }

        // Safe parsing for 'approved Balance' field
        double? parsedApprovedBalance =
            double.tryParse(approvedBalanceController.text);
        if (parsedApprovedBalance == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid Approved Balance field!')),
          );
          return;
        }

        TripSheet newTripSheet = TripSheet(
          no: parsedNo,
          jobNo: jobNoController.text,
          date: DateTime.parse(formattedDate),
          timestamp: DateTime.now(),
          vehicleNo: vehicleNoController.text,
          fromLocation: fromLocationController.text,
          toLocation: toLocationController.text,
          liters: double.parse(formattedLiters),
          amount: parsedAmount,
          driverName: driverNameController.text,
          cleanerName: cleanerNameController.text,
          containerNo: containerNoController.text,
          actualAdvance: parsedActualAdvance,
          approvedAdvance: parsedApprovedAdvance,
          actualMtExpenses: parsedActualMtExpenses,
          approvedMtExpenses: parsedApprovedMtExpenses,
          actualToll: parsedActualToll,
          approvedToll: parsedApprovedToll,
          actualDriverCharges: parsedActualDriverCharges,
          approvedDriverCharges: parsedApprovedDriverCharges,
          actualCleanerCharges: parsedActualCleanerCharges,
          approvedCleanerCharges: parsedApprovedCleanerCharges,
          actualRtoPolice: parsedActualRto,
          approvedRtoPolice: parsedApprovedRto,
          actualHarbourExpenses: parsedActualHarbour,
          approvedHarbourExpenses: parsedApprovedHarbour,
          actualDriverExpenses: parsedActualDriverExpenses,
          approvedDriverExpenses: parsedApprovedDriverExpenses,
          actualWeightCharges: parsedActualWeightCharges,
          approvedWeightCharges: parsedApprovedWeightCharges,
          actualLoadingCharges: parsedActualLoadingCharges,
          approvedLoadingCharges: parsedApprovedLoadingCharges,
          actualUnloadingCharges: parsedActualUnloadingCharges,
          approvedUnloadingCharges: parsedApprovedUnloadingCharges,
          actualOtherExpenses: parsedActualOtherExpenses,
          approvedOtherExpenses: parsedApprovedOtherExpenses,
          actualTotal: parsedActualTotal,
          approvedTotal: parsedApprovedTotal,
          actualBalance: parsedActualBalance,
          approvedBalance: parsedApprovedBalance,
          verifiedBy: verifiedByController.text,
          passedBy: passedByController.text,
        );

        bool success = await _firebaseService.addTripSheet(newTripSheet);

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Form submitted successfully!')),
          );
          noController.clear();
          jobNoController.clear();
          dateController.clear();
          vehicleNoController.clear();
          fromLocationController.clear();
          toLocationController.clear();
          litersController.clear();
          amountController.clear();
          driverNameController.clear();
          cleanerNameController.clear();
          containerNoController.clear();
          actualAdvanceController.clear();
          approvedAdvanceController.clear();
          actualMtExpensesController.clear();
          approvedMtExpensesController.clear();
          actualTollController.clear();
          approvedTollController.clear();
          actualDriverChargesController.clear();
          approvedDriverChargesController.clear();
          actualCleanerChargesController.clear();
          approvedCleanerChargesController.clear();
          actualRtoPoliceController.clear();
          approvedRtoPoliceController.clear();
          actualHarbourExpensesController.clear();
          approvedHarbourExpensesController.clear();
          actualDriverExpensesController.clear();
          approvedDriverExpensesController.clear();
          actualWeightChargesController.clear();
          approvedWeightChargesController.clear();
          actualLoadingChargesController.clear();
          approvedLoadingChargesController.clear();
          actualUnloadingChargesController.clear();
          approvedUnloadingChargesController.clear();
          actualOtherExpensesController.clear();
          approvedOtherExpensesController.clear();
          actualTotalController.clear();
          approvedTotalController.clear();
          actualBalanceController.clear();
          approvedBalanceController.clear();
          verifiedByController.clear();
          passedByController.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error submitting the form!')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid date format!')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trip Sheet Entry',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
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
                                0.62, // 50% of screen width
                            child: InputField(
                              label: '',
                              controller: noController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
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
                            width: MediaQuery.of(context).size.width * 0.62,
                            child: InputField(
                              label: '',
                              controller: jobNoController,
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
                            'Date',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.62,
                            child: InputField(
                              label: '',
                              controller: dateController,
                              keyboardType: TextInputType.datetime,
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
                            width: MediaQuery.of(context).size.width * 0.62,
                            child: InputField(
                              label: '',
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
                            width: MediaQuery.of(context).size.width * 0.62,
                            child: InputField(
                              label: '',
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
                            width: MediaQuery.of(context).size.width * 0.62,
                            child: InputField(
                              label: '',
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
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: 'Liters',
                            controller: litersController,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,3}'))
                            ],
                            centerLabel: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16), // Space between inputs
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: 'Amount',
                            controller: amountController,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                            width: MediaQuery.of(context).size.width * 0.62,
                            child: InputField(
                              label: '',
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
                            width: MediaQuery.of(context).size.width * 0.62,
                            child: InputField(
                              label: '',
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
                            width: MediaQuery.of(context).size.width * 0.62,
                            child: InputField(
                              label: '',
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
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: 'Actual',
                            controller: actualAdvanceController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: 'Approved',
                            controller: approvedAdvanceController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: actualMtExpensesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: approvedMtExpensesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: actualTollController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: approvedTollController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: actualDriverChargesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: approvedDriverChargesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: actualCleanerChargesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: approvedCleanerChargesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: actualRtoPoliceController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: approvedRtoPoliceController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: actualHarbourExpensesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: approvedHarbourExpensesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: actualDriverExpensesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: approvedDriverExpensesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: actualWeightChargesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: approvedWeightChargesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: actualLoadingChargesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: approvedLoadingChargesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: actualUnloadingChargesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: approvedUnloadingChargesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: actualOtherExpensesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: approvedOtherExpensesController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: actualTotalController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: approvedTotalController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                          'Advance',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(), // Push inputs to the right side
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: actualAdvanceController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                            readOnly: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: approvedAdvanceController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                            readOnly: true,
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
                          'Balance',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: actualBalanceController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.265,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InputField(
                            label: '',
                            controller: approvedBalanceController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                            'Verified By',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.62,
                            child: InputField(
                              label: '',
                              controller: verifiedByController,
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
                            'Passed',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.62,
                            child: InputField(
                              label: '',
                              controller: passedByController,
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
                            'Driver',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.62,
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
                      onPressed: () => _handleSubmit(context),
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
