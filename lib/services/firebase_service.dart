// lib/services/firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_app/models/trip_sheet.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  FirebaseService();

  Future<bool> addTripSheet(TripSheet tripSheet) async {
    try {
      await _db.collection('trip_sheet_entry').add(tripSheet.toMap());
      return true;
    } catch (e) {
      print('Error adding trip sheet: $e');
      return false;
    }
  }

  // Fetch data from Firestore if needed
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
}
