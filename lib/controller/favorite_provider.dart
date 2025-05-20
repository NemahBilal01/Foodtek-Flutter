import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/apiService.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _favoriteItems = [];

  List<Map<String, dynamic>> get favoriteItems => _favoriteItems;

  Future<void> fetchFavorites() async {
    final url = Uri.parse('${ApiService.baseUrl}${ApiEndpoints.favorites}');
    try {
      final response = await http.get(url, headers: ApiService.headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        _favoriteItems = List<Map<String, dynamic>>.from(jsonData['data']);
        notifyListeners();
      } else {
        throw Exception('Failed to load favorites');
      }
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  void toggleFavorite(Map<String, dynamic> item) {
    final index = _favoriteItems.indexWhere((element) => element['id'] == item['id']);
    if (index != -1) {
      _favoriteItems.removeAt(index);
    } else {
      _favoriteItems.add(item);
    }
    notifyListeners();
  }

  bool isFavorite(Map<String, dynamic> item) {
    return _favoriteItems.any((fav) => fav['id'] == item['id']);
  }
}
