import 'package:firebasewithnotification/view/screens/delivery_screen.dart';
import 'package:firebasewithnotification/view/screens/location_section1.dart';
import 'package:flutter/material.dart';
import 'package:firebasewithnotification/components/applocal.dart';



class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'images/Pattern.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
          ),

          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 220),


                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Image.asset(
                      'images/Order food.png',
                      width: 328,
                      height: 328,
                    ),
                  ),

                  SizedBox(height: 20),

                  Container(
                    width: 335,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          getLang(context, "welcome_to_sahlah"),
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0XFF455A64),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          getLang(context, "Enjoy _ A Fast And Smooth Food Delivery _ At Your Doorstep"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0XFF455A64),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DeliveryScreen()),
                      );
                    },
                    borderRadius: BorderRadius.circular(69),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0XFF25AE4B), Color(0XFF0F481F)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(69),
                      ),
                      child: Container(
                        width: 307,
                        height: 48,
                        alignment: Alignment.center,
                        child:
                        Text(
                          getLang(context, "continue"),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40),


                  Container(
                    width: 321,
                    height: 26,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LocationSection()),
                            );
                          },
                          child: Text(
                            getLang(context, "skip"),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0XFF455A64),
                            ),
                          ),
                        ),

                        Row(
                          children: [
                            CircleAvatar(radius: 6, backgroundColor: Colors.green),
                            SizedBox(width: 8),
                            CircleAvatar(radius: 6, backgroundColor: Colors.grey[300]),
                            SizedBox(width: 8),
                            CircleAvatar(radius: 6, backgroundColor: Colors.grey[300]),
                          ],
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => DeliveryScreen()),
                            );
                          },
                          child: Icon(Icons.arrow_forward, size: 28, color: Colors.green),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
