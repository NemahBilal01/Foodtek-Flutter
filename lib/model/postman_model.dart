class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? role;
  final String? profilePicture;
  final String? token;
  final String? birthday;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.role,
    this.profilePicture,
    this.token,
    this.birthday,
  });

  factory User.fromLoginJson(Map<String, dynamic> json, String token) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      profilePicture: json['profile_picture'],
      token: token,
      birthday: json['birthday'],
    );
  }

  factory User.fromRegisterJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      birthday: json['birthday'],
    );
  }

  factory User.fromFacebookJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: '',
      birthday: null,
      role: null,
      profilePicture: null,
      token: null,
    );
  }

  factory User.fromGoogleJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: '',
      birthday: null,
      role: null,
      profilePicture: json['picture'],
      token: null,
    );
  }
}

class LogoutResponse {
  final String message;

  LogoutResponse({required this.message});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      message: json['message'] ?? '',
    );
  }
}

class FacebookLoginResponse {
  final String message;
  final User user;
  final String token;

  FacebookLoginResponse({
    required this.message,
    required this.user,
    required this.token,
  });

  factory FacebookLoginResponse.fromJson(Map<String, dynamic> json) {
    return FacebookLoginResponse(
      message: json['message'],
      user: User.fromFacebookJson(json['user']),
      token: json['token'],
    );
  }
}

class FacebookLoginRequest {
  final String accessToken;

  FacebookLoginRequest({required this.accessToken});

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
      };
}

class GoogleLoginRequest {
  final String idToken;

  GoogleLoginRequest({required this.idToken});

  Map<String, dynamic> toJson() => {
        "id_token": idToken,
      };
}

class GoogleLoginResponse {
  final String message;
  final User user;
  final String token;

  GoogleLoginResponse({
    required this.message,
    required this.user,
    required this.token,
  });

  factory GoogleLoginResponse.fromJson(Map<String, dynamic> json) {
    return GoogleLoginResponse(
      message: json['message'],
      user: User.fromGoogleJson(json['user']),
      token: json['token'],
    );
  }
}

class ForgotPasswordResponse {
  final String message;

  ForgotPasswordResponse({required this.message});

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      message: json['message'] ?? '',
    );
  }
}

class ResetPasswordResponse {
  final String message;

  ResetPasswordResponse({required this.message});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      message: json['message'] ?? '',
    );
  }
}

class NotificationModel {
  final int id;
  final int userId;
  final String title;
  final String message;
  final bool isRead;
  final DateTime readAt;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.isRead,
    required this.readAt,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      message: json['message'],
      isRead: json['is_read'],
      readAt: json['read_at'] != null
          ? DateTime.parse(json['read_at'])
          : DateTime.now(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }
}

class Category {
  final int id;
  // final int restaurantId;
  final String nameAr;
  final String nameEn;
  // final String image;
  final int isActive;

  Category({
    required this.id,
    // required this.restaurantId,
    required this.nameAr,
    required this.nameEn,
    // required this.image,
    required this.isActive,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      // restaurantId: json['restaurant_id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      // image: json['image'],
      isActive: json['is_active'],
    );
  }
}

class Offer {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;
  final double? discount; // إذا موجود خصم

  Offer({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    this.discount,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      discount: json['discount'] != null
          ? double.tryParse(json['discount'].toString())
          : null,
    );
  }
}

class TopRatedItem {
  final int id;
  final int restaurantId;
  final int categoryId;
  final int itemOptionId;
  final String nameAr;
  final String nameEn;
  final String descriptionAr;
  final String descriptionEn;
  final double price;
  final String image;
  final bool isAvailable;
  final double rating;

  TopRatedItem({
    required this.id,
    required this.restaurantId,
    required this.categoryId,
    required this.itemOptionId,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.price,
    required this.image,
    required this.isAvailable,
    required this.rating,
  });

