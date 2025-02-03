class UserModel {
  final String userNo;
  final String userName;
  final String userEmail;
  final String userPassword;
  final String phoneNo;
  final bool isEmployer;
  final DateTime createdAt;

  UserModel({
    required this.userNo,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
    required this.phoneNo,
    this.isEmployer = false,
    required this.createdAt,
  });

  // convert data from Firestore to UserModel object
  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      userNo: data['user_no'],
      userName: data['user_name'],
      userEmail: data['user_email'],
      userPassword: data['user_password'],
      phoneNo: data['phone_no'],
      isEmployer: data['is_employer'] ?? false,
      createdAt: DateTime.parse(
          data['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  // convert UserModel object to Firestore data
  Map<String, dynamic> toMap() {
    return {
      'user_no': userNo,
      'user_name': userName,
      'user_email': userEmail,
      'user_password': userPassword,
      'phone_no': phoneNo,
      'is_employer': isEmployer,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
