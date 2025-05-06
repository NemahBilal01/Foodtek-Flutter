import 'package:firebasewithnotification/controller/login_controller.dart';
import 'package:firebasewithnotification/view/screens/home_screen.dart';
import 'package:firebasewithnotification/view/screens/reset_password_screen.dart';
import 'package:firebasewithnotification/view/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../components/applocal.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginController(),
      child: Scaffold(
        backgroundColor: const Color(0xFF25AE4B),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/Pattern.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Consumer<LoginController>(
                  builder: (context, model, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            'images/sahlah.png',
                            width: 400,
                            height: 150,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(24),
                          width: 343,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  getLang(context, "login"),
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF111827),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      getLang(context, "dont have an account"),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF6C7278),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Signup(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        getLang(context, "signup"),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF25AE4B),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                _designText(getLang(context, "email"),
                                    model.emailController, model.emailError),
                                _designPassword(context, model),
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
                                          getLang(context, "remember me"),
                                          style: TextStyle(
                                            fontSize: 12,
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
                                                    ResetPasswordScreen()));
                                      },
                                      child: Text(
                                        getLang(context, "forgot password"),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF25AE4B),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      final controller =
                                          Provider.of<LoginController>(context,
                                              listen: false);
                                      controller.handleLogin(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF25AE4B),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      getLang(context, "login"),
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Divider(
                                              color: Color(0xFFEDF1F3))),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(getLang(context, "or"),
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey)),
                                      ),
                                      Expanded(
                                          child: Divider(
                                              color: Color(0xFFEDF1F3))),
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
                                            height: 24),
                                        label: Text(
                                            getLang(context,
                                                "continue with Google"),
                                            style:
                                                TextStyle(color: Colors.black),
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: const BorderSide(
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          model.facebookLogin(context);
                                        },
                                        icon: Image.asset(
                                            'images/2021_Facebook_icon 1.png',
                                            height: 24),
                                        label: Text(
                                            getLang(context,
                                                "continue with Facebook"),
                                            style:
                                                TextStyle(color: Colors.black),
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          model.appleLogin(context);
                                        },
                                        icon: const Icon(Icons.apple,
                                            color: Colors.black),
                                        label: Text(
                                          getLang(
                                              context, "continue with Apple"),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: BorderSide(
                                                color: Colors.grey.shade300),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
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
          style: const TextStyle(
            color: Color(0xFF6C7278),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.white,
            errorText: errorText,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _designPassword(BuildContext context, LoginController model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getLang(context, "password"),
          style: TextStyle(
            color: Color(0xFF6C7278),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: model.passwordController,
          obscureText: model.isPasswordHidden,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.white,
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
        const SizedBox(height: 15),
      ],
    );
  }
}
