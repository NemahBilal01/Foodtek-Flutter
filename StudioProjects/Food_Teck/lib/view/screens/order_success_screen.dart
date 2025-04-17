import 'package:firebasewithnotification/view/screens/delivery_hero_screen.dart';
import 'package:firebasewithnotification/view/screens/delivery_screen.dart';
import 'package:firebasewithnotification/view/widget/common_layoutWithBottomNav.dart';
import 'package:flutter/material.dart';

class OrderSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonLayoutWithBottomNav(
      body: Stack(
        children: [
          Positioned(
            top: 5,
            left: 22,
            child: Container(
              width: 121,
              height: 26,
              alignment: Alignment.centerLeft,
              child: Text(
                "Checkout",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            child: Container(
              width: 430.5,
              height: 287,

              child: Image.asset("images/Group 3154.png", fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 482,
            left: -25,
            child: Container(
              width: 450,
              height: 99,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your Order is Successfully",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      height: 1.3,
                      letterSpacing: -0.02,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "You will get your order within 12 min.\nThanks for using our services",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      height: 1.4,
                      letterSpacing: -0.01,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom:40,
            left: MediaQuery.of(context).size.width / 2 - 193.5,
            child: Container(
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
                  MaterialPageRoute(builder: (context) => DeliveryHeroPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF25AE4B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 22),
                minimumSize: Size(327, 58),
              ),
              child: Text(
                "Track Your Order",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          )],
      ),
    );
  }
}
