import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:database_app/authentication/auth.dart';

class EmployeeLoginRegister extends StatefulWidget {
  const EmployeeLoginRegister({super.key});

  @override
  State<EmployeeLoginRegister> createState() => _EmployeeLoginPageState();
}

class _EmployeeLoginPageState extends State<EmployeeLoginRegister> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String verificationId = '';
  bool isOtpSent = false;
  String? errorMessage;

  Future<void> sentOtp() async {
    await Auth().verifyPhoneNo(
      phoneNumber: '+${_phoneController.text}', // add country code
      onCodeSent: (String vId, int? resentToken) {
        setState(() {
          verificationId = vId;
          isOtpSent = true;
        });
      },
      onVerificationCompleted: (PhoneAuthCredential credential) async {
        await Auth().siginInWithCredential(credential);
        Navigator.of(context).pushReplacementNamed('/home');
      },
      onVerificationFailed: (FirebaseAuthException e) {
        setState(() {
          errorMessage = e.message;
        });
      },
      onCodeTimeOut: (String vId) {
        verificationId = vId;
      },
    );
  }

  Future<void> verifyOtp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: _otpController.text,
      );
      await Auth().siginInWithCredential(credential);
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
        title: Text(isOtpSent ? 'Enter OTP' : 'Phone Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            if (!isOtpSent)
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Enter Phone Number',
                  prefixText: '+',
                ),
              ),
            if (isOtpSent)
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Enter OTP'),
              ),
            Text(
              errorMessage ?? '',
              style: TextStyle(color: Colors.red),
            ),
            ElevatedButton(
              onPressed: isOtpSent ? verifyOtp : sentOtp, 
              child: Text(isOtpSent ? 'Verify OTP' : 'Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
