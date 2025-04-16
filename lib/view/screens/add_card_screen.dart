import 'package:firebasewithnotification/view/screens/order_success_screen.dart';
import 'package:firebasewithnotification/view/widget/common_layoutWithBottomNav.dart';
import 'package:flutter/material.dart';

import '../../components/applocal.dart';


class AddCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonLayoutWithBottomNav(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getLang(context, "add_card"),
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Color(0xFF391713),
                ),
              ),
              const SizedBox(height: 25),
              Center(child: Image.asset('images/Group.png', width: 365)),
              const SizedBox(height: 18),
              buildTextField(context,getLang(context, "name")),
              const SizedBox(height: 16),
              buildTextField(context,getLang(context, "card_number"), hasIcon: true),
              const SizedBox(height: 16),
              SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTextField(context,getLang(context, "expiry"), width: 150),
                    buildTextField(context,getLang(context, "cvc"), width: 150),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 233,
                      height: 34,
                      child: Text(
                        getLang(context, "order_details_email"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "SF Pro Display",
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.4,
                          letterSpacing: 0.02,
                          color: Color(0xFF929DA9),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x7525AE4B),
                            blurRadius: 15,
                            spreadRadius: 4,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderSuccessScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF25AE4B),
                          minimumSize: const Size(327, 57),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 12,
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.lock_outline, color: Colors.white),
                              const SizedBox(width: 10),
                              Text(
                                getLang(context, "pay_for_order"),
                                style: const TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 18,
                                  height: 1.0,
                                  letterSpacing: 0.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      BuildContext context,
      String label, {
        bool hasIcon = false,
        double width = 385,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.w500,
            fontSize: 12,
            height: 1.6,
            letterSpacing: -0.02,
            color: Color(0xFF6C7278),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: width,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFEDF1F3), width: 2),
          ),
          child: TextField(
            keyboardType:
            label == getLang(context, "card_number") || label == getLang(context, "cvc")
                ? TextInputType.number
                : TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: hasIcon
                  ? Image.asset(
                'images/shopping_15402438 1.png',
                width: 38,
                height: 38,
              )
                  : null,
            ),
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 1.4,
              letterSpacing: -0.01,
            ),
          ),
        ),
      ],
    );
  }
}

