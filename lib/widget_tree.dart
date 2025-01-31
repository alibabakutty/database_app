import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Select Login Type',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
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
