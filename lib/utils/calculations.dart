import 'package:flutter/material.dart';

void calculateTotals({
  required TextEditingController actualMtExpensesController,
  required TextEditingController approvedMtExpensesController,
  required TextEditingController actualTollController,
  required TextEditingController approvedTollController,
  required TextEditingController actualDriverChargesController,
  required TextEditingController approvedDriverChargesController,
  required TextEditingController actualCleanerChargesController,
  required TextEditingController approvedCleanerChargesController,
  required TextEditingController actualRtoPoliceController,
  required TextEditingController approvedRtoPoliceController,
  required TextEditingController actualHarbourExpensesController,
  required TextEditingController approvedHarbourExpensesController,
  required TextEditingController actualDriverExpensesController,
  required TextEditingController approvedDriverExpensesController,
  required TextEditingController actualWeightChargesController,
  required TextEditingController approvedWeightChargesController,
  required TextEditingController actualLoadingChargesController,
  required TextEditingController approvedLoadingChargesController,
  required TextEditingController actualUnloadingChargesController,
  required TextEditingController approvedUnloadingChargesController,
  required TextEditingController actualOtherExpensesController,
  required TextEditingController approvedOtherExpensesController,
  required TextEditingController actualTotalController,
  required TextEditingController approvedTotalController,
  required TextEditingController actualAdvanceController,
  required TextEditingController approvedAdvanceController,
  required TextEditingController actualBalanceController,
  required TextEditingController approvedBalanceController,
}) {
  double actutalTotal = 0.0;
  double approvedTotal = 0.0;

  actutalTotal += _parseToDouble(actualMtExpensesController.text);
  approvedTotal += _parseToDouble(approvedMtExpensesController.text);
  actutalTotal += _parseToDouble(actualTollController.text);
  approvedTotal += _parseToDouble(approvedTollController.text);
  actutalTotal += _parseToDouble(actualDriverChargesController.text);
  approvedTotal += _parseToDouble(approvedDriverChargesController.text);
  actutalTotal += _parseToDouble(actualCleanerChargesController.text);
  approvedTotal += _parseToDouble(approvedCleanerChargesController.text);
  actutalTotal += _parseToDouble(actualRtoPoliceController.text);
  approvedTotal += _parseToDouble(approvedRtoPoliceController.text);
  actutalTotal += _parseToDouble(actualHarbourExpensesController.text);
  approvedTotal += _parseToDouble(approvedHarbourExpensesController.text);
  actutalTotal += _parseToDouble(actualDriverExpensesController.text);
  approvedTotal += _parseToDouble(approvedDriverExpensesController.text);
  actutalTotal += _parseToDouble(actualWeightChargesController.text);
  approvedTotal += _parseToDouble(approvedWeightChargesController.text);
  actutalTotal += _parseToDouble(actualLoadingChargesController.text);
  approvedTotal += _parseToDouble(approvedLoadingChargesController.text);
  actutalTotal += _parseToDouble(actualUnloadingChargesController.text);
  approvedTotal += _parseToDouble(approvedUnloadingChargesController.text);
  actutalTotal += _parseToDouble(actualOtherExpensesController.text);
  approvedTotal += _parseToDouble(approvedOtherExpensesController.text);

  actualTotalController.text = actutalTotal.toStringAsFixed(2);
  approvedTotalController.text = approvedTotal.toStringAsFixed(2);

  double actualAdvance = _parseToDouble(actualAdvanceController.text);
  double approvedAdvance = _parseToDouble(approvedAdvanceController.text);

  actualBalanceController.text =
      (actualAdvance - actutalTotal).abs().toStringAsFixed(2);
  approvedBalanceController.text =
      (approvedAdvance - approvedTotal).abs().toStringAsFixed(2);
}

double _parseToDouble(String value) {
  return double.tryParse(value) ?? 0.0;
}
