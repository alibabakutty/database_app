import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_app/models/trip_sheet.dart';
import 'package:database_app/models/user_model.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  FirebaseService();

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

  // Fetch all data from Firestore if needed
  Future<List<TripSheet>> getTripSheets() async {
    try {
      QuerySnapshot snapshot = await _db.collection('trip_sheets').get();
      return snapshot.docs
          .map((doc) =>
              TripSheet.fromFirestore(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e, stackTrace) {
      log('Error fetching trip sheets: $e', stackTrace: stackTrace);
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
