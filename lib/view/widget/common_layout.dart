import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonLayout extends StatelessWidget {
  final Widget body;

  const CommonLayout({required this.body, super.key});

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
        child: Column(
          children: [
            Container(
              width: 420,
              height: 42,
              margin: EdgeInsets.only(left: 1),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  _buildFilterChip("All", "", "", _updateFilter, context),
                  SizedBox(width: 12),
                  _buildFilterChip(
                    "Burger",
                    "images/burger.png",
                    "",
                    _updateFilter,
                    context,
                  ),
                  SizedBox(width: 12),
                  _buildFilterChip(
                    "Pizza",
                    "images/pizzaa.png",
                    "",
                    _updateFilter,
                    context,
                  ),
                  SizedBox(width: 12),
                  _buildFilterChip(
                    "Sandwich",
                    "images/sandwich.png",
                    "",
                    _updateFilter,
                    context,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(child: body),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {},
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

  void _updateFilter(String filter) {}

  Widget _buildFilterChip(
    String label,
    String imagePath,
    String selectedFilter,
    Function(String) onFilterSelected,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Color(0xFFDBF4D1), width: 1),
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
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
