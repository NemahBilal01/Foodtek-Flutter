import 'package:firebasewithnotification/view/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonLayoutWithoutNavBar extends StatefulWidget {
  final Widget body;

  const CommonLayoutWithoutNavBar({required this.body, super.key});

  @override
  State<CommonLayoutWithoutNavBar> createState() =>
      _CommonLayoutWithoutNavBarState();
}

class _CommonLayoutWithoutNavBarState extends State<CommonLayoutWithoutNavBar> {
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationScreen(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Image.asset("images/loc.png"),
                      ),
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
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Expanded(child: widget.body),
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
