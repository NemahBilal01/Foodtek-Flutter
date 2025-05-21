import 'package:flutter/material.dart';
import '../model/postman_model.dart';
import '../services/apiService.dart';


class HomeProvider with ChangeNotifier {

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

      categories = await ApiService.fetchCategories();
      topRated = await ApiService.fetchTopRatedItems();
      recommended = await ApiService.fetchTopRecommendedItems();
      offers = await ApiService.fetchOffers();

    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

