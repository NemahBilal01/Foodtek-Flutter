import 'package:firebasewithnotification/view/Widget/common_layout_bottomnavbaronly.dart';
import 'package:firebasewithnotification/view/screens/delivery_hero_screen.dart';
import 'package:firebasewithnotification/view/screens/delivery_screen.dart';
import 'package:firebasewithnotification/view/screens/login.dart';
import 'package:firebasewithnotification/view/screens/profile2_screen.dart';
import 'package:flutter/material.dart';

import '../../components/applocal.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavBarOnly(
      appBar: AppBar(
        title: Text(
          getLang(context, "profile"),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DeliveryHeroPage()), // غير الاسم حسب الصفحة المطلوبة
            );
          },
        ),


      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 5, left: 35),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("images/Mask group.png"),
                ),
                SizedBox(height: 10),
                Container(
                  width: 158,
                  height: 46,
                  alignment: Alignment.center,
                  child: Column(
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
                        "ahmad1709@gmail.com",
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
                SizedBox(height: 16),
                _buildContainer(getLang(context, "my_account"), [
                  _buildListTile(
                    Icons.person_add_alt_outlined,
                    getLang(context, "personal_info"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile2Screen()),
                      );
                    },
                  ),
                  _buildListTile(
                    Icons.language,
                    getLang(context, "language"),
                    trailing: Text("عربيه"),
                  ),
                  _buildListTile(Icons.privacy_tip_outlined, getLang(context, "privacy_policy")),
                  _buildListTile(Icons.settings_outlined, getLang(context, "setting")),
                ]),
                SizedBox(height: 16),
                _buildContainer(getLang(context, "notifications"), [
                  _buildListTile(
                    Icons.notifications_none,
                    getLang(context, "push_notifications"),
                    trailing: Switch(value: true, onChanged: (val) {}),
                  ),
                  _buildListTile(
                    Icons.notifications_none,
                    getLang(context, "promo_notifications"),
                    trailing: Switch(value: false, onChanged: (val) {}),
                  ),
                ]),
                SizedBox(height: 16),
                _buildContainer(getLang(context, "more"), [
                  _buildListTile(Icons.help_outline, getLang(context, "help_center")),
                  _buildListTile(
                    Icons.logout,
                    getLang(context, "logout"),
                    textColor: Color(0xFFDC1010),
                    iconColor: Color(0xFFDC1010),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                  ),

                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(String title, List<Widget> children) {
    return Container(
      width: 380,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFF5F5F5)),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 15, spreadRadius: 0),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0xFF1B1B1B),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
    IconData icon,
    String title, {
    Widget? trailing,
    Color textColor = Colors.black,
    Color iconColor = Colors.black,
        VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: iconColor, size: 18),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: textColor,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
