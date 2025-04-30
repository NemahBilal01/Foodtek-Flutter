import 'package:firebasewithnotification/view/screens/cheeseburger%20_screen.dart';
import 'package:firebasewithnotification/view/screens/favorite_screen%20.dart';
import 'package:firebasewithnotification/view/screens/location_screen.dart';
import 'package:firebasewithnotification/view/screens/pizza_category.dart';
import 'package:firebasewithnotification/view/widget/common_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilter = "All";


  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      body: Column(
        children: [
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
