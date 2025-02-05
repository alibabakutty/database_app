import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // sign Up with email and password(also save user to firestore)
  Future<UserCredential> signUpWithEmailAndPassword({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = userCredential.user!;
      UserModel newUser = UserModel(
        userNo: user.uid,
        userName: userName,
        userEmail: email,
        userPassword: password,
        phoneNo: user.phoneNumber ?? '',
        isEmployer: false,
        createdAt: DateTime.now(),
      );
      await addUser(newUser);
      return userCredential;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  /// Sign in with Email and Password
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// Create a new user with Email and Password
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  /// Sign in with Phone Number (OTP Authentication)
  Future<void> verifyPhoneNo({
    required String phoneNumber,
    required Function(String verificationId, int? resendToken) onCodeSent,
    required Function(PhoneAuthCredential credential) onVerificationCompleted,
    required Function(FirebaseAuthException e) onVerificationFailed,
    required Function(String verificationId) onCodeTimeOut,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerificationCompleted,
      verificationFailed: onVerificationFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: onCodeTimeOut,
    );
  }

  /// Sign in with Phone Number (OTP Authentication)
  Future<UserCredential> sigInWithCredential(
      PhoneAuthCredential credential) async {
    return await _firebaseAuth.signInWithCredential(credential);
  }

  /// Check if a user exists in Firestore
  Future<bool> checkIfUserExists(String uid) async {
    var userDoc = await _firestore.collection('users').doc(uid).get();
    return userDoc.exists;
  }

  /// Sign out from Firebase Authentication
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Method to add user data to Firestore
  Future<void> addUser(UserModel user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.userNo.toString())
          .set(user.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getUserData(String uid) async {
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        // convert document data to a Map<String,dynamic>
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data != null) {
          return UserModel.fromFirestore(data);
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
    return null;
  }
}
