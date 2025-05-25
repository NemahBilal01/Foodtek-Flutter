import 'dart:ui';

import 'package:firebasewithnotification/controller/favorite_provider.dart';
import 'package:firebasewithnotification/helpers/auth_storage.dart';
import 'package:firebasewithnotification/view/widget/common_layout_withoutfilterclips.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../components/applocal.dart';
import '../../services/apiService.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool _isLoaded = false;
  void didChangeDependencies() {
    if (!_isLoaded) {
      Provider.of<FavoriteProvider>(context, listen: false).fetchFavorites();
      _isLoaded = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProvider, child) {
        final favoriteItems = favoriteProvider.favoriteItems;

        return CommonLayoutWithoutfilterclips(
          body: Column(
            children: [
              SizedBox(height: 20),
              Text(
                getLang(context, "favorites"),
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600, fontSize: 20),
              ),
              SizedBox(height: 20),
              Expanded(
                child: favoriteItems.isEmpty
                    ? Center(
                        child: Text(getLang(context, "no_favorite_items_yet")))
                    : GridView.builder(
                        padding: EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: favoriteItems.length,
                        itemBuilder: (context, index) {
                          return _buildPizzaCard(context, favoriteItems[index]);
                        },
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
      builder: (context, provider, child) {
        final isFav = provider.isFavorite(pizza);

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 177,
              height: 200,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
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
                      color: Color(0xFF24262F),
                    ),
                  ),
                  Text(
                    pizza['description'],
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.sora(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF969AB0),
                    ),
                  ),
                  Text(
                    getLang(context, "price_label") + '\$${pizza['price']}',
                    style: GoogleFonts.sora(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF24262F),
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
                      getLang(context, 'order_now'),
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
                backgroundImage: NetworkImage(pizza['imagePath'] ??
                    'https://via.placeholder.com/640x450.png/0099ff?text=food+consequatur'),
              ),
            ),
            Positioned(
              top: -10,
              right: 10,
              child: GestureDetector(
                onTap: () async {
                  final token = await AuthStorage.getToken();
                  final userId = await AuthStorage.getUserId();
                  if (token == null || userId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('You must be logged in')),
                    );
                    return;
                  }

                  if (isFav) {
                    _showRemoveDialog(context, provider, pizza, userId, token);
                  } else {
                    try {
                      await ApiService.addToFavorites(
                        userId: userId,
                        foodItemId: pizza['id'],
                        token: token,
                      );
                      provider.toggleFavorite(pizza);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to add to favorites')),
                      );
                    }
                  }
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

void _showRemoveDialog(
  BuildContext context,
  FavoriteProvider provider,
  Map<String, dynamic> pizza,
  int userId,
  String token,
) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.transparent,
    builder: (context) => GestureDetector(
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
              backgroundColor: Colors.white,
              content: SizedBox(
                width: 263,
                height: 44,
                child: Center(
                  child: Text(
                    getLang(context, 'remove_from_favorites'),
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
                      onPressed: () async {
                        try {
                          final token = await AuthStorage.getToken();
                          final favoriteId = pizza['id'];

                          await ApiService.removeFromFavorites(
                            favoriteId: favoriteId,
                            token: token!,
                          );

                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(getLang(context, 'removed_successfully'))),
                          );
                        } catch (e) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${getLang(context, 'remove_failed')} : ${e.toString()}')),
                          );
                        }
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
                        getLang(context, "yes"),
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
