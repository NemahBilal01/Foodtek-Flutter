import 'package:firebasewithnotification/controller/favorite_provider.dart';
import 'package:firebasewithnotification/view/widget/common_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart' ;


class PizzaCategory extends StatelessWidget {
  final List<Map<String, dynamic>> pizzas = [
    {
      'name': 'Pepperoni Pizza',
      'description': 'Pepperoni pizza, Margarita Pizza Margherita Italian cuisine Tomato',
      'price': 29,
      'image': 'images/margarita-pizza.png',
    },
    {
      'name': 'Pizza Cheese',
      'description': 'Food pizza dish cuisine junk food, Fast Food, Flatbread, Ingredient',
      'price': 23,
      'image': 'images/Pizza_Cheese.png',
    },
    {
      'name': 'Peppy Paneer',
      'description': 'Chunky paneer with crisp capsicum and spicy red pepper',
      'price': 13,
      'image': 'images/Peppy_Paneer.png',
    },
    {
      'name': 'Mexican Green Wave',
      'description': 'A pizza loaded with crunchy onions, crisp capsicum, juicy tomatoes',
      'price': 23,
      'image': 'images/Mexican_Green_Wave.png',
    },
  ];

  final String categoryName;

  PizzaCategory({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 35,
                  childAspectRatio: 0.75,
                ),
                itemCount: pizzas.length,
                itemBuilder: (context, index) {
                  return _buildPizzaCard(context, pizzas[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPizzaCard(BuildContext context, Map<String, dynamic> pizza) {
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProvider, child) {
        bool isFav = favoriteProvider.isFavorite(pizza);

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 177,
              height: 200,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xC5969AB0),
                ),

                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black12,
                //     blurRadius: 8,
                //     spreadRadius: 2,
                //   ),
                // ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Text(
                    pizza['name'],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sora(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    pizza['description'],
                    textAlign: TextAlign.left,
                    style: GoogleFonts.sora(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF969AB0),
                    ),
                  ),
                  Text(
                    '\$${pizza['price']}',
                    style: GoogleFonts.sora(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    width: 95,
                    height: 27,
                    decoration: BoxDecoration(
                      color: Color(0xFF25AE4B),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Order Now',
                      style: GoogleFonts.sora(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: -40,
              left: 50,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(pizza['image']),
              ),
            ),

            Positioned(
              top: -10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  favoriteProvider.toggleFavorite(pizza);
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color(0xFFDBF4D1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    size: 20,
                    color: isFav ? Colors.red : Color(0xFF222628),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
