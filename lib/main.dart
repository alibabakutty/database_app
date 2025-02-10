import 'package:database_app/firebase_options.dart';
import 'package:database_app/screens/ahome_page.dart';
import 'package:database_app/screens/dashboard.dart';
import 'package:database_app/screens/home_page.dart';
import 'package:database_app/screens/login_page.dart';
import 'package:database_app/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:database_app/widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  bool loggedIn = await SessionManager.isLoggedIn();
  bool? isEmployer =
      await SessionManager.getUserType(); // check stored user type
  Widget firstScreen = const WidgetTree(); // Default login screen

  if (loggedIn) {
    if (isEmployer == true) {
      firstScreen = const Dashboard();
    } else {
      firstScreen = const HomePage();
    }
  }
  // Initialize Firebase
  runApp(TripSheetEntryApp(firstScreen: firstScreen));
}

class TripSheetEntryApp extends StatelessWidget {
  final Widget firstScreen;
  const TripSheetEntryApp({super.key, required this.firstScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transport Entry App',
      home: firstScreen,
      routes: {
        '/dashboard': (context) => const Dashboard(),
        '/home': (context) => HomePage(), // Home page route
        '/employer_login': (context) =>
            const LoginPage(isEmployer: true), // Employer Login page
        '/employee_login': (context) =>
            const LoginPage(isEmployer: false), // Employee Login page route
        '/ahome': (context) => AhomePage(),
      },
    );
  }
}