  factory TopRatedItem.fromJson(Map<String, dynamic> json) {
    return TopRatedItem(
      id: json['id'],
      restaurantId: json['restaurant_id'],
      categoryId: json['category_id'],
      itemOptionId: json['item_option_id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      descriptionAr: json['description_ar'],
      descriptionEn: json['description_en'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      image: json['image_path'],
      isAvailable: json['is_available'],
      rating: double.tryParse(json['ratings_avg_rate'].toString()) ?? 0.0,
    );
  }
}

class RecommendedItem {
  final int id;
  final int restaurantId;
  final int categoryId;
  final int itemOptionId;
  final String nameAr;
  final String nameEn;
  final String descriptionAr;
  final String descriptionEn;
  final double price;
  final String image;
  final bool isAvailable;

  RecommendedItem({
    required this.id,
    required this.restaurantId,
    required this.categoryId,
    required this.itemOptionId,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.price,
    required this.image,
    required this.isAvailable,
  });

  factory RecommendedItem.fromJson(Map<String, dynamic> json) {
    return RecommendedItem(
      id: json['id'],
      restaurantId: json['restaurant_id'],
      categoryId: json['category_id'],
      itemOptionId: json['item_option_id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      descriptionAr: json['description_ar'],
      descriptionEn: json['description_en'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      image: json['image_path'],
      isAvailable: json['is_available'],
    );
  }
}

class FoodItem {
  final int id;
  final int restaurantId;
  final int categoryId;
  final int itemOptionId;
  final String nameAr;
  final String nameEn;
  final String descriptionAr;
  final String descriptionEn;
  final String price;
  final String imagePath;
  final bool isAvailable;
  final String createdAt;
  final String updatedAt;

  FoodItem({
    required this.id,
    required this.restaurantId,
    required this.categoryId,
    required this.itemOptionId,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.price,
    required this.imagePath,
    required this.isAvailable,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      restaurantId: json['restaurant_id'],
      categoryId: json['category_id'],
      itemOptionId: json['item_option_id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      descriptionAr: json['description_ar'],
      descriptionEn: json['description_en'],
      price: json['price'],
      imagePath: json['image_path'],
      isAvailable: json['is_available'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class FavoriteItem {
  final int id;
  final int userId;
  final int foodItemId;
  final String createdAt;
  final String updatedAt;

  FavoriteItem({
    required this.id,
    required this.userId,
    required this.foodItemId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'],
      userId: json['user_id'],
      foodItemId: json['food_item_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class FoodItemDetail {
  final String imagePath;
  final String nameEn;
  final String descriptionEn;
  final String price;
  final String rating;
  final int numberOfReview;
  final String priceAfterDiscount;

  FoodItemDetail({
    required this.imagePath,
    required this.nameEn,
    required this.descriptionEn,
    required this.price,
    required this.rating,
    required this.numberOfReview,
    required this.priceAfterDiscount,
  });

  factory FoodItemDetail.fromJson(Map<String, dynamic> json) {
    return FoodItemDetail(
      imagePath: json['image_path'],
      nameEn: json['name_en'],
      descriptionEn: json['Description_en'],
      price: json['price'],
      rating: json['rating'],
      numberOfReview: json['numberOfReview'],
      priceAfterDiscount: json['price_after_discount'],
    );
  }
}

class PaymentResponse {
  final bool success;
  final String message;

  PaymentResponse({required this.success, required this.message});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      success: json['success'],
      message: json['message'],
    );
  }
}

class Address {
  final int id;
  final String userId;
  final String addressLine;
  final String description;
  final String province;
  final String city;
  final String zipCode;
  final String? createdAt;
  final String? updatedAt;

  Address({
    required this.id,
    required this.userId,
    required this.addressLine,
    required this.description,
    required this.province,
    required this.city,
    required this.zipCode,
    this.createdAt,
    this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json["id"] ?? 0,
      userId: json["user_id"]?.toString() ?? '',
      addressLine: json["address_line"] ?? '',
      description: json["description"] ?? '',
      province: json["province"] ?? '',
      city: json["city"] ?? '',
      zipCode: json["zip_code"] ?? '',
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "address_line": addressLine,
      "description": description,
      "province": province,
      "city": city,
      "zip_code": zipCode,
    };
  }

  @override
  String toString() {
    return '$addressLine, $city, $province, $zipCode';
  }
}

class DeliveryTracking {
  final int id;
  final int orderId;
  final double latitude;
  final double longitude;
  final DateTime lastUpdatedAt;

  DeliveryTracking({
    required this.id,
    required this.orderId,
    required this.latitude,
    required this.longitude,
    required this.lastUpdatedAt,
  });

  factory DeliveryTracking.fromJson(Map<String, dynamic> json) {
    return DeliveryTracking(
      id: json['id'],
      orderId: json['order_id'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      lastUpdatedAt: DateTime.parse(json['last_updated_at']),
    );
  }
}

class CartItem {
  final int id;
  final FoodItem foodItem;
  final int quantity;

  CartItem({
    required this.id,
    required this.foodItem,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      foodItem: FoodItem.fromJson(json['food_item']),
      quantity: json['quantity'],
    );
  }
}

class OrderModel {
  final int id;
  final int userId;
  final String status;
  final String totalPrice;
  final String paymentStatus;
  final int restaurantId;

  OrderModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalPrice,
    required this.paymentStatus,
    required this.restaurantId,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      status: json['status'],
      totalPrice: json['total_price'],
      paymentStatus: json['payment_status'],
      restaurantId: json['restaurant_id'],
    );
  }
}



