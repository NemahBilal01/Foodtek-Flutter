import 'package:flutter/foundation.dart';

import '../model/postman_model.dart';
import '../services/apiService.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String? currentOrderId;
  final ApiService _orderService = ApiService();

  Future<void> fetchOrders(int userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _orders = await _orderService.getUserOrders(userId);
    } catch (e) {
      print('Error loading requests: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }}
    void addOrder(List<Map<String, dynamic>> cartItems, double totalPrice) {
      final newOrderId = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();

      // _orders.add({
      //   'id': newOrderId,
      //   'items': List<Map<String, dynamic>>.from(cartItems),
      //   'totalPrice': totalPrice,
      //   'date': DateTime.now(),
      // });

      currentOrderId = newOrderId;

      notifyListeners();
    }
  }
