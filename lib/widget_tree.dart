import 'package:flutter/material.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Login Type'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                '/employer_login',
                arguments: true, // Employer login
              ),
              child: const Text('Employer Login'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context, 
                '/employee_login',
                arguments: false, // Employee login
              ),
              child: const Text('Employee Login'),
            ),
          ],
        ),
      ),
    );
  }
}
