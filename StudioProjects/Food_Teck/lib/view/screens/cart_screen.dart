import 'package:firebasewithnotification/controller/cart_provider.dart';
import 'package:firebasewithnotification/controller/order_provider.dart';
import 'package:firebasewithnotification/view/screens/emptyState_screen.dart';
import 'package:firebasewithnotification/view/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: cartProvider.cartItems.isEmpty
                    ? EmptyState(
                        imagePath: 'images/Empty State.png',
                        text: 'Cart Empty',
                        subText:
                            'You don’t have any food in your cart at this time.',
                      )
                    : ListView.builder(
                        itemCount: cartProvider.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartProvider.cartItems[index];
                          return Dismissible(
                            key: Key(item['name'] ?? UniqueKey().toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                color: Color(0XFFFDAC1D),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Icon(Icons.delete,
                                  color: Colors.white, size: 48),
                            ),
                            onDismissed: (direction) {
                              cartProvider.removeFromCart(item['name'] ?? '');
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(color: Color(0XFFDBF4D1)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: Image.asset(
                                      item['image'] ?? 'images/default.png',
                                      width: 62.w,
                                      height: 62.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name'] ?? 'No Name',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          item['restaurant'] ??
                                              'Unknown Restaurant',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "\$${item['price'] ?? 0}",
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0XFF25AE4B),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            cartProvider.updateQuantity(
                                                item['name'] ?? '', -1),
                                        icon: Icon(Icons.remove),
                                      ),
                                      Text(
                                        item['quantity']?.toString() ?? '1',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            cartProvider.updateQuantity(
                                                item['name'] ?? '', 1),
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          if (cartProvider.cartItems.isNotEmpty)
            Positioned(
              bottom: 70,
              left: 24,
              right: 24,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0XFF25AE4B),
                  borderRadius: BorderRadius.circular(7),
                  image: DecorationImage(
                    image: AssetImage("images/Pattern (1).png"),
                    fit: BoxFit.cover,
                    opacity: 0.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPriceRow(
                        'Sub-Total', '\$${cartProvider.getTotalPrice()}'),
                    _buildPriceRow('Delivery Charge', '10 \$'),
                    _buildPriceRow('Discount', '10 \$'),
                    _buildPriceRow(
                        'Total:', '\$${cartProvider.getTotalPrice() + 10 - 10}',
                        isTotal: true),
                    SizedBox(height: 4),
                    SizedBox(
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            final cartProvider = context.read<CartProvider>();
                            final orderProvider = context.read<OrderProvider>();

                            if (cartProvider.cartItems.isNotEmpty) {
                              orderProvider.addOrder(cartProvider.cartItems,
                                  cartProvider.getTotalPrice());
                              cartProvider.clearCart();
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.green,
                            minimumSize: const Size(366.017, 57),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          child: const Text(
                            'Place My Order',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0XFF25AE4B),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0XFF25AE4B),
        foregroundColor: Colors.white,
        elevation: 25,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {
          cartProvider.addToCart({
            'name': 'Chicken Burger',
            'price': 20,
            'restaurant': 'Burger Factory LTD',
            'image': "images/Menu_Photo.png"
          });
        },
        child: const Icon(Icons.add_shopping_cart, size: 30),
      ),
    );
  }
}

Widget _buildPriceRow(String label, String price, {bool isTotal = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: Colors.white,
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
