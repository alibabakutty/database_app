import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:database_app/authentication/auth.dart';

class EmployerLoginRegister extends StatefulWidget {
  const EmployerLoginRegister({Key? key}) : super(key: key);

  @override
  State<EmployerLoginRegister> createState() => _EmployerLoginRegisterState();
}

class _EmployerLoginRegisterState extends State<EmployerLoginRegister> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? errorMessage = '';
  bool isLogin = true; // Toggle between login and register

  Future<void> sigInInOrRegister() async {
    try {
      if (isLogin) {
        // Employer Login
        await Auth().signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      } else {
        // Employer Register
        await Auth().createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      }
      Navigator.of(context).pushReplacementNamed('/home');
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Employer Authentication' : 'Employer Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Text(errorMessage ?? '', style: TextStyle(color: Colors.red),),
            ElevatedButton(
              onPressed: sigInInOrRegister,
              child: Text(isLogin ? 'Login' : 'Register'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              }, 
              child: Text(isLogin ? 'Need an account? Register' : 'Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
