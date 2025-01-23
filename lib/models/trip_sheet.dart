import 'package:cloud_firestore/cloud_firestore.dart';

class TripSheet {
  final int no;
  final String jobNo;
  final DateTime date;
  final String vehicleNo;
  final String fromLocation;
  final String toLocation;
  final double liters;
  final double amount;
  final String driverName;
  final String cleanerName;
  final String containerNo;
  final double actualAdvance;
  final double approvedAdvance;
  final double actualMtExpenses;
  final double approvedMtExpenses;
  final double actualToll;
  final double approvedToll;
  final double actualDriverCharges;
  final double approvedDriverCharges;
  final double actualCleanerCharges;
  final double approvedCleanerCharges;
  final double actualRtoPolice;
  final double approvedRtoPolice;
  final double actualHarbourExpenses;
  final double approvedHarbourExpenses;
  final double actualDriverExpenses;
  final double approvedDriverExpenses;
  final double actualWeightCharges;
  final double approvedWeightCharges;
  final double actualLoadingCharges;
  final double approvedLoadingCharges;
  final double actualUnloadingCharges;
  final double approvedUnloadingCharges;
  final double actualOtherExpenses;
  final double approvedOtherExpenses;
  final double actualTotal;
  final double approvedTotal;
  final double actualBalance;
  final double approvedBalance;
  final String verifiedBy;
  final String passedBy;
  final DateTime timestamp;

  TripSheet({
    required this.no,
    required this.jobNo,
    required this.date,
    required this.vehicleNo,
    required this.fromLocation,
    required this.toLocation,
    required this.liters,
    required this.amount,
    required this.driverName,
    required this.cleanerName,
    required this.containerNo,
    required this.actualAdvance,
    required this.approvedAdvance,
    required this.actualMtExpenses,
    required this.approvedMtExpenses,
    required this.actualToll,
    required this.approvedToll,
    required this.actualDriverCharges,
    required this.approvedDriverCharges,
    required this.actualCleanerCharges,
    required this.approvedCleanerCharges,
    required this.actualRtoPolice,
    required this.approvedRtoPolice,
    required this.actualHarbourExpenses,
    required this.approvedHarbourExpenses,
    required this.actualDriverExpenses,
    required this.approvedDriverExpenses,
    required this.actualWeightCharges,
    required this.approvedWeightCharges,
    required this.actualLoadingCharges,
    required this.approvedLoadingCharges,
    required this.actualUnloadingCharges,
    required this.approvedUnloadingCharges,
    required this.actualOtherExpenses,
    required this.approvedOtherExpenses,
    required this.actualTotal,
    required this.approvedTotal,
    required this.actualBalance,
    required this.approvedBalance,
    required this.verifiedBy,
    required this.passedBy,
    required this.timestamp,
  });

