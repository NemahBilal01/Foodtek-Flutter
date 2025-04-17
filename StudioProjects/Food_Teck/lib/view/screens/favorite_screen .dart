import 'package:firebasewithnotification/controller/favorite_provider.dart';
import 'package:firebasewithnotification/view/widget/common_layout_withoutfilterclips.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProvider, child) {
        final favoritePizzas =
        favoriteProvider.favoritePizzas.where((pizza) {
          final category =
              pizza['category']?.toString().toLowerCase() ?? '';
          return !['all', 'burger', 'pizza', 'sandwich'].contains(category);
        }).toList();

        return CommonLayoutWithoutfilterclips(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                child: Text(
                  "Favorites",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),

              SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child:
                  favoritePizzas.isEmpty
                      ? Center(
                    child: Text(
                      "No favorite items yet!",
                      style: GoogleFonts.sora(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                  )
                      : GridView.builder(padding: EdgeInsets.only(top: 40),
                    shrinkWrap: false,
                    physics: BouncingScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 35,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: favoritePizzas.length,
                    itemBuilder: (context, index) {
                      return _buildPizzaCard(
                        context,
                        favoritePizzas[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
                onTap:
                    () => _showRemoveDialog(context, favoriteProvider, pizza),

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

void _showRemoveDialog(
  BuildContext context,
  FavoriteProvider provider,
  Map<String, dynamic> pizza,
) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.transparent,
    builder:
        (context) => GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(color: Colors.black.withOpacity(0.65)),
                  ),
                ),
              ),
              Center(
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  content: SizedBox(
                    width: 263,
                    height: 44,
                    child: Center(
                      child: Text(
                        "Are you sure you want to remove it from favorites?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                          // 140%
                          letterSpacing: -0.01,
                          // -1%
                          color: Color(0xFF6C7278),
                        ),
                      ),
                    ),
                  ),

                  actions: [
                    Center(
                      child: SizedBox(
                        width: 295,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            provider.toggleFavorite(pizza);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF25AE4B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                width: 1,
                                color: Color(0xFF25AE4B),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 24,
                            ),
                          ),
                          child: Text(
                            "Yes",
                            style: GoogleFonts.sora(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
  );
}
