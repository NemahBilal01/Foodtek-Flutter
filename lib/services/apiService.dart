import 'dart:convert';
import 'package:firebasewithnotification/model/postman_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'http://172.233.67.77:2020/api';
  static const String genericError = 'Failed to load data';
  static const Duration timeout = Duration(seconds: 30);

  Future<User?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json", // ضروري جدًا
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final token = data['Token'];
        final userJson = data['User'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", token);

        return User.fromLoginJson(userJson, token);
      } else {
        print('Login failed: ${response.statusCode} => ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<User?> register(
      String name, String email, String password, String phone) async {
    final url = Uri.parse('$baseUrl/register');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      }),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return User.fromRegisterJson(data['User']);
    } else {
      print('Registration failed: ${response.body}');
      return null;
    }
  }

  Future<LogoutResponse?> logout() async {
    final url = Uri.parse("$baseUrl/logout");

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return LogoutResponse.fromJson(data);
      } else {
        print("Logout failed: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Logout error: $e");
      return null;
    }
  }

  Future<User?> loginWithGoogle() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
      );

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final accessToken = googleAuth.accessToken;
      print("Google Access Token: $accessToken");

      if (accessToken != null) {
        final response = await http.post(
          Uri.parse('$baseUrl/login/google/token'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'access_token': accessToken}),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          print(' Logged in! Server response: $data');

          final token = data['Token'];
          final userJson = data['User'];

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", token);

          return User.fromLoginJson(userJson, token);
        } else {
          print("Google login API failed: ${response.body}");
          return null;
        }
      }
    } catch (e) {
      print("Google sign-in error: $e");
    }

    return null;
  }

  Future<FacebookLoginResponse?> loginByFacebook(
      FacebookLoginRequest request) async {
    final url = Uri.parse('$baseUrl/login/facebook/token');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'accessToken': request.accessToken}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return FacebookLoginResponse.fromJson(data);
    } else {
      print('Login failed: ${response.body}');
      return null;
    }
  }

  Future<ForgotPasswordResponse?> forgotPassword(String email) async {
    final url = Uri.parse('http://172.233.67.77:2020/api/forgot-password');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Reset link sent: $data");
        return ForgotPasswordResponse.fromJson(data);
      } else {
        print("Failed to send reset link: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception in forgotPassword: $e");
      return null;
    }
  }

  Future<ResetPasswordResponse?> resetPassword({
    required String email,
    required String token,
    required String password,
    required String passwordConfirmation,
  }) async {
    final url = Uri.parse('http://172.233.67.77:2020/api/login');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "token": token,
          "password": password,
          "password_confirmation": passwordConfirmation,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ResetPasswordResponse.fromJson(data);
      } else {
        print(
            "Password reset failed: ${response.statusCode} => ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception in resetPassword: $e");
      return null;
    }
  }

  Future<List<NotificationModel>> fetchNotifications(int userId) async {
    final url = Uri.parse('http://172.233.67.77:2020/api/notification/$userId');

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List<dynamic> jsonData = decoded['data'];

        return jsonData
            .map((json) => NotificationModel.fromJson(json))
            .toList();
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Body: ${response.body}');
        throw Exception('Failed to fetch notifications');
      }
    } catch (e) {
      print('Error fetching notifications: $e');
      rethrow;
    }
  }

  Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Future<T> _handleResponse<T>({
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

  Future<List<Category>> fetchCategories() async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl${ApiEndpoints.categories}'),
            headers: headers,
          )
          .timeout(timeout);

      return _handleResponse<List<Category>>(
        response: response,
        mapper: (data) {
          final List categoriesJson = data['data'];

          return categoriesJson.map((json) => Category.fromJson(json)).toList();
        },
        customErrorMessage: 'Failed to load categories',
      );
    } catch (e) {
      throw ApiException(message: 'Failed to load categories: ${e.toString()}');
    }
  }

  Future<List<Offer>> fetchOffers() async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl${ApiEndpoints.offers}'),
            headers: headers,
          )
          .timeout(timeout);

      return _handleResponse<List<Offer>>(
        response: response,
        mapper: (data) {
          final List offersJson = data['offers'];
          return offersJson.map((json) => Offer.fromJson(json)).toList();
        },
        customErrorMessage: 'Failed to load offers',
      );
    } catch (e) {
      throw ApiException(message: 'Failed to load offers: ${e.toString()}');
    }
  }

  Future<List<TopRatedItem>> fetchTopRatedItems() async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl${ApiEndpoints.rating}'),
            headers: headers,
          )
          .timeout(timeout);

      return _handleResponse<List<TopRatedItem>>(
        response: response,
        mapper: (data) {
          final List itemsJson = data['topFood'];
          return itemsJson.map((json) => TopRatedItem.fromJson(json)).toList();
        },
        customErrorMessage: 'Failed to load top rated items',
      );
    } catch (e) {
      throw ApiException(
          message: 'Failed to load top rated items: ${e.toString()}');
    }
  }

  Future<List<RecommendedItem>> fetchTopRecommendedItems() async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl${ApiEndpoints.topRecommended}'),
            headers: headers,
          )
          .timeout(timeout);

      return _handleResponse<List<RecommendedItem>>(
        response: response,
        mapper: (data) {
          final List itemsJson = data['TopRecommended'];
          return itemsJson
              .map((json) => RecommendedItem.fromJson(json))
              .toList();
        },
        customErrorMessage: 'Failed to load recommended items',
      );
    } catch (e) {
      throw ApiException(
          message: 'Failed to load recommended items: ${e.toString()}');
    }
  }

  Future<List<FoodItem>> fetchItemsByCategory(int categoryId) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl${ApiEndpoints.foodByCategory}/$categoryId'),
            headers: headers,
          )
          .timeout(timeout);
      return _handleResponse<List<FoodItem>>(
        response: response,
        mapper: (data) {
          final List items = data['foodItem'];
          return items.map((item) => FoodItem.fromJson(item)).toList();
        },
        customErrorMessage: 'Failed to load category items',
      );
    } catch (e) {
      throw ApiException(
          message: 'Failed to load category items: ${e.toString()}');
    }
  }

  Future<List<FavoriteItem>> fetchFavoriteItemsByUser(int userId) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl${ApiEndpoints.favorites}/$userId'),
            headers: headers,
          )
          .timeout(timeout);

      return _handleResponse<List<FavoriteItem>>(
        response: response,
        mapper: (data) {
          final List favs = data['favorites'];
          return favs.map((item) => FavoriteItem.fromJson(item)).toList();
        },
        customErrorMessage: 'Failed to load favorite items',
      );
    } catch (e) {
      throw ApiException(
          message: 'Failed to load favorite items: ${e.toString()}');
    }
  }

  Future<FoodItemDetail> fetchFoodItemDetailsById(int itemId) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl${ApiEndpoints.foodItems}/$itemId'),
            headers: headers,
          )
          .timeout(timeout);

      return _handleResponse<FoodItemDetail>(
        response: response,
        mapper: (data) => FoodItemDetail.fromJson(data),
        customErrorMessage: 'Failed to load item details',
      );
    } catch (e) {
      throw ApiException(
          message: 'Failed to load item details: ${e.toString()}');
    }
  }

  Future<PaymentResponse?> payNow({
    required String name,
    required String cardNumber,
    required String expiry,
    required String cvc,
  }) async {
    final url = Uri.parse('$baseUrl/payment');

    final body = {
      "name": name,
      "card_number": cardNumber,
      "expiry": expiry,
      "cvc": cvc,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return PaymentResponse.fromJson(jsonResponse);
      } else {
        print("HTTP Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  Future<Address?> addAddress({
    required String  userId,
    required String addressLine,
    required String description,
    required String province,
    required String city,
    required String zipCode,
  }) async {
    final url = Uri.parse('$baseUrl/address');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "user_id": userId,
          "address_line": addressLine,
          "description": description,
          "province": province,
          "city": city,
          "zip_code": zipCode,
        }),
      );

      if (response.statusCode == 201) {
        final decoded = jsonDecode(response.body);
        if (decoded.containsKey("0")) {
          return Address.fromJson(decoded["0"]);
        }
        return null;
      } else {
        print("Error Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  Future<List<Address>> getAddresses(String userId) async {
    final url = Uri.parse('$baseUrl/api/address?user_id=$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is List) {
          return decoded.map((e) => Address.fromJson(e)).toList();
        } else if (decoded is Map) {
          return decoded.entries
              .where((e) => e.key != "message")
              .map((e) => Address.fromJson(e.value))
              .toList();
        }
        return [];
      } else {
        throw Exception('Failed to load addresses');
      }
    } catch (e) {
      print("Exception: $e");
      throw Exception('Failed to load addresses');
    }}

  Future<DeliveryTracking?> getDeliveryTracking({
    required int orderId,
    required double latitude,
    required double longitude,
  }) async
  {
    final url = Uri.parse('$baseUrl/delivery-tracking');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'order_id': orderId,
        'latitude': latitude,
        'longitude': longitude,
      }),
    );

    if (response.statusCode == 201) {
      final body = jsonDecode(response.body);
      return DeliveryTracking.fromJson(body['data']);
    } else {
      print('Failed to create tracking: ${response.body}');
      return null;
    }
  }
}

// static Future<List<CartItem>> fetchCartItems(int userId) async {
// final url = Uri.parse('$baseUrl/cart-items/$userId');
// final response = await http.get(url);
//
// if (response.statusCode == 200) {
// final data = jsonDecode(response.body);
// final List items = data['data'];
// return items.map((item) => CartItem.fromJson(item)).toList();
// } else {
// throw Exception('فشل في جلب بيانات السلة');
// }
// }

class ApiEndpoints {
  static const String categories = '/categories';
  static const String offers = '/special-offers';
  static const String rating = '/rating';
  static const String topRecommended = '/top-recommended';
  static const String foodByCategory = '/food-under-category';
  static const String favorites = '/favorites';
  static const String foodItems = '/food-items';
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