  // Convert data from Firestore to TripSheet
  factory TripSheet.fromFirestore(Map<String, dynamic> data) {
    return TripSheet(
      no: data['no'] is int
          ? data['no']
          : int.tryParse(data['no'].toString()) ?? 0,
      jobNo: data['job_no'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      vehicleNo: data['vehicle_no'] ?? '',
      fromLocation: data['from_location'] ?? '',
      toLocation: data['to_location'] ?? '',
      liters: data['liters'] is double
          ? data['liters']
          : double.tryParse(data['liters'].toString()) ?? 0.0,
      amount: data['amount'] is double
          ? data['amount']
          : double.tryParse(data['amount'].toString()) ?? 0.0,
      driverName: data['driver_name'] ?? '',
      cleanerName: data['cleaner_name'] ?? '',
      containerNo: data['container_no'] ?? '',
      actualAdvance: data['actual_advance'] is double
          ? data['actual_advance']
          : double.tryParse(data['actual_advance'].toString()) ?? 0.0,
      approvedAdvance: data['approved_advance'] is double
          ? data['approved_advance']
          : double.tryParse(data['approved_advance'].toString()) ?? 0.0,
      actualMtExpenses: data['actual_mt_expenses'] is double
          ? data['actual_mt_expenses']
          : double.tryParse(data['actual_mt_expenses'].toString()) ?? 0.0,
      approvedMtExpenses: data['approved_mt_expenses'] is double
          ? data['approved_mt_expenses']
          : double.tryParse(data['approved_mt_expenses'].toString()) ?? 0.0,
      actualToll: data['actual_toll'] is double
          ? data['actual_toll']
          : double.tryParse(data['actual_toll'].toString()) ?? 0.0,
      approvedToll: data['approved_toll'] is double
          ? data['approved_toll']
          : double.tryParse(data['approved_toll'].toString()) ?? 0.0,
      actualDriverCharges: data['actual_driver_charges'] is double
          ? data['actual_driver_charges']
          : double.tryParse(data['actual_driver_charges'].toString()) ?? 0.0,
      approvedDriverCharges: data['approved_driver_charges'] is double
          ? data['approved_driver_charges']
          : double.tryParse(data['approved_driver_charges'].toString()) ?? 0.0,
      actualCleanerCharges: data['actual_cleaner_charges'] is double
          ? data['actual_cleaner_charges']
          : double.tryParse(data['actual_cleaner_charges'].toString()) ?? 0.0,
      approvedCleanerCharges: data['approved_cleaner_charges'] is double
          ? data['approved_cleaner_charges']
          : double.tryParse(data['approved_cleaner_charges'].toString()) ?? 0.0,
      actualRtoPolice: data['actual_rto_police'] is double
          ? data['actual_rto_police']
          : double.tryParse(data['actual_rto_police'].toString()) ?? 0.0,
      approvedRtoPolice: data['approved_rto_police'] is double
          ? data['approved_rto_police']
          : double.tryParse(data['approved_rto_police'].toString()) ?? 0.0,
      actualHarbourExpenses: data['actual_harbour_expenses'] is double
          ? data['actual_harbour_expenses']
          : double.tryParse(data['actual_harbour_expenses'].toString()) ?? 0.0,
      approvedHarbourExpenses: data['approved_harbour_expenses'] is double
          ? data['approved_harbour_expenses']
          : double.tryParse(data['approved_harbour_expenses'].toString()) ??
              0.0,
      actualDriverExpenses: data['actual_driver_expenses'] is double
          ? data['actual_driver_expenses']
          : double.tryParse(data['actual_driver_expenses'].toString()) ?? 0.0,
      approvedDriverExpenses: data['approved_driver_expenses'] is double
          ? data['approved_driver_expenses']
          : double.tryParse(data['approved_driver_expenses'].toString()) ?? 0.0,
      actualWeightCharges: data['actual_weight_charges'] is double
          ? data['actual_weight_charges']
          : double.tryParse(data['actual_weight_charges'].toString()) ?? 0.0,
      approvedWeightCharges: data['approved_weight_charges'] is double
          ? data['approved_weight_charges']
          : double.tryParse(data['approved_weight_charges'].toString()) ?? 0.0,
      actualLoadingCharges: data['actual_loading_charges'] is double
          ? data['actual_loading_charges']
          : double.tryParse(data['actual_loading_charges'].toString()) ?? 0.0,
      approvedLoadingCharges: data['approved_loading_charges'] is double
          ? data['approved_loading_charges']
          : double.tryParse(data['approved_loading_charges'].toString()) ?? 0.0,
      actualUnloadingCharges: data['actual_unloading_charges'] is double
          ? data['actual_unloading_charges']
          : double.tryParse(data['actual_unloading_charges'].toString()) ?? 0.0,
      approvedUnloadingCharges: data['approved_unloading_charges'] is double
          ? data['approved_unloading_charges']
          : double.tryParse(data['approved_unloading_charges'].toString()) ??
              0.0,
      actualOtherExpenses: data['actual_other_expenses'] is double
          ? data['actual_other_expenses']
          : double.tryParse(data['actual_other_expenses'].toString()) ?? 0.0,
      approvedOtherExpenses: data['approved_other_expenses'] is double
          ? data['approved_other_expenses']
          : double.tryParse(data['approved_other_expenses'].toString()) ?? 0.0,
      actualTotal: data['actual_total'] is double
          ? data['actual_total']
          : double.tryParse(data['actual_total'].toString()) ?? 0.0,
      approvedTotal: data['approved_total'] is double
          ? data['approved_total']
          : double.tryParse(data['approved_total'].toString()) ?? 0.0,
      actualBalance: data['actual_balance'] is double
          ? data['actual_balance']
          : double.tryParse(data['actual_balance'].toString()) ?? 0.0,
      approvedBalance: data['approved_balance'] is double
          ? data['approved_balance']
          : double.tryParse(data['approved_balance'].toString()) ?? 0.0,
      verifiedBy: data['verified_by'] ?? '',
      passedBy: data['passed_by'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  // Convert TripSheet object to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'job_no': jobNo,
      'date': Timestamp.fromDate(date),
      'vehicle_no': vehicleNo,
      'from_location': fromLocation,
      'to_location': toLocation,
      'liters': liters,
      'amount': amount,
      'driver_name': driverName,
      'cleaner_name': cleanerName,
      'container_no': containerNo,
      'actual_advance': actualAdvance,
      'approved_advance': approvedAdvance,
      'actual_mt_expenses': actualMtExpenses,
      'approved_mt_expenses': approvedMtExpenses,
      'actual_toll': actualToll,
      'approved_toll': approvedToll,
      'actual_driver_charges': actualDriverCharges,
      'approved_driver_charges': approvedDriverCharges,
      'actual_cleaner_charges': actualCleanerCharges,
      'approved_cleaner_charges': approvedCleanerCharges,
      'actual_rto_police': actualRtoPolice,
      'approved_rto_police': approvedRtoPolice,
      'actual_harbour_expenses': actualHarbourExpenses,
      'approved_harbour_expenses': approvedHarbourExpenses,
      'actual_driver_expenses': actualDriverExpenses,
      'approved_driver_expenses': approvedDriverExpenses,
      'actual_weight_charges': actualWeightCharges,
      'approved_weight_charges': approvedWeightCharges,
      'actual_loading_charges': actualLoadingCharges,
      'approved_loading_charges': approvedLoadingCharges,
      'actual_unloading_charges': actualUnloadingCharges,
      'approved_unloading_charges': approvedUnloadingCharges,
      'actual_other_expenses': actualOtherExpenses,
      'approved_other_expenses': approvedOtherExpenses,
      'actual_total': actualTotal,
      'approved_total': approvedTotal,
      'actual_balance': actualBalance,
      'approved_balance': approvedBalance,
      'verified_by': verifiedBy,
      'passed_by': passedBy,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
