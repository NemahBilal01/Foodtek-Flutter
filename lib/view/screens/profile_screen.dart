import 'package:firebasewithnotification/controller/theme_provider.dart';
import 'package:firebasewithnotification/services/apiService.dart';
import 'package:firebasewithnotification/view/Widget/common_layout_bottomnavbaronly.dart';
import 'package:firebasewithnotification/view/screens/delivery_hero_screen.dart';
import 'package:firebasewithnotification/view/screens/delivery_screen.dart';
import 'package:firebasewithnotification/view/screens/login.dart';
import 'package:firebasewithnotification/view/screens/profile2_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20, left: 35, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("images/Mask group.png"),
                ),
                SizedBox(height: 10),
                Text(
                  "Ahmad Daboor",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                Text(
                  "ahmad1709@gmail.com",
                  style: TextStyle(fontSize: 14, color: Color(0xFF838383)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          _buildContainer("My Account", context, [
            _buildListTile(Icons.person_add_alt_outlined, "Personal information", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => Profile2Screen()));
            }),
            _buildListTile(Icons.language, "Language", trailing: Text("عربيه")),
            _buildListTile(Icons.privacy_tip_outlined, "Privacy Policy"),
            _buildListTile(Icons.settings_outlined, "Setting"),
            _buildListTile(Icons.dark_mode, "Dark Mode",
              trailing: Switch(
                value: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false).toggleTheme(value);
                },
              ),
            ),
          ]),
          SizedBox(height: 16),
          _buildContainer("Notifications", context, [
            _buildListTile(Icons.notifications_none, "Push Notifications", trailing: Switch(value: true, onChanged: (_) {})),
            _buildListTile(Icons.notifications_none, "Promotional Notifications", trailing: Switch(value: false, onChanged: (_) {})),
          ]),
          SizedBox(height: 16),
          _buildContainer("More", context, [
            _buildListTile(Icons.help_outline, "Help Center"),
            _buildListTile(Icons.logout, "Log Out",
                textColor: Color(0xFFDC1010),
                iconColor: Color(0xFFDC1010),
                onTap: () async {
                  final api = ApiService();
                  final result = await api.logout();
                  if (result != null && result.message == "Logout successful") {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                          (route) => false,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logout failed")));
                  }
                }),
          ]),
        ],
      ),
    );
  }


  Widget _buildContainer(
      String title, BuildContext context, List<Widget> children) {
    return Container(
      width: 380,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFF5F5F5),
        ),

        // boxShadow: [
        //   BoxShadow(color: Colors.black12, blurRadius: 15, spreadRadius: 0),
        // ],
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
        leading: Icon(icon, size: 18),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
