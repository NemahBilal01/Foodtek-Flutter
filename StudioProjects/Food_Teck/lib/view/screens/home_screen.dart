import 'package:firebasewithnotification/view/screens/cheeseburger%20_screen.dart';
import 'package:firebasewithnotification/view/screens/favorite_screen%20.dart';
import 'package:firebasewithnotification/view/screens/location_screen.dart';
import 'package:firebasewithnotification/view/screens/pizza_category.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String selectedFilter = "All";

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FavoriteScreen()),
      );
    }
  }

  void _updateFilter(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
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
        child: Column(
          children: [
            Container(
              width: 420,
              height: 42,
              margin: EdgeInsets.only(left: 1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: "Search menu, restaurant or etc",
                  hintStyle: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Icon(Icons.search, color: Color(0xFF878787)),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(Icons.tune, color: Color(0xFF878787)),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip(
                    "All",
                    "",
                    selectedFilter,
                    _updateFilter,
                    context,
                  ),
                  SizedBox(width: 12),
                  _buildFilterChip(
                    "Burger",
                    "images/burger.png",
                    selectedFilter,
                    _updateFilter,
                    context,
                  ),
                  SizedBox(width: 12),
                  _buildFilterChip(
                    "Pizza",
                    "images/pizzaa.png",
                    selectedFilter,
                    _updateFilter,
                    context,
                  ),
                  SizedBox(width: 12),
                  _buildFilterChip(
                    "Sandwich",
                    "images/sandwich.png",
                    selectedFilter,
                    _updateFilter,
                    context,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  width: 410,
                  height: 128,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage("images/Frame 71.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 26,
                  left: 7,
                  child: Container(
                    width: 150,
                    height: 38,
                    alignment: Alignment.center,
                    child: Text(
                      "Experience our delicious new dish",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.0,
                        color: Color(0xFFF8F8F8),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Positioned(
                  top: 72,
                  left: 14,
                  child: Container(
                    width: 127,
                    height: 29,
                    alignment: Alignment.center,
                    child: Text(
                      "30% OFF",
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        height: 1.0,
                        color: Color(0xFFF8F8F8),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  bool isActive = index == 2;
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 20 : 20,
                    height: 5,
                    decoration: BoxDecoration(
                      color: isActive ? Color(0xFF25AE4B) : Color(0xFFDBF4D1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(
                  "Top Rated",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    height: 1.0,
                    letterSpacing: 0,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 10),
            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildProductCard(
                    context,
                    "Chicken burger",
                    "100 gr chicken + tomato + cheese + Lettuce",
                    "\$20.00",
                    "images/Chicken_Burger.png",
                    3.8,
                  ),
                  _buildProductCard(
                    context,
                    "Cheese burger",
                    "100 gr meat + onion + tomato + Lettuce cheese",
                    "\$15.00",
                    "images/cheese_burger.png",
                    4.5,
                  ),
                  _buildProductCard(
                    context,
                    "Chicken burger",
                    "100 gr chicken tomato +cheese",
                    "\$18.00",
                    "images/chicken.png",
                    3.8,
                    isLast: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recommend",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "View All",
                        style: TextStyle(
                          color: Color(0xFF25AE4B),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Color(0xFF25AE4B),
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 371,
              height: 108,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildRecommendedItem("images/Rectangle 133.png", "\$103.00"),
                  _buildRecommendedItem("images/Rectangle 128.png", "\$50.00"),
                  _buildRecommendedItem(
                    "images/Rectangle 128 (1).png",
                    "\$12.99",
                  ),
                  _buildRecommendedItem("images/Rectangle 136.png", "\$8.20"),
                ],
              ),
            ),
            SizedBox(height: 20),
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

Widget _buildProductCard(
  BuildContext context,
  String name,
  String description,
  String price,
  String imagePath,
  double rating, {
  bool isLast = false,
}) {
  return Container(
    width: 155,
    height: 250,
    margin: EdgeInsets.only(right: isLast ? 24 : 12),
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFDBF4D1), width: 1),
    ),
    child: SizedBox(
      height: 10,
      child: ListView(
        children: [
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 16),
              SizedBox(width: 3),
              Text(
                rating.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          ClipRRect(
            child: Image.asset(
              imagePath,
              width: 112,
              height: 76,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: Text(
              name,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.03,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 2),
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.03,
              color: Colors.grey.shade500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  price,
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.03,
                    color: Color(0xFF25AE4B),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheeseburgerDetailsScreen()),
                  );
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Color(0xFF25AE4B),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildFilterChip(
  String label,
  String imagePath,
  String selectedFilter,
  Function(String) onFilterSelected,
  BuildContext context,
) {
  bool isSelected = selectedFilter == label;
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;

  return GestureDetector(
    onTap: () {
      onFilterSelected(label);
      if (label == "Pizza") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PizzaCategory(categoryName: label),
          ),
        );
      }
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF25AE4B)
            : isDark
            ? Colors.black
            : Colors.white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: isSelected  ? Colors.green
              : isDark
              ? Colors.black!
              : const Color(0xFFDBF4D1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          if (label != "All") ...[
            Image.asset(imagePath, width: 24, height: 24),
            SizedBox(width: 12),
          ] else
            SizedBox(width: 2, height: 24),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? Colors.white
                  : isDark
                  ? Colors.white
                  : Colors.black,            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildRecommendedItem(String imagePath, String price) {
  return Container(
    width: 72,
    margin: EdgeInsets.only(right: 27.5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
    ),
    child: Align(
      alignment: Alignment.bottomRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(1),
          ),
        ),
        child: Text(
          price,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
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
