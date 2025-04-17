import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _favoritePizzas = [];

  List<Map<String, dynamic>> get favoritePizzas => _favoritePizzas;

  void toggleFavorite(Map<String, dynamic> pizza) {
    if (_favoritePizzas.contains(pizza)) {
      _favoritePizzas.remove(pizza);
    } else {
      _favoritePizzas.add(pizza);
    }
    notifyListeners();
  }

  bool isFavorite(Map<String, dynamic> pizza) {
    return _favoritePizzas.contains(pizza);
  }
}
