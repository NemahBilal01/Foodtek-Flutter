import 'package:firebasewithnotification/controller/login_controller.dart';
import 'package:firebasewithnotification/view/screens/home_screen.dart';
import 'package:firebasewithnotification/view/screens/reset_password_screen.dart';
import 'package:firebasewithnotification/view/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginController(),
      child: Scaffold(
        backgroundColor: const Color(0xFF25AE4B),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/Pattern.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Consumer<LoginController>(
                  builder: (context, model, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 60.h),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            'images/sahlah.png',
                            width: 400.w,
                            height: 85.h,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Container(
                          padding: EdgeInsets.all(24.w),
                          width: 343.w,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.black
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don’t have an account? ",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: const Color(0xFF6C7278),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Signup(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color(0xFF25AE4B),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              _designText("Email", model.emailController,
                                  model.emailError),
                              _designPassword(model),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: model.rememberMe,
                                        onChanged: (value) {
                                          model.rememberMe = value!;
                                          model.notifyListeners();
                                        },
                                      ),
                                      Text(
                                        "Remember Me",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ResetPasswordScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color(0xFF25AE4B),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF25AE4B),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.h),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        child:
                                            Divider(color: Color(0xFFEDF1F3))),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: Text(
                                        "OR",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                        child:
                                            Divider(color: Color(0xFFEDF1F3))),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        model.googleLogin(context);
                                      },
                                      icon: Image.asset('images/google.png',
                                          height: 24.h),
                                      label: Text(
                                        "Continue with Google",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.h),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          side: const BorderSide(
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        model.facebookLogin(context);
                                      },
                                      icon: Image.asset(
                                          'images/2021_Facebook_icon 1.png',
                                          height: 24.h),
                                      label: Text(
                                        "Continue with Facebook",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.h),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          side: BorderSide(
                                              color: Colors.grey.shade300),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        model.appleLogin(context);
                                      },
                                      icon: const Icon(Icons.apple,
                                          color: Colors.black),
                                      label: Text(
                                        "Continue with Apple",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.h),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          side: BorderSide(
                                              color: Colors.grey.shade300),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _designText(
      String label, TextEditingController controller, String? errorText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF6C7278),
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.h),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            filled: true,
            errorText: errorText,
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  Widget _designPassword(LoginController model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: TextStyle(
            color: const Color(0xFF6C7278),
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.h),
        TextField(
          controller: model.passwordController,
          obscureText: model.isPasswordHidden,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            filled: true,
            errorText: model.passwordError,
            suffixIcon: IconButton(
              icon: Icon(
                model.isPasswordHidden
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: () {
                model.togglePasswordVisibility();
              },
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
