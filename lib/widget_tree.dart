import 'package:flutter/material.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({Key? key}) : super(key: key);

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
              onPressed: () => Navigator.pushNamed(context, '/employer_login'),
              child: const Text('Employer Login'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/employee_login'),
              child: const Text('Employee Login'),
            ),
          ],
        ),
      ),
    );
  }
}
