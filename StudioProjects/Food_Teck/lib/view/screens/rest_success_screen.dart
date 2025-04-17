import 'dart:ui';

import 'package:firebasewithnotification/view/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animations/animations.dart';
import 'package:lottie/lottie.dart';

class RestSuccessScreen extends StatefulWidget {
  const RestSuccessScreen({super.key});

  @override
  State<RestSuccessScreen> createState() => _RestSuccessScreenState();
}

class _RestSuccessScreenState extends State<RestSuccessScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool isUpdating = false;

  Future<void> updatePassword() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isUpdating = true;
      });
      await Future.delayed(Duration(seconds: 2));
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.updatePassword(newPasswordController.text.trim());
          setState(() {
            isUpdating = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Password updated successfully!")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF25AE4B),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "images/Pattern.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 70,
            left: 53,
            child: Image.asset(
              "images/logo.png",
              width: 307,
              height: 85,
            ),
          ),
          if (isUpdating)
            Container(
              // color: Color(0xFF000000A6),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: Container(color: Colors.black.withOpacity(0.6)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'images/Celebration-cuate-1.png',
                              width: 371.3031005859375,
                              height: 134.79769897460938,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Image.asset(
                                'images/freepik--Device--inject-65.png',
                                width: 200,
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Text(
                        "Congratulations!",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Password reset successfully",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          if (!isUpdating)
            SingleChildScrollView(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 180),
                  child: Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        child: Container(
                          width: 343,
                          height: 417,
                          padding: EdgeInsets.all(24),
                          child: Form(
                            key: formKey,
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.arrow_back),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Reset Password",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Want to try with my current password?",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0XFF6C7278),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()),
                                        );
                                      },
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0XFF25AE4B),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                if (!isUpdating)
                                  Column(
                                    children: [
                                      TextFormField(
                                        controller: newPasswordController,
                                        obscureText: _obscureText,
                                        decoration: InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelText: 'New Password',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                color: Color(0XFFEDF1F3),
                                                width: 1,
                                              )),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                            icon: Icon(
                                              _obscureText
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a new password';
                                          }
                                          if (value.length < 8) {
                                            return 'Password must be at least 8 characters';
                                          }
                                          if (!RegExp(r'(?=.*[A-Z])')
                                              .hasMatch(value)) {
                                            return 'Must contain at least one uppercase letter';
                                          }
                                          if (!RegExp(r'(?=.*[a-z])')
                                              .hasMatch(value)) {
                                            return 'Must contain at least one lowercase letter';
                                          }
                                          if (!RegExp(r'(?=.*\d)')
                                              .hasMatch(value)) {
                                            return 'Must contain at least one number';
                                          }
                                          if (!RegExp(r'(?=.*[@$!%*?&])')
                                              .hasMatch(value)) {
                                            return 'Must contain at least one special character';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 24),
                                      TextFormField(
                                        controller: confirmPasswordController,
                                        obscureText: _obscureText,
                                        decoration: InputDecoration(
                                          labelText: 'Confirm New Password',
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Color(0XFFEDF1F3),
                                              width: 1,
                                            ),
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                            icon: Icon(
                                              _obscureText
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please confirm your password';
                                          }
                                          if (value !=
                                              newPasswordController.text) {
                                            return 'Passwords do not match';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 24),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                isUpdating = true;
                                              });
                                              await updatePassword();
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Login()));
                                            }
                                          },
                                          child: Text(
                                            'Update Password',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(295, 48),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            backgroundColor: Color(0XFF25AE4B),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
