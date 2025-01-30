import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_app/models/trip_sheet.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  FirebaseService();

  // Add data to Firestore
  Future<bool> addTripSheet(TripSheet tripSheet) async {
    try {
      await _db.collection('trip_sheet_entry').add(tripSheet.toMap());
      return true;
    } catch (e) {
      print('Error adding trip sheet: $e');
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
    } catch (e) {
      print('Error fetching trip sheets: $e');
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
    } catch (e) {
      print('Error fetching trip sheet by No.: $e');
      return null;
    }
  }

  // Fetch tripsheet by jobNo.
  Future<TripSheet?> getTripSheetByJobNo(String jobNo) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('trip_sheet_entry')
          .where('jobNo', isEqualTo: jobNo)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return TripSheet.fromFirestore(
            snapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (Query) {
      print('Error fetching trip sheet by Job No.: $Query');
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
    } catch (e) {
      print('Error updating trip sheet: $e');
      return false;
    }
  }

  // update trip sheet by jobNo.
  Future<bool> updateTripSheetByJobNo(
      String jobNo, Map<String, dynamic> updatedData) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('trip_sheet_entry')
          .where('jobNo', isEqualTo: jobNo)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        String docId = snapshot.docs.first.id;
        await _db.collection('trip_sheet_entry').doc(docId).update(updatedData);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error updating trip sheet by Job No.: $e');
      return false;
    }
  }
}
