import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/trip_sheet.dart';
import '../services/firebase_service.dart';

class SubmitHandler {
  final FirebaseService _firebaseService = FirebaseService();
  // Handle submit based on the login type (employee or employer)
  Future<void> handleSubmit(
    BuildContext context,
    GlobalKey<FormState> formKey,
    List<TextEditingController> controllers,
    bool
        isEmployer, // Add a parameter to distinguish between employee and employer
    int? no,
  ) async {
    if (formKey.currentState!.validate()) {
      if (isEmployer) {
        // Employer specific logic (update)
        if (no != null) {
          await _updateSubmit(context, controllers, no);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No. is required for update.')),
          );
        }
      } else {
        // Employee specific logic (create)
        await _createSubmit(context, controllers);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all the fields.')),
      );
    }
  }

  // Create submit for employee
  Future<void> _createSubmit(
    BuildContext context,
    List<TextEditingController> controllers,
  ) async {
    try {
      // Convert displayed date (dd-MM-yyyy) to backend format (yyyy-MM-dd)
      List<String> dateParts = controllers[2].text.split('-');
      final String formattedDate =
          '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}';

      TripSheet newTripSheet = TripSheet(
        no: _parseInt(controllers[0].text, 'No.', context),
        jobNo: controllers[1].text,
        date: DateTime.parse(formattedDate),
        vehicleNo: controllers[3].text,
        fromLocation: controllers[4].text,
        toLocation: controllers[5].text,
        liters: _parseDouble(controllers[6].text, 'Liters', context),
        amount: _parseDouble(controllers[7].text, 'Amount', context),
        driverName: controllers[8].text,
        cleanerName: controllers[9].text,
        containerNo: controllers[10].text,
        actualAdvance:
            _parseDouble(controllers[11].text, 'Actual Advance', context),
        approvedAdvance:
            _parseDouble(controllers[12].text, 'Approved Advance', context),
        actualMtExpenses:
            _parseDouble(controllers[13].text, 'Actual MT Expenses', context),
        approvedMtExpenses:
            _parseDouble(controllers[14].text, 'Approved MT Expenses', context),
        actualToll: _parseDouble(controllers[15].text, 'Actual Toll', context),
        approvedToll:
            _parseDouble(controllers[16].text, 'Approved Toll', context),
        actualDriverCharges: _parseDouble(
            controllers[17].text, 'Actual Driver Charges', context),
        approvedDriverCharges: _parseDouble(
            controllers[18].text, 'Approved Driver Charges', context),
        actualCleanerCharges: _parseDouble(
            controllers[19].text, 'Actual Cleaner Charges', context),
        approvedCleanerCharges: _parseDouble(
            controllers[20].text, 'Approved Cleaner Charges', context),
        actualRtoPolice:
            _parseDouble(controllers[21].text, 'Actual RTO/Police', context),
        approvedRtoPolice:
            _parseDouble(controllers[22].text, 'Approved RTO/Police', context),
        actualHarbourExpenses: _parseDouble(
            controllers[23].text, 'Actual Harbour Expenses', context),
        approvedHarbourExpenses: _parseDouble(
            controllers[24].text, 'Approved Harbour Expenses', context),
        actualDriverExpenses: _parseDouble(
            controllers[25].text, 'Actual Driver Expenses', context),
        approvedDriverExpenses: _parseDouble(
            controllers[26].text, 'Approved Driver Expenses', context),
        actualWeightCharges: _parseDouble(
            controllers[27].text, 'Actual Weight Charges', context),
        approvedWeightCharges: _parseDouble(
            controllers[28].text, 'Approved Weight Charges', context),
        actualLoadingCharges: _parseDouble(
            controllers[29].text, 'Actual Loading Charges', context),
        approvedLoadingCharges: _parseDouble(
            controllers[30].text, 'Approved Loading Charges', context),
        actualUnloadingCharges: _parseDouble(
            controllers[31].text, 'Actual Unloading Charges', context),
        approvedUnloadingCharges: _parseDouble(
            controllers[32].text, 'Approved Unloading Charges', context),
        actualOtherExpenses: _parseDouble(
            controllers[33].text, 'Actual Other Expenses', context),
        approvedOtherExpenses: _parseDouble(
            controllers[34].text, 'Approved Other Expenses', context),
        actualTotal:
            _parseDouble(controllers[35].text, 'Actual Total', context),
        approvedTotal:
            _parseDouble(controllers[36].text, 'Approved Total', context),
        actualBalance:
            _parseDouble(controllers[37].text, 'Actual Balance', context),
        approvedBalance:
            _parseDouble(controllers[38].text, 'Approved Balance', context),
        verifiedBy: controllers[39].text,
        passedBy: controllers[40].text,
        isApproved: false,
        isEmployer: false,
        timestamp: DateTime.now(),
      );
      bool success = await _firebaseService.addTripSheet(newTripSheet);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Trip sheet added successfully.')),
        );
        _clearForm(controllers);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add trip sheet.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  // Update submit for employer
  Future<void> _updateSubmit(
    BuildContext context,
    List<TextEditingController> controllers,
    int no,
  ) async {
    try {
      Map<String, dynamic> updatedData = {
        'job_no': controllers[1].text,
        'date': DateFormat('dd-MM-yyyy').parse(controllers[2].text),
        'vehicle_no': controllers[3].text,
        'from_location': controllers[4].text,
        'to_location': controllers[5].text,
        'liters': _parseDouble(controllers[6].text, 'Liters', context),
        'amount': _parseDouble(controllers[7].text, 'Amount', context),
        'driver_name': controllers[8].text,
        'cleaner_name': controllers[9].text,
        'container_no': controllers[10].text,
        'actual_advance':
            _parseDouble(controllers[11].text, 'Actual Advance', context),
        'approved_advance':
            _parseDouble(controllers[12].text, 'Approved Advance', context),
        'actual_mt_expenses':
            _parseDouble(controllers[13].text, 'Actual MT Expenses', context),
        'approved_mt_expenses':
            _parseDouble(controllers[14].text, 'Approved MT Expenses', context),
        'actual_toll':
            _parseDouble(controllers[15].text, 'Actual Toll', context),
        'approved_toll':
            _parseDouble(controllers[16].text, 'Approved Toll', context),
        'actual_driver_charges': _parseDouble(
            controllers[17].text, 'Actual Driver Charges', context),
        'approved_driver_charges': _parseDouble(
            controllers[18].text, 'Approved Driver Charges', context),
        'actual_cleaner_charges': _parseDouble(
            controllers[19].text, 'Actual Cleaner Charges', context),
        'approved_cleaner_charges': _parseDouble(
            controllers[20].text, 'Approved Cleaner Charges', context),
        'actual_rto_police':
            _parseDouble(controllers[21].text, 'Actual RTO/Police', context),
        'approved_rto_police':
            _parseDouble(controllers[22].text, 'Approved RTO/Police', context),
        'actual_harbour_expenses': _parseDouble(
            controllers[23].text, 'Actual Harbour Expenses', context),
        'approved_harbour_expenses': _parseDouble(
            controllers[24].text, 'Approved Harbour Expenses', context),
        'actual_driver_expenses': _parseDouble(
            controllers[25].text, 'Actual Driver Expenses', context),
        'approved_driver_expenses': _parseDouble(
            controllers[26].text, 'Approved Driver Expenses', context),
        'actual_weight_charges': _parseDouble(
            controllers[27].text, 'Actual Weight Charges', context),
        'approved_weight_charges': _parseDouble(
            controllers[28].text, 'Approved Weight Charges', context),
        'actual_loading_charges': _parseDouble(
            controllers[29].text, 'Actual Loading Charges', context),
        'approved_loading_charges': _parseDouble(
            controllers[30].text, 'Approved Loading Charges', context),
        'actual_unloading_charges': _parseDouble(
            controllers[31].text, 'Actual Unloading Charges', context),
        'approved_unloading_charges': _parseDouble(
            controllers[32].text, 'Approved Unloading Charges', context),
        'actual_other_expenses': _parseDouble(
            controllers[33].text, 'Actual Other Expenses', context),
        'approved_other_expenses': _parseDouble(
            controllers[34].text, 'Approved Other Expenses', context),
        'actual_total':
            _parseDouble(controllers[35].text, 'Actual Total', context),
        'approved_total':
            _parseDouble(controllers[36].text, 'Approved Total', context),
        'actual_balance':
            _parseDouble(controllers[37].text, 'Actual Balance', context),
        'approved_balance':
            _parseDouble(controllers[38].text, 'Approved Balance', context),
        'verified_by': controllers[39].text,
        'passed_by': controllers[40].text,
        'is_approved': true,
        'is_employer': true,
      };

      bool success = await _firebaseService.updateTripSheet(no, updatedData);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Trip sheet updated successfully.')),
        );
        _clearForm(controllers);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update trip sheet.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  int _parseInt(String value, String fieldName, BuildContext context) {
    final int? parsedValue = int.tryParse(value);
    if (parsedValue == null) {
      throw Exception('Invalid $fieldName');
    }
    return parsedValue;
  }

  double _parseDouble(String value, String fieldName, BuildContext context) {
    // Remove commas from the string before parsing
    String sanitizedValue = value.replaceAll(',', '');
    final double? parsedValue = double.tryParse(sanitizedValue);
    return parsedValue ?? 0.00;
  }

  void _clearForm(List<TextEditingController> controllers) {
    for (var controller in controllers) {
      controller.clear();
    }
  }
}
