import 'package:database_app/authentication/auth.dart';
import 'package:database_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final bool isEmployer; // Determines if the user is an employer or employee
  const LoginPage({super.key, required this.isEmployer});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String? errorMessage = '';
  bool isLogin = true; // toggle between login and register
  bool useEmail = false; // toggle between email and phone number
  String? verificationId;
  bool isOtpSent = false;

  // Handles email authentication
  Future<void> siginInOrRegisterWithEmail() async {
    try {
      if (isLogin) {
        // Login
        await Auth().signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        // Register
        UserCredential userCredential =
            await Auth().createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Add user data to firestore
        UserModel newUser = UserModel(
          userNo: userCredential.user!.uid,
          userName: _userNameController.text.trim(),
          userEmail: _emailController.text.trim(),
          userPassword: _passwordController.text.trim(),
          phoneNo: _phoneController.text.trim(),
          isEmployer: widget.isEmployer, // use the employer flag
          createdAt: DateTime.now(),
        );
        await Auth().addUser(newUser);
      }
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(
          widget.isEmployer ? '/dashboard' : '/home',
          arguments: widget.isEmployer,
        ); // pass the isemployer flag
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  // Initates phone authentication(OTP verification)
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
          UserCredential userCredential =
              await Auth().sigInWithCredential(credential);
          await saveUserToFirestore(userCredential);
          if (mounted) {
            Navigator.of(context).pushReplacementNamed(
              widget.isEmployer ? '/dashboard' : '/home',
              arguments: widget.isEmployer, // pass the isemployer flag
            );
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

  // Handles OTP Verification
  Future<void> verifiyOtp() async {
    try {
      if (verificationId != null) {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId!,
          smsCode: _otpController.text.trim(),
        );
        UserCredential userCredential =
            await Auth().sigInWithCredential(credential);
        await saveUserToFirestore(userCredential);
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(
            widget.isEmployer ? '/dashboard' : '/home',
            arguments: widget.isEmployer, // pass the isemployer flag
          );
        } else {
          setState(() {
            errorMessage = 'Invalid OTP';
          });
        }
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  // saves user data to firestore
  Future<void> saveUserToFirestore(UserCredential userCredential) async {
    if (userCredential.user != null) {
      bool userExists =
          await Auth().checkIfUserExists(userCredential.user!.uid);
      if (!userExists) {
        UserModel newUser = UserModel(
          userNo: userCredential.user!.uid,
          userName: _userNameController.text.trim(),
          userEmail: _emailController.text.trim(),
          userPassword: _passwordController.text.trim(),
          phoneNo: _phoneController.text.trim(),
          isEmployer: widget.isEmployer,
          createdAt: DateTime.now(),
        );
        await Auth().addUser(newUser);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEmployer
              ? (isLogin ? 'Employer Login' : 'Employer Register')
              : (isLogin ? 'Employee Login' : 'Employee Register'),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Toggle between email and phone authentication
              Center(
                child: ToggleButtons(
                  isSelected: [useEmail, !useEmail],
                  onPressed: (index) {
                    setState(() {
                      useEmail = index == 0;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  selectedColor: Colors.white,
                  fillColor: Colors.blueAccent,
                  constraints: const BoxConstraints(
                    minHeight: 30,
                    minWidth: 120,
                  ),
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.email,
                            color: Colors.indigoAccent,
                          ),
                          SizedBox(width: 8),
                          Text('Email'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.indigoAccent,
                          ),
                          SizedBox(width: 8),
                          Text('Phone No'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (useEmail) ...[
                if (!isLogin) ...[
                  TextField(
                    controller: _userNameController,
                    decoration: const InputDecoration(
                      labelText: 'User Name',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.blueAccent,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                // Email Authentication
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.blueAccent,
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.blueAccent,
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                if (errorMessage!.isNotEmpty)
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: siginInOrRegisterWithEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      isLogin ? 'Login' : 'Register',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: () => setState(() => isLogin = !isLogin),
                    child: Text(
                      isLogin
                          ? 'Need an Account? Register'
                          : 'Already have an account? Login',
                      style: const TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ),
              ] else ...[
                // Phone Number Authentication
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Enter Phone Number',
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.blueAccent,
                    ),
                    prefixText: '+91-',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                if (isOtpSent) ...[
                  TextField(
                    controller: _otpController,
                    decoration: InputDecoration(
                      labelText: 'Enter OTP',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.blueAccent,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (errorMessage!.isNotEmpty)
                    Text(
                      errorMessage!,
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: verifiyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Verify OTP',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: sendOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Send OTP',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ]
              ]
            ],
          ),
        ),
      ),
    );
  }
}
