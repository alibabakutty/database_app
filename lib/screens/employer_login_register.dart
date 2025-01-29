import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:database_app/authentication/auth.dart';
import 'package:get/get.dart';

class EmployerLoginRegister extends StatefulWidget {
  const EmployerLoginRegister({super.key});

  @override
  State<EmployerLoginRegister> createState() => _EmployerLoginRegisterState();
}

class _EmployerLoginRegisterState extends State<EmployerLoginRegister> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String? errorMessage = '';
  bool isLogin = true; // Toggle between login and register
  bool useEmail = true; // Toggle between email and phone number
  String? verificationId;
  bool isOtpSent = false;

  Future<void> signInOrRegisterWithEmail() async {
    try {
      if (isLogin) {
        // Employer Login
        await Auth().signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        // Employer Register
        await Auth().createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
      Navigator.of(context).pushReplacementNamed('/home');
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> sendOtp() async {
    try {
      await Auth().verifyPhoneNo(
        phoneNumber: _phoneController.text.trim(),
        onCodeSent: (String verificationId, int? resendToken) {
          setState(() {
            this.verificationId = verificationId;
            isOtpSent = true;
          });
        },
        onVerificationCompleted: (PhoneAuthCredential credential) async {
          await Auth().sigInWithCredential(credential);
          Navigator.of(context).pushReplacementNamed('/home');
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

  Future<void> verifyOtp() async {
    try {
      if (verificationId != null) {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId!,
          smsCode: _otpController.text.trim(),
        );
        await Auth().sigInWithCredential(credential);
        Navigator.of(context).pushReplacementNamed('/home');
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
        title: Text(isLogin ? 'Employer Authentication' : 'Employer Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
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
              Text(errorMessage ?? '',
                  style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: signInOrRegisterWithEmail,
                child: Text(isLogin ? 'Login' : 'Register'),
              ),
              TextButton(
                onPressed: () => setState(() => isLogin = !isLogin),
                child: Text(isLogin
                    ? 'Need an account? Register'
                    : 'Already have an account? Login'),
              ),
            ] else ...[
              // Phone Number Authentication
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),
              if (isOtpSent) ...[
                TextField(
                  controller: _otpController,
                  decoration: const InputDecoration(labelText: 'OTP'),
                ),
                Text(errorMessage ?? '',
                    style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: verifyOtp,
                  child: const Text('Verify OTP'),
                ),
              ] else ...[
                ElevatedButton(
                  onPressed: sendOtp,
                  child: const Text('Send OTP'),
                ),
              ],
            ]
          ],
        ),
      ),
    );
  }
}
