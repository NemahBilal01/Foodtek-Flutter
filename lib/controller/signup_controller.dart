import 'package:firebasewithnotification/view/widget/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignupControler extends ChangeNotifier {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? birthDateError;
  String? fullNameError;
  String? emailError;
  String? phoneError;
  String? passwordError;

  String _countryCode = '+1';
  bool isPasswordHidden = true;

  String get countryCode => _countryCode;
  set countryCode(String value) {
    _countryCode = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      birthDateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      notifyListeners();
    }
  }

  Future<bool> signupUser(BuildContext context) async {
    final dbHelper = DatabaseHelper();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    var existingUser = await dbHelper.getUser(email, password);
    if (existingUser != null) {
      return false;
    } else {
      await dbHelper.insertUser(email, password);
      return true;
    }
  }


  bool validateInputs(BuildContext context) {
    bool isValid = true;

    if (fullNameController.text.isEmpty) {
      fullNameError = "Full Name is required";
      isValid = false;
    } else {
      fullNameError = null;
    }

    if (emailController.text.isEmpty || !emailController.text.contains("@")) {
      emailError = "Enter a valid email";
      isValid = false;
    } else {
      emailError = null;
    }

    if (birthDateController.text.isEmpty) {
      birthDateError = "Birth date is required";
      isValid = false;
    } else {
      birthDateError = null;
    }

    if (phoneController.text.isEmpty) {
      phoneError = "Phone number is required";
      isValid = false;
    } else {
      phoneError = null;
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


  void showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          children: [
            ListTile(
              leading: Image.asset("images/flag_us.png", width: 30, height: 20),
              title: Text("+1 (USA)"),
              onTap: () {
                countryCode = "+1";
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Image.asset("images/flag_jordan.png", width: 30, height: 20),
              title: Text("+962 (Jordan)"),
              onTap: () {
                countryCode = "+962";
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
