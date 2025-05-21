import 'package:firebasewithnotification/controller/signup_controller.dart';
import 'package:firebasewithnotification/view/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_code_picker/country_code_picker.dart';

import '../../components/applocal.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SignupControler(),
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
                    child: Consumer<SignupControler>(
                        builder: (context, model, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'images/sahlah.png',
                                  width: 400,
                                  // height: 85,
                                  height: 150,
                                ),
                              ),
                              // const SizedBox(height: 25),
                              Container(
                                padding: const EdgeInsets.all(24),
                                width: 343,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(
                                    getLang(context, "signup"),
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF111827),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(children: [
                                      Text(
                                       getLang(context,"already have an account?"),
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
                                              builder: (context) => const Login(),
                                            ),
                                          );
                                        },
                                        child:  Text(
                                          getLang(context, "login"),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF25AE4B),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ]),
                                     SizedBox(height: 20),
                                    designText(
                                        getLang(context, "full name"),
                                        model.fullNameController,
                                        model.fullNameError),
                                    designText(getLang(context, "login"), model.emailController,
                                        model.emailError),
                                    designDate(context, model),
                                    designPhone(model),
                                    designPassword(model),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          bool isValid = model.validateInputs(context);
                                          if (isValid) {
                                            bool success = await model.signupUser(context);
                                            if (success) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text(getLang(context,"signup Successful!"))),
                                              );
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(builder: (context) => const Login()),
                                                    (route) => false,
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text(getLang(context, "user already exists!"))),
                                              );
                                            }
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF25AE4B),
                                          padding: const EdgeInsets.symmetric(vertical: 15),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        child:  Text(
                                          getLang(context, "register"),
                                          style: TextStyle(fontSize: 14, color: Colors.white),
                                        ),
                                      ),


                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                )
              ],
            )));
  }

  Widget designText(
      String label, TextEditingController controller, String? errorText,
      {bool obscureText = false}) {
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
          obscureText: obscureText,
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

  Widget designDate(BuildContext context, SignupControler model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(getLang(context, "birth of date"),
            style: TextStyle(
              color: Color(0xFF6C7278),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 5),
        TextField(
          controller: model.birthDateController,
          readOnly: true,
          onTap: () => model.selectDate(context),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: const Icon(Icons.date_range_outlined),
            errorText: model.birthDateError,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget designPhone(SignupControler model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(getLang(context, "phone Number"),
            style: TextStyle(
              color: Color(0xFF6C7278),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 5),
        TextField(
          controller: model.phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: CountryCodePicker(
              onChanged: (code) => model.countryCode = code.dialCode!,
              initialSelection: 'US',
              favorite: const ['+1', '+962'],
              showCountryOnly: false,
              showFlag: true,
              showOnlyCountryWhenClosed: false,
            ),
            errorText: model.phoneError,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget designPassword(SignupControler model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(getLang(context, "set Password"),
            style: TextStyle(
              color: Color(0xFF6C7278),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 5),
        TextField(
          controller: model.passwordController,
          obscureText: model.isPasswordHidden,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              const BorderSide(color: Color(0xFFFFC0CB), width: 1.5),
            ),
            filled: true,
            fillColor: Colors.white,
            errorText: model.passwordError,
            suffixIcon: IconButton(
              icon: Icon(model.isPasswordHidden
                  ? Icons.visibility_off
                  : Icons.visibility),
              onPressed: model.togglePasswordVisibility,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
