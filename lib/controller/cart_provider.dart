import 'dart:convert';

import 'package:firebasewithnotification/model/postman_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  Future<void> loadCartFromApi(int userId) async {
    try {
      final url = Uri.parse("http://172.233.67.77:2020/api/cart-items/$userId");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        final List data = jsonBody['data'];

        _cartItems = data.map<Map<String, dynamic>>((item) {
          final foodItem = FoodItem.fromJson(item['food_item']);
          return {
            'id': foodItem.id,
            'name': foodItem.nameAr,
            'price': foodItem.price,
            'image': foodItem.imagePath,
            'quantity': item['quantity'],
          };
        }).toList();

        notifyListeners();
      } else {
        throw Exception("فشل في تحميل السلة");
      }
    } catch (e) {
      print("Error fetching cart: $e");
    }
  }

  void addToCart(Map<String, dynamic> item) {
    bool itemExists = false;
    for (var cartItem in _cartItems) {
      if (cartItem['name'] == item['name']) {
        cartItem['quantity'] += 1;
        itemExists = true;
        break;
      }
    }
    if (!itemExists) {
      _cartItems.add({...item, 'quantity': 1});
    }
    notifyListeners();
  }

  void removeFromCart(String itemName) {
    _cartItems.removeWhere((item) => item['name'] == itemName);
    notifyListeners();
  }

  void updateQuantity(String itemName, int change) {
    for (var cartItem in _cartItems) {
      if (cartItem['name'] == itemName) {
        cartItem['quantity'] += change;
        if (cartItem['quantity'] <= 0) {
          _cartItems.remove(cartItem);
        }
        break;
      }
    }
    notifyListeners();
  }

  double getTotalPrice() {
    return _cartItems.fold(
        0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  void clearCart() {
    _cartItems.clear(); // Assuming your cart items list is named _cartItems
    notifyListeners();
  }
}
