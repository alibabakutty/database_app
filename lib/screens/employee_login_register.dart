import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:database_app/authentication/auth.dart';

class EmployeeLoginRegister extends StatefulWidget {
  const EmployeeLoginRegister({super.key});

  @override
  State<EmployeeLoginRegister> createState() => _EmployeeLoginPageState();
}

class _EmployeeLoginPageState extends State<EmployeeLoginRegister> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String? errorMessage = '';
  bool isLogin = true; // toggle between login and register
  bool useEmail = true; // toggle between email and phone number
  String? verificationId;
  bool isOtpSent = false;

  /// Handles email authentication
  Future<void> signInOrRegisterWithEmail() async {
    try {
      if (isLogin) {
        // Employee login
        await Auth().signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        // Employee register
        await Auth().createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  /// Initiates phone authentication (OTP verification)
  Future<void> sendOtp() async {
    try {
      await Auth().verifyPhoneNo(
        phoneNumber: '+91-${_phoneController.text.trim()}',
        onCodeSent: (String verificationId, int? resendToken) {
          setState(() {
            this.verificationId = verificationId;
            isOtpSent = true;
          });
        },
        onVerificationCompleted: (PhoneAuthCredential credential) async {
          await Auth().sigInWithCredential(credential);
          if (mounted) {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        },
        onVerificationFailed: (FirebaseAuthException e) {
          setState(() {
            errorMessage = e.message;
          });
        },
        onCodeTimeOut: (String verificationId) {
          setState(() {
            this.verificationId = verificationId;
          });
        },
      );
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  /// Handles OTP verification
  Future<void> verifyOtp() async {
    try {
      if (verificationId != null) {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId!,
          smsCode: _otpController.text.trim(),
        );
        await Auth().sigInWithCredential(credential);
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } else {
        setState(() {
          errorMessage = 'Invalid OTP';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Employee Login' : 'Employee Register'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Toggle between Email and Phone Authentication
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => setState(() => useEmail = true),
                    child: Text(
                      "Email Authentication",
                      style: TextStyle(
                        color: useEmail ? Colors.blue : Colors.grey,
                        fontWeight:
                            useEmail ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => setState(() => useEmail = false),
                    child: Text(
                      "Phone No Authentication",
                      style: TextStyle(
                        color: useEmail ? Colors.grey : Colors.blue,
                        fontWeight:
                            useEmail ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              if (useEmail) ...[
                // Email Authentication
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                Text(
                  errorMessage ?? '',
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: signInOrRegisterWithEmail,
                  child: Text(isLogin ? 'Login' : 'Register'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Text(isLogin
                      ? 'Need an account? Register'
                      : 'Already have an account? Login'),
                ),
              ] else ...[
                // Phone Number Authentication
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Phone Number',
                    prefixText: '+91-',
                  ),
                  keyboardType: TextInputType.phone,
                ),
                if (isOtpSent) ...[
                  TextField(
                    controller: _otpController,
                    decoration: const InputDecoration(labelText: 'OTP'),
                  ),
                  Text(
                    errorMessage ?? '',
                    style: TextStyle(color: Colors.red),
                  ),
                  ElevatedButton(
                    onPressed: verifyOtp,
                    child: Text('Verify OTP'),
                  ),
                ] else ...[
                  ElevatedButton(
                    onPressed: sendOtp,
                    child: Text('Send OTP'),
                  ),
                ],
              ]
            ],
          ),
        ),
      ),
    );
  }
}
