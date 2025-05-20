import 'package:firebasewithnotification/view/widget/database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';


class LoginController extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordHidden = true;
  bool rememberMe = false;
  String? emailError;
  String? passwordError;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  LoginController() {
    _loadRememberedUser();
  }

  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    notifyListeners();
  }

  bool validateLoginInputs() {
    bool isValid = true;

    if (emailController.text.isEmpty || !emailController.text.contains("@")) {
      emailError = "Enter a valid email";
      isValid = false;
    } else {
      emailError = null;
    }

    String password = passwordController.text;
    if (password.isEmpty) {
      passwordError = "Password cannot be empty";
      isValid = false;
    } else if (password.length < 6) {
      passwordError = "Password must be at least 6 characters";
      isValid = false;
    } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$').hasMatch(password)) {
      passwordError = "Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character.";
      isValid = false;
    } else {
      passwordError = null;
    }

    notifyListeners();
    return isValid;
  }

  Future<void> login(BuildContext context) async {
    if (!validateLoginInputs()) return;

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    var user = await _dbHelper.getUser(email, password);

    if (user != null) {
      if (rememberMe) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);
        prefs.setString('password', password);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Successful")),
      );

      // Navigate to home screen here

    } else {
      passwordError = "Invalid Email or Password";
      notifyListeners();
    }
  }

  Future<void> _loadRememberedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emailController.text = prefs.getString('email') ?? '';
    passwordController.text = prefs.getString('password') ?? '';
    rememberMe = prefs.containsKey('email');
    notifyListeners();
  }

  Future<void> googleLogin(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Google Login Successful")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Login Failed: \$e")),
      );
    }
  }

  Future<void> facebookLogin(BuildContext context) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Facebook Login Successful")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Facebook Login Failed: \$e")),
      );
    }
  }
  Future<void> appleLogin(BuildContext context) async {
    try {
      final AuthorizationCredentialAppleID credential =
      await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
      );

      if (credential.identityToken != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Apple Login Successful")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Apple Login Failed: \$e")),
      );
    }
  }
}
