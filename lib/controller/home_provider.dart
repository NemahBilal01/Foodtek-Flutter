import 'package:flutter/material.dart';
import '../model/postman_model.dart';
import '../services/apiService.dart';

class HomeProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool isLoading = true;
  String? error;

  List<Category> categories = [];
  List<TopRatedItem> topRated = [];
  List<RecommendedItem> recommended = [];
  List<Offer> offers = [];

  Future<void> fetchData() async {
    try {
      isLoading = true;
      error = null;

      notifyListeners();

      categories = await _apiService.fetchCategories();
      topRated = await _apiService.fetchTopRatedItems();
      recommended = await _apiService.fetchTopRecommendedItems();
      offers = await _apiService.fetchOffers();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
