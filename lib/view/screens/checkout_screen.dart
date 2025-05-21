import 'package:firebasewithnotification/controller/cart_provider.dart';
import 'package:firebasewithnotification/controller/order_provider.dart';
import 'package:firebasewithnotification/view/screens/add_card_screen.dart';
import 'package:firebasewithnotification/view/screens/location_screen.dart';
import 'package:firebasewithnotification/view/widget/common_layoutWithBottomNav.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../components/applocal.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  late String selectedAddress;
  late String paymentMethod;
  late String cardType;

  @override
  void initState() {
    super.initState();

    selectedAddress = getLang(context, "address");
    paymentMethod = getLang(context, "payment_method");
    cardType = getLang(context, "card_type");
  }



  @override
  Widget build(BuildContext context) {
    return CommonLayoutWithBottomNav(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                getLang(context, "checkout"),
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Color(0xFF391713),
                ),
              ),
              SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getLang(context, "pay_with"),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: "Sub Headline 3 Bold",
                        color: Color(0xFF0A0D13),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: -1.0),
                      leading: Radio(
                        visualDensity: VisualDensity(horizontal: -4.0),
                        value: getLang(context, "zurab"),
                        groupValue: selectedAddress,
                        onChanged: (value) {
                          setState(() {
                            selectedAddress = value.toString();
                          });
                        },
                      ),
                      title: Text(
                        getLang(context, "zurab"),
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Color(0xFF2F2E36),
                        ),
                      ),
                      subtitle: Text(
                        getLang(context, "location Georgia"),
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
                        value: getLang(context, "address details"),
                        groupValue: selectedAddress,
                        onChanged: (value) {
                          setState(() {
                            selectedAddress = value.toString();
                          });
                        },
                      ),
                      title: Text(
                       getLang(context, "address details"),
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Color(0xFF2F2E36),
                        ),
                      ),
                      subtitle: Text(
                        getLang(context, "location Georgia"),
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
                          getLang(context, "change"),
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
                      getLang(context, "promo_code"),
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
                            height: 42,
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
                                hintText: getLang(context, "enter_your_promo"),
                                hintStyle: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  height: 1.5,
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
                            getLang(context, "add"),
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
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            getLang(context, "pay_with"),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: "Inter",
                              color: Color(0xFF0A0D13),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                value: getLang(context, "payment_method"),
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
                                getLang(context, "payment_method"),
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
                              SizedBox(width: 7),
                              Radio(
                                value: getLang(context, 'Cash'),
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
                                getLang(context, 'Cash'),
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

                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            getLang(context, 'Cash'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: "Inter",
                              color: Color(0xFF0A0D13),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                value: getLang(context, "card_type"),
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
                              Image.asset('images/Mastercard.png', width: 40),
                              SizedBox(width: 2),
                              Radio(
                                value: getLang(context, 'Visa'),
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
                              Image.asset('images/Visa.png', width: 40),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
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
          _buildPriceRow(getLang(context, 'Sub-Total'), '\$${cartProvider.getTotalPrice()}'),
          _buildPriceRow(getLang(context, 'Delivery Charge'), '10 \$'),
          _buildPriceRow(getLang(context, 'discount'), '10 \$'),
          _buildPriceRow(getLang(context, 'Total:'), '\$${cartProvider.getTotalPrice() + 10 - 10}', isTotal: true),

          SizedBox(height: 4),
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
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,
                  minimumSize: const Size(366.017, 57),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child:  Text(
                  getLang(context, 'Place My Order'),
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
              color: Colors.white,
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
          getLang(context, "Payment Information"),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getLang(context, "Payment Met:"),
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            Text(
              getLang(context, "Credit Card"),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getLang(context, "Card Type:"),
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            Text(
              getLang(context, "card_type"),
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


