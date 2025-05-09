import 'package:firebasewithnotification/view/Widget/common_layout_bottomnavbaronly.dart';

import 'package:flutter/material.dart';

import '../../components/applocal.dart';

class Profile2Screen extends StatelessWidget {
  const Profile2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavBarOnly(
      appBar: AppBar(
        title:  Text(
            getLang(context,"profile"),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("images/Mask group.png"),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 158,
                  height: 46,
                  alignment: Alignment.center,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ahmad Daboor",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xFF1B1B1B),
                        ),
                      ),
                      Text(
                        "emmie1709@gmail.com",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFF838383),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 380,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFF5F5F5),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 15,
                        spreadRadius: 0,
                        offset: const Offset(0, 0),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      buildTextField(getLang(context, "username")),
                      buildTextField(getLang(context, "email")),
                      buildTextField(getLang(context, "phone Number")),
                      buildTextField(getLang(context, "password")),
                      buildTextField(getLang(context, "address")),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 295,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25AE4B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Color(0xFF25AE4B), width: 1),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 24,
                      ),
                    ),
                    child:  Text(
                      getLang(context, "update"),
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white,
                        letterSpacing: -0.01,
                        height: 1.4,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 87,
          height: 25,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Color(0xFF6C7278),
              letterSpacing: -0.02,
            ),
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFEDF1F3), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFEDF1F3), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFEDF1F3), width: 1),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
