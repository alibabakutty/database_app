import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _userIdKey = 'userId';
  static const String _isEmployerKey = 'isEmployer';

  // Save login session
  static Future<void> saveLoginSession(String userId, bool isEmployer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    await prefs.setBool(_isEmployerKey, isEmployer);
    print('Session saved: userId=$userId, isEmployer=$isEmployer');
  }

  // Get stored user ID
  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(_userIdKey);
    print('User ID: $userId');
    return userId;
  }

  // Get user type (Employer or Employee)
  static Future<bool> isEmployer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isEmployerKey) ?? false;
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.containsKey(_userIdKey);
    print('Logged in: $loggedIn');
    return loggedIn;
  }

  // Get user type (Employer or Employee)
  static Future<bool?> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isEmployerKey);
  }

  // Logout (Clear session data)
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('User logged out, session cleared');
  }
}
