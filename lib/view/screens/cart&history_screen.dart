
import 'package:firebasewithnotification/view/screens/cart_screen.dart';
import 'package:firebasewithnotification/view/screens/favorite_screen%20.dart';
import 'package:firebasewithnotification/view/screens/history_screen.dart';
import 'package:firebasewithnotification/view/screens/home_screen.dart';
import 'package:firebasewithnotification/view/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../components/applocal.dart';


class CartAndHistoryScreen extends StatefulWidget {
  const CartAndHistoryScreen({super.key});

  @override
  _CartAndHistoryScreenState createState() => _CartAndHistoryScreenState();
}

class _CartAndHistoryScreenState extends State<CartAndHistoryScreen> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    HomeScreen(),
    FavoriteScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0XFFDBF4D1),
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0XFF25AE4B),
        unselectedItemColor: const Color(0XFF484C52),
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: getLang(context, "home"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_border),
            label: getLang(context, "favorites"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.history),
            label: getLang(context, "history"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: getLang(context, "profile"),
          ),
        ],
      ),
    );
  }


  Widget _buildTabScreen(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getLang(context, "current_location"),
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                getLang(context, "address_example"),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: getLang(context, "cart")),
              Tab(text: getLang(context, "history")),
            ],
            indicatorColor: const Color(0XFF25AE4B),
            labelColor: const Color(0XFF25AE4B),
            unselectedLabelColor: const Color(0XFF98A0B4),
            labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        body:  TabBarView(
          children: [
            CartScreen(),
            HistoryScreen(),
          ],
        ),
      ),
    );
  }
}

