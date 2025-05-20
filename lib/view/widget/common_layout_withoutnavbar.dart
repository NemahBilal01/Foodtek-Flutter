import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonLayoutWithoutNavBar extends StatelessWidget {
  final Widget body;

  const CommonLayoutWithoutNavBar({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Image.asset("images/loc.png"),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Current location",
                      style: TextStyle(color: Color(0xFF606060), fontSize: 12),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xFF606060),
                      size: 16,
                    ),
                  ],
                ),
                Transform.translate(
                  offset: Offset(45, -19),
                  child: Text(
                    "Jl. Soekarno Hatta 15A...",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Expanded(child: body),
      ),
    );
  }
}
