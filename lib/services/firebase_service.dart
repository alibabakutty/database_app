import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_app/models/atrip_sheet.dart';
import 'package:database_app/models/trip_sheet.dart';
import 'package:database_app/models/user_model.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  FirebaseService();

  // Navigate to home with trip sheet data
  void navigateToHome(BuildContext context, bool isApproved, int no) {
    Navigator.pushNamed(context, '/ahome', arguments: {
      'is_approved': isApproved,
      'is_employer': true,
      'no': no,
    });
  }

  // Add data to Firestore
  Future<bool> addTripSheet(TripSheet tripSheet) async {
    try {
      await _db.collection('trip_sheet_entry').add(tripSheet.toMap());
      return true;
    } catch (e, stackTrace) {
      log('Error adding trip sheet: $e', stackTrace: stackTrace);
      return false;
    }
  }

  Future<bool> saveTripSheet(AtripSheet atripSheet) async {
    try {
      await _db.collection('atrip_sheet').add(atripSheet.toMap());
      return true;
    } catch (e, stackTrace) {
      log('Error adding atrip sheet: $e', stackTrace: stackTrace);
      return false;
    }
  }

  // fetch trip sheets by approval status
  Future<List<TripSheet>> getTripSheetsByApproval(bool isApproved) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('trip_sheet_entry')
          .where('is_approved', isEqualTo: isApproved)
          .get();
      return snapshot.docs.map((doc) {
        return TripSheet.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e, stackTrace) {
      log('Error fetching sheets by approval status: $e',
          stackTrace: stackTrace);
      return [];
    }
  }

  // fetch trip sheets by approval status
  Future<List<AtripSheet>> getAtripSheetsByApproval(bool isApproved) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('atrip_sheet')
          .where('is_approved', isEqualTo: isApproved)
          .get();
      return snapshot.docs.map((doc) {
        return AtripSheet.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e, stackTrace) {
      log('Error fetching sheets by approval status: $e',
          stackTrace: stackTrace);
      return [];
    }
  }

  // Fetch a single TripSheet by "No."
  Future<TripSheet?> getTripSheetByNo(int no) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('trip_sheet_entry')
          .where('no', isEqualTo: no)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return TripSheet.fromFirestore(
            snapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      log('Error fetching trip sheet by No.: $e', stackTrace: stackTrace);
      return null;
    }
  }

  // Fetch a single TripSheet by "No."
  Future<AtripSheet?> getAtripSheetByNo(int no) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('atrip_sheet')
          .where('no', isEqualTo: no)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return AtripSheet.fromFirestore(
            snapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      log('Error fetching trip sheet by No.: $e', stackTrace: stackTrace);
      return null;
    }
  }

  // Fetch tripsheet by jobNo.
  Future<TripSheet?> getTripSheetByJobNo(String jobNo) async {
    // Validate jobNo
    if (jobNo.isEmpty) {
      log('Job No. cannot be empty');
      return null;
    }
    try {
      QuerySnapshot snapshot = await _db
          .collection('trip_sheet_entry')
          .where('job_no', isEqualTo: jobNo.trim())
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return TripSheet.fromFirestore(
            snapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      log('Error fetching trip sheet by Job No.: $e', stackTrace: stackTrace);
      return null;
    }
  }

  // Update a TripSheet in Firestore
  Future<bool> updateTripSheet(int no, Map<String, dynamic> updatedData) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('trip_sheet_entry')
          .where('no', isEqualTo: no)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        String docId = snapshot.docs.first.id;
        await _db.collection('trip_sheet_entry').doc(docId).update(updatedData);
        return true;
      } else {
        return false;
      }
    } catch (e, stackTrace) {
      log('Error updating trip sheet: $e', stackTrace: stackTrace);
      return false;
    }
  }

  // update trip sheet by jobNo.
  Future<bool> updateTripSheetByJobNo(
      String jobNo, Map<String, dynamic> updatedData) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('trip_sheet_entry')
          .where('job_no', isEqualTo: jobNo)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        String docId = snapshot.docs.first.id;
        await _db.collection('trip_sheet_entry').doc(docId).update(updatedData);
        return true;
      } else {
        return false;
      }
    } catch (e, stackTrace) {
      log('Error updating trip sheet by Job No.: $e', stackTrace: stackTrace);
      return false;
    }
  }

  // update Atripsheet in firestore
  Future<bool> updateAtripSheetByNo(
      int no, Map<String, dynamic> updatedData) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('atrip_sheet')
          .where('no', isEqualTo: no)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        String docId = snapshot.docs.first.id;
        await _db.collection('atrip_sheet').doc(docId).update(updatedData);
        return true;
      } else {
        return false;
      }
    } catch (e, stackTrace) {
      log('Error updating Atrip sheet by No.: $e', stackTrace: stackTrace);
      return false;
    }
  }

  // Add data to Firestore for users collection
  Future<bool> addUser(UserModel user) async {
    try {
      user.isEmployer ? 'employer' : 'employee';
      await _db.collection('user').add(user.toMap());
      return true;
    } catch (e, stackTrace) {
      log('Error adding user: $e', stackTrace: stackTrace);
      return false;
    }
  }

  // Fetch user by email (from either employers or employees)
  Future<UserModel?> getUserByEmail(String email) async {
    try {
      // check in the employers collection
      QuerySnapshot employerSnapshot = await _db
          .collection('employers')
          .where('user_email', isEqualTo: email)
          .limit(1)
          .get();
      if (employerSnapshot.docs.isNotEmpty) {
        return UserModel.fromFirestore(
            employerSnapshot.docs.first.data() as Map<String, dynamic>);
      }

      // check in the employees collection
      QuerySnapshot employeeSnapshot = await _db
          .collection('employees')
          .where('user_email', isEqualTo: email)
          .limit(1)
          .get();
      if (employeeSnapshot.docs.isNotEmpty) {
        return UserModel.fromFirestore(
            employeeSnapshot.docs.first.data() as Map<String, dynamic>);
      }

      return null;
    } catch (e, stackTrace) {
      log('Error fetching user by email: $e', stackTrace: stackTrace);
      return null;
    }
  }
}
