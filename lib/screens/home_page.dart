import 'package:database_app/utils/calculations.dart';
import 'package:database_app/utils/submit_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:database_app/widgets/header_section.dart';
import 'package:database_app/widgets/input_field.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:database_app/authentication/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = Auth().currentUser;

  Future<void> _signOut(BuildContext context) async {
    await Auth().signOut();
    Navigator.of(context).pushReplacementNamed('/');
  }

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
                user?.email ?? user?.phoneNumber ?? 'User Info',
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
            onPressed: () => _signOut(context),
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
                              FilteringTextInputFormatter.digitsOnly
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d{0,2}$'),
                              ),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$')),
                            ],
                            centerLabel: true,
                            showRupeeSymbol: true,
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
                            readOnly: true,
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
                            controller: approvedBalanceController,
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
                      onPressed: () {
                        submitHandler.handleSubmit(
                            context, _formKey, controllers);
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
