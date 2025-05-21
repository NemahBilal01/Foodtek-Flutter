import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/postman_model.dart';

class ApiEndpoints {
  static const String categories = '/categories';
  static const String offers = '/special-offers';
  static const String rating = '/rating';
  static const String topRecommended = '/top-recommended';
  static const String foodByCategory = '/food-under-category';
  static const String favorites = '/favorites';
  static const String foodItems = '/food-items';
}

class ApiService {
  static const String baseUrl = 'http://172.233.67.77:2020/api';
  static const String genericError = 'Failed to load data';
  static const Duration timeout = Duration(seconds: 30);

  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<T> _handleResponse<T>({
    required http.Response response,
    required T Function(dynamic data) mapper,
    String? customErrorMessage,
  }) async {
    try {
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return mapper(data);
      } else {
        throw ApiException(
          message: customErrorMessage ?? genericError,
          statusCode: response.statusCode,
          responseData: response.body,
        );
      }
    } catch (e) {
      throw ApiException(
        message: '${customErrorMessage ?? genericError}: ${e.toString()}',
        statusCode: response.statusCode,
      );
    }
  }

  static Future<List<Category>> fetchCategories() async {
    return _fetchList<Category>(
      endpoint: ApiEndpoints.categories,
      key: 'categories',
      fromJson: (json) => Category.fromJson(json),
      errorMessage: 'Failed to load categories',
    );
  }

  static Future<List<Offer>> fetchOffers() async {
    return _fetchList<Offer>(
      endpoint: ApiEndpoints.offers,
      key: 'offers',
      fromJson: (json) => Offer.fromJson(json),
      errorMessage: 'Failed to load offers',
    );
  }

  static Future<List<TopRatedItem>> fetchTopRatedItems() async {
    return _fetchList<TopRatedItem>(
      endpoint: ApiEndpoints.rating,
      key: 'topFood',
      fromJson: (json) => TopRatedItem.fromJson(json),
      errorMessage: 'Failed to load top rated items',
    );
  }

  static Future<List<RecommendedItem>> fetchTopRecommendedItems() async {
    return _fetchList<RecommendedItem>(
      endpoint: ApiEndpoints.topRecommended,
      key: 'TopRecommended',
      fromJson: (json) => RecommendedItem.fromJson(json),
      errorMessage: 'Failed to load recommended items',
    );
  }

  static Future<List<FoodItem>> fetchItemsByCategory(int categoryId) async {
    return _fetchList<FoodItem>(
      endpoint: '${ApiEndpoints.foodByCategory}/$categoryId',
      key: 'foodItem',
      fromJson: (json) => FoodItem.fromJson(json),
      errorMessage: 'Failed to load category items',
    );
  }

  static Future<List<FavoriteItem>> fetchFavoriteItemsByUser(int userId) async {
    return _fetchList<FavoriteItem>(
      endpoint: '${ApiEndpoints.favorites}/$userId',
      key: 'favorites',
      fromJson: (json) => FavoriteItem.fromJson(json),
      errorMessage: 'Failed to load favorite items',
    );
  }

  static Future<FoodItemDetail> fetchFoodItemDetailsById(int itemId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl${ApiEndpoints.foodItems}/$itemId'),
        headers: headers,
      ).timeout(timeout);

      return _handleResponse<FoodItemDetail>(
        response: response,
        mapper: (data) => FoodItemDetail.fromJson(data),
        customErrorMessage: 'Failed to load item details',
      );
    } catch (e) {
      throw ApiException(message: 'Failed to load item details: ${e.toString()}');
    }
  }

  static Future<CartItem> addToCart({
    required int userId,
    required int foodItemId,
    required int quantity,
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/cart'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'user_id': userId,
          'food_item_id': foodItemId,
          'quantity': quantity,
        }),
      ).timeout(timeout);

      return _handleResponse<CartItem>(
        response: response,
        mapper: (data) => CartItem.fromJson(data['data']),
        customErrorMessage: 'Failed to add item to cart',
      );
    } catch (e) {
      throw ApiException(message: 'Failed to add item to cart: ${e.toString()}');
    }
  }

  static Future<FavoriteItem> addToFavorites({
    required int userId,
    required int foodItemId,
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl${ApiEndpoints.favorites}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'user_id': userId,
          'food_item_id': foodItemId,
        }),
      ).timeout(timeout);

      return _handleResponse<FavoriteItem>(
        response: response,
        mapper: (data) => FavoriteItem.fromJson(data['data']),
        customErrorMessage: 'Failed to add favorite item',
      );
    } catch (e) {
      throw ApiException(message: 'Failed to add favorite item: ${e.toString()}');
    }
  }



  static Future<List<T>> _fetchList<T>({
    required String endpoint,
    required String key,
    required T Function(dynamic json) fromJson,
    required String errorMessage,
  }) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl$endpoint'), headers: headers)
          .timeout(timeout);

      return _handleResponse<List<T>>(
        response: response,
        mapper: (data) {
          final List itemsJson = data[key];
          return itemsJson.map<T>((json) => fromJson(json)).toList();
        },
        customErrorMessage: errorMessage,
      );
    } catch (e) {
      throw ApiException(message: '$errorMessage: ${e.toString()}');
    }
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? responseData;

  ApiException({
    required this.message,
    this.statusCode,
    this.responseData,
  });

  @override
  String toString() {
    return 'ApiException: $message'
        '${statusCode != null ? ' (Status: $statusCode)' : ''}'
        '${responseData != null ? '\nResponse: $responseData' : ''}';
  }
}
