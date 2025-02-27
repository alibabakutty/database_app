import 'package:database_app/screens/dashboard.dart';
import 'package:database_app/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  bool isCheckingSession = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> checkSession() async {
    bool loggedIn = await SessionManager.isLoggedIn();
    if (loggedIn) {
      // if user is logged in, navigate to dashboard
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
      });
    } else {
      setState(() {
        isCheckingSession = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2193b0), // Light Blue
              Color(0xFF6dd5ed), // Sky Blue
            ],
          ),
        ),
        child: Center(
          child: Column(
            // Wrap everything in a Column
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo and Heading in a Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/bt_logo.png',
                      width: 70,
                      height: 70,
                    ),
                  ),
                  const SizedBox(width: 10), // Space between logo and text
                  Text(
                    'British Transport',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10), // Space between title and subtitle

              Text(
                'Please select your login type',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              // Login Buttons
              _buildLoginButton(
                context,
                title: 'Employer Login',
                onTap: () => Navigator.pushNamed(
                  context,
                  '/employer_login',
                  arguments: true, // Employer login
                ),
                color: Colors.white,
                textColor: const Color(0xFF2193b0),
              ),
              const SizedBox(height: 15),
              _buildLoginButton(
                context,
                title: 'Employee Login',
                onTap: () => Navigator.pushNamed(
                  context,
                  '/employee_login',
                  arguments: false, // Employee login
                ),
                color: Colors.transparent,
                textColor: Colors.white,
                borderColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
    required Color color,
    required Color textColor,
    Color? borderColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: color,
          border: borderColor != null ? Border.all(color: borderColor) : null,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            if (borderColor == null)
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
