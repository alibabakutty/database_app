import 'package:flutter/material.dart';
import '../models/trip_sheet.dart';
import '../services/firebase_service.dart';

class SubmitHandler {
  final FirebaseService _firebaseService = FirebaseService();

  Future<void> handleSubmit(
    BuildContext context,
    GlobalKey<FormState> formKey,
    List<TextEditingController> controllers,
  ) async {
    if (formKey.currentState!.validate()) {
      try {
        // Convert displayed date (dd-MM-yyyy) to backend format (yyyy-MM-dd)
        List<String> parts = controllers[2].text.split('-');
        String formattedDate = '${parts[2]}-${parts[1]}-${parts[0]}';

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
          approvedMtExpenses: _parseDouble(
              controllers[14].text, 'Approved MT Expenses', context),
          actualToll:
              _parseDouble(controllers[15].text, 'Actual Toll', context),
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
              _parseDouble(controllers[21].text, 'Actual RTO Police', context),
          approvedRtoPolice: _parseDouble(
              controllers[22].text, 'Approved RTO Police', context),
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
          timestamp: DateTime.now(),
        );

        bool success = await _firebaseService.addTripSheet(newTripSheet);

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Form submitted successfully!')),
          );
          _clearForm(controllers);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error submitting form!')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all the fields.')),
      );
    }
  }

  int _parseInt(String value, String fieldName, BuildContext context) {
    final int? parsedValue = int.tryParse(value);
    if (parsedValue == null) {
      throw Exception('Invalid $fieldName.');
    }
    return parsedValue;
  }

  double _parseDouble(String value, String fieldName, BuildContext context) {
    final double? parsedValue = double.tryParse(value);
    if (parsedValue == null) {
      throw Exception('Invalid $fieldName.');
    }
    return parsedValue;
  }

  void _clearForm(List<TextEditingController> controllers) {
    for (var controller in controllers) {
      controller.clear();
    }
  }
}
