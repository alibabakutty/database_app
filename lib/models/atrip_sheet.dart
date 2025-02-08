import 'package:cloud_firestore/cloud_firestore.dart';

class AtripSheet {
  late int no;
  final String jobNo;
  final DateTime date;
  final String vehicleNo;
  final String fromLocation;
  final bool isApproved;
  final bool isEmployer;
  final DateTime timestamp;

  AtripSheet({
    required this.no,
    required this.jobNo,
    required this.date,
    required this.vehicleNo,
    required this.fromLocation,
    required this.isApproved,
    required this.isEmployer,
    required this.timestamp,
  });

  factory AtripSheet.fromFirestore(Map<String, dynamic> data) {
    return AtripSheet(
      no: data['no'] as int,
      jobNo: data['job_no'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      vehicleNo: data['vehicle_no'] ?? '',
      fromLocation: data['from_location'] ?? '',
      isApproved: data['is_approved'] is String
          ? data['is_approved'] == 'true'
          : (data['is_approved'] as bool? ?? false),
      isEmployer: data['is_employer'] is String
          ? data['is_employer'] == 'true'
          : (data['is_employer'] as bool? ?? false),
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'job_no': jobNo,
      'date': Timestamp.fromDate(date),
      'vehicle_no': vehicleNo,
      'from_location': fromLocation,
      'is_approved': isApproved,
      'is_employer': isEmployer,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
