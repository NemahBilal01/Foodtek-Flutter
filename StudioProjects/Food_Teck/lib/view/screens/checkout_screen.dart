import 'package:firebasewithnotification/controller/cart_provider.dart';
import 'package:firebasewithnotification/controller/order_provider.dart';
import 'package:firebasewithnotification/view/screens/add_card_screen.dart';
import 'package:firebasewithnotification/view/screens/location_screen.dart';
import 'package:firebasewithnotification/view/widget/common_layoutWithBottomNav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  String selectedAddress = '5 Noe Zhordania St';
  String paymentMethod = 'Card';
  String cardType = 'MasterCard';


  @override
  Widget build(BuildContext context) {
    return CommonLayoutWithBottomNav(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Checkout",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 6.h),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pay With:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: "Sub Headline 3 Bold",
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: -1.0),
                      leading: Radio(
                        visualDensity: VisualDensity(horizontal: -4.0),
                        value: '88 Zurab Gorgiladze St',
                        groupValue: selectedAddress,
                        onChanged: (value) {
                          setState(() {
                            selectedAddress = value.toString();
                          });
                        },
                      ),
                      title: Text(
                        '88 Zurab Gorgiladze St',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Color(0xFF2F2E36),
                        ),
                      ),
                      subtitle: Text(
                        'Georgia, Batumi',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Color(0xFFB8B8B8),
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: -1.0),
                      leading: Radio(
                        visualDensity: VisualDensity(horizontal: -3.0),
                        value: '5 Noe Zhordania St',
                        groupValue: selectedAddress,
                        onChanged: (value) {
                          setState(() {
                            selectedAddress = value.toString();
                          });
                        },
                      ),
                      title: Text(
                        '5 Noe Zhordania St',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Color(0xFF2F2E36),
                        ),
                      ),
                      subtitle: Text(
                        'Georgia, Batumi',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Color(0xFFB8B8B8),
                        ),
                      ),
                      trailing: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Change',
                          style: TextStyle(
                            color: Color(0xFF25AE4B),
                            fontFamily: "Inter",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Promo Code?',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: "Inter",
                        color: Color(0xFF0A0D13),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 42.h,
                            padding: EdgeInsets.fromLTRB(16, 12, 16, 13),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Color(0xFFD6D6D6),
                              ),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter Your Promo',
                                hintStyle: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  height: 1.5.h,
                                  letterSpacing: 0,
                                  color: Color(0xFF878787),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF25AE4B),
                            minimumSize: Size(90, 42),
                            padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                          ),
                          child: Text(
                            'Add',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.5,
                              // line-height: 150%
                              letterSpacing: 0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Pay With:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: "Inter",
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                value: 'Card',
                                groupValue: paymentMethod,
                                activeColor: Color(0xFF25AE4B),
                                visualDensity: VisualDensity(horizontal: -4.0),
                                fillColor: MaterialStateProperty.resolveWith<
                                  Color
                                >((Set<MaterialState> states) {
                                  return states.contains(MaterialState.selected)
                                      ? Color(0xFF25AE4B)
                                      : Color(0xFFACACAC);
                                }),
                                onChanged: (value) {
                                  setState(() {
                                    paymentMethod = value.toString();
                                  });
                                },
                              ),
                              Text(
                                'Card',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  color:
                                      paymentMethod == 'Card'
                                          ? Color(0xFF0A0D13)
                                          : Color(0xFFACACAC),
                                ),
                              ),
                              SizedBox(width: 7.w),
                              Radio(
                                value: 'Cash',
                                groupValue: paymentMethod,
                                activeColor: Color(0xFF25AE4B),
                                visualDensity: VisualDensity(horizontal: -4.0),
                                fillColor: MaterialStateProperty.resolveWith<
                                  Color
                                >((Set<MaterialState> states) {
                                  return states.contains(MaterialState.selected)
                                      ? Color(0xFF25AE4B)
                                      : Color(0xFFACACAC);
                                }),
                                onChanged: (value) {
                                  setState(() {
                                    paymentMethod = value.toString();
                                  });
                                },
                              ),
                              Text(
                                'Cash',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  color:
                                      paymentMethod == 'Cash'
                                          ? Color(0xFF0A0D13)
                                          : Color(0xFFACACAC),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Card Type:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: "Inter",
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                value: 'MasterCard',
                                groupValue: cardType,
                                activeColor: Color(0xFF25AE4B),
                                visualDensity: VisualDensity(horizontal: -4.0),
                                fillColor: MaterialStateProperty.resolveWith<
                                  Color
                                >((Set<MaterialState> states) {
                                  return states.contains(MaterialState.selected)
                                      ? Color(0xFF25AE4B)
                                      : Color(0xFFACACAC);
                                }),
                                onChanged: (value) {
                                  setState(() {
                                    cardType = value.toString();
                                  });
                                },
                              ),
                              SizedBox(width: 1.w),
                              Image.asset('images/Mastercard.png', width: 40.w),
                              SizedBox(width: 2),
                              Radio(
                                value: 'Visa',
                                groupValue: cardType,
                                activeColor: Color(0xFF25AE4B),
                                visualDensity: VisualDensity(horizontal: -4.0),
                                fillColor: MaterialStateProperty.resolveWith<
                                  Color
                                >((Set<MaterialState> states) {
                                  return states.contains(MaterialState.selected)
                                      ? Color(0xFF25AE4B)
                                      : Color(0xFFACACAC);
                                }),
                                onChanged: (value) {
                                  setState(() {
                                    cardType = value.toString();
                                  });
                                },
                              ),
                              SizedBox(width: 1),
                              Image.asset('images/Visa.png', width: 40.w),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              OrderSummaryCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderSummaryCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    return Container(
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
          _buildPriceRow('Sub-Total', '\$${cartProvider.getTotalPrice()}'),
          _buildPriceRow('Delivery Charge', '10 \$'),
          _buildPriceRow('Discount', '10 \$'),
          _buildPriceRow('Total:', '\$${cartProvider.getTotalPrice() + 10 - 10}',
              isTotal: true),
          SizedBox(height: 4.h),
          SizedBox(
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  final cartProvider = context.read<CartProvider>();
                  final orderProvider = context.read<OrderProvider>();

                  if (cartProvider.cartItems.isNotEmpty) {
                    orderProvider.addOrder(cartProvider.cartItems, cartProvider.getTotalPrice());
                    cartProvider.clearCart();
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddCardScreen()),
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
      ));

  }

  Widget _buildSummaryRow(String title, String amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 20 : 16,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isTotal ? 20 : 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Information",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Payment Method:",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            Text(
              "Credit Card",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Card Type:",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            Text(
              "MasterCard",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
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


