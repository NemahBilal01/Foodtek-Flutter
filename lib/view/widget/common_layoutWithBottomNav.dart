import 'package:firebasewithnotification/view/screens/cart_screen.dart';
import 'package:firebasewithnotification/view/screens/history_screen.dart';
import 'package:firebasewithnotification/view/screens/home_screen.dart';
import 'package:firebasewithnotification/view/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import '../screens/favorite_screen .dart';

class CommonLayoutWithBottomNav extends StatefulWidget {
  final Widget body;

  const CommonLayoutWithBottomNav({required this.body, super.key});

  @override
  State<CommonLayoutWithBottomNav> createState() =>
      _CommonLayoutWithBottomNavState();
}

class _CommonLayoutWithBottomNavState extends State<CommonLayoutWithBottomNav> {
  int _selectedIndex = 0;

  // String selectedFilter = "All";

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
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                builder: (context) {
                  return DraggableScrollableSheet(
                    initialChildSize: 0.7,
                    minChildSize: 0.4,
                    maxChildSize: 0.9,
                    expand: false,
                    builder: (context, scrollController) {
                      return _buildNotificationsList(scrollController);
                    },
                  );
                },
              );
            },
          ),
          SizedBox(height: 20),
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            // 📦 Actual Content
            Expanded(child: widget.body),
          ],
        ),
      ),
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
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String message;
  final String date;
  final bool isRead;

  NotificationItem({
    required this.title,
    required this.message,
    required this.date,
    required this.isRead,
  });
}

List<NotificationItem> _allNotifications = [
  NotificationItem(
    title: "Delayed Order:",
    message:
        "We’re sorry! Your order is running late. New ETA: 10:30 PM. Thanks for your patience!",
    date: "Last Wednesday at 9:42 AM",
    isRead: false,
  ),
  NotificationItem(
    title: "Promotional Offer",
    message:
        "Craving something delicious? 🍔 Get 20% off on your next order. Use code: YUMMY20.",
    date: "Last Wednesday at 9:42 AM",
    isRead: true,
  ),
  NotificationItem(
    title: "Out for Delivery:",
    message:
        "Your order is on the way! 🚗 Estimated arrival: 15 mins. Stay hungry!",
    date: "Last Wednesday at 9:42 AM",
    isRead: false,
  ),
  NotificationItem(
    title: "Order Confirmation:",
    message:
        "Your order has been placed! 🍔 We're preparing it now. Track your order live!",
    date: "Last Wednesday at 9:42 AM",
    isRead: true,
  ),
  NotificationItem(
    title: "Delivered:",
    message:
        "Enjoy your meal! 🍕 Your order has been delivered. Rate your experience!",
    date: "",
    isRead: true,
  ),
];

Widget _buildNotificationsList(ScrollController scrollController) {
  return DefaultTabController(
    length: 3,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Notifications",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 16),
          TabBar(
            labelColor: Colors.green,
            indicatorColor: Colors.green,
            indicatorWeight: 3,
            tabs: [
              Tab(text: "All"),
              Tab(text: "Unread"),
              Tab(text: "Read"),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              children: [
                _buildNotificationListByType("all"),
                _buildNotificationListByType("unread"),
                _buildNotificationListByType("read"),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildNotificationListByType(String type) {
  List<NotificationItem> filteredNotifications;

  if (type == "unread") {
    filteredNotifications = _allNotifications.where((n) => !n.isRead).toList();
  } else if (type == "read") {
    filteredNotifications = _allNotifications.where((n) => n.isRead).toList();
  } else {
    filteredNotifications = _allNotifications;
  }

  return ListView.builder(
    itemCount: filteredNotifications.length,
    itemBuilder: (context, index) {
      final notification = filteredNotifications[index];
      return _buildNotificationItem(
        notification.title,
        notification.message,
        notification.date,
      );
    },
  );
}

Widget _buildNotificationItem(String title, String message, String date) {
  return ListTile(
    title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(message),
        if (date.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              date,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
      ],
    ),
  );
}
