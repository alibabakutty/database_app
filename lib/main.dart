import 'package:database_app/firebase_options.dart';
import 'package:database_app/screens/ahome_page.dart';
import 'package:database_app/screens/dashboard.dart';
import 'package:database_app/screens/home_page.dart';
import 'package:database_app/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:database_app/widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize Firebase
  runApp(const DatabaseApp());
}

class DatabaseApp extends StatelessWidget {
  const DatabaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transport Entry App',
      initialRoute: '/',
      routes: {
        '/': (context) => const WidgetTree(), // Entry point of the app
        '/employer_login': (context) =>
            const LoginPage(isEmployer: true), // Employer Login page
        '/employee_login': (context) =>
            const LoginPage(isEmployer: false), // Employee Login page route
        '/dashboard': (context) => const Dashboard(),
        '/home': (context) => HomePage(), // Home page route
        '/ahome': (context) => AhomePage(),
      },
    );
  }
}
