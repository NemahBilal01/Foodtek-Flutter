import 'package:firebasewithnotification/view/screens/cart_screen.dart';
import 'package:firebasewithnotification/view/screens/favorite_screen%20.dart';
import 'package:firebasewithnotification/view/screens/history_screen.dart';
import 'package:firebasewithnotification/view/screens/home_screen.dart';
import 'package:firebasewithnotification/view/screens/profile2_screen.dart';
import 'package:firebasewithnotification/view/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBarOnly extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;

  const BottomNavBarOnly({super.key, this.appBar, required this.body});

  @override
  State<BottomNavBarOnly> createState() => _BottomNavBarOnlyState();

}

class _BottomNavBarOnlyState extends State<BottomNavBarOnly> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.appBar,
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFFDBF4D1),
          selectedItemColor: Color(0xFF25AE4B),
          unselectedItemColor: Color(0xFF484C52),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          iconSize: 24,
          selectedFontSize: 14,
          unselectedFontSize: 12,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: "Favorites",
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFF25AE4B),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.shopping_cart_outlined, color: Colors.white),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Profile",
            ),
          ],
        ));
  }
}
