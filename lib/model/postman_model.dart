class Category {
  final int id;
  final String nameAr;
  final String nameEn;
  final bool isActive;

  Category({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.isActive,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      isActive: json['is_active'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'is_active': isActive ? 1 : 0,
    };
  }
}

// Function to parse list from JSON response
List<Category> parseCategoryList(Map<String, dynamic> json) {
  return (json['data'] as List)
      .map((item) => Category.fromJson(item))
      .toList();
}


// offer_model.dart

class Offer {
  final int id;
  final int foodItemId;
  final int categoryId;
  final String titleEn;
  final String titleAr;
  final String descriptionEn;
  final String descriptionAr;
  final int discountPercentage;
  final String startDate;
  final String endDate;
  final int limitAmount;
  final int personAmount;
  final String image;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  Offer({
    required this.id,
    required this.foodItemId,
    required this.categoryId,
    required this.titleEn,
    required this.titleAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.discountPercentage,
    required this.startDate,
    required this.endDate,
    required this.limitAmount,
    required this.personAmount,
    required this.image,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      foodItemId: json['food_item_id'],
      categoryId: json['category_id'],
      titleEn: json['title_en'],
      titleAr: json['title_ar'],
      descriptionEn: json['description_en'],
      descriptionAr: json['description_ar'],
      discountPercentage: json['discount_percentage'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      limitAmount: json['limit_amount'],
      personAmount: json['person_amount'],
      image: json['image'],
      isActive: json['is_active'] == 1,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'food_item_id': foodItemId,
      'category_id': categoryId,
      'title_en': titleEn,
      'title_ar': titleAr,
      'description_en': descriptionEn,
      'description_ar': descriptionAr,
      'discount_percentage': discountPercentage,
      'start_date': startDate,
      'end_date': endDate,
      'limit_amount': limitAmount,
      'person_amount': personAmount,
      'image': image,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}


List<Offer> parseOffersList(Map<String, dynamic> json) {
  return (json['offers'] as List)
      .map((offer) => Offer.fromJson(offer))
      .toList();
}


class TopRatedItem {
  final int id;
  final String nameAr;
  final String nameEn;
  final String descriptionAr;
  final String descriptionEn;
  final double price;
  final String imagePath;
  final bool isAvailable;
  final double rating;

  TopRatedItem ({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.price,
    required this.imagePath,
    required this.isAvailable,
    required this.rating,
  });

  factory TopRatedItem .fromJson(Map<String, dynamic> json) {
    return TopRatedItem  (
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      descriptionAr: json['description_ar'],
      descriptionEn: json['description_en'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      imagePath: json['image_path'],
      isAvailable: json['is_available'] == true,
      rating:double.tryParse(json['ratings_avg_rate'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
      'price': price.toStringAsFixed(2),
      'image_path': imagePath,
      'is_available': isAvailable,
      'ratings_avg_rate': rating,

    };
  }
}
List<TopRatedItem > parseFoodItemList(Map<String, dynamic> json) {
  return (json['data'] as List)
      .map((item) => TopRatedItem.fromJson(item))
      .toList();
}



class RecommendedItem {
  final int id;
  final String nameAr;
  final String nameEn;
  final String descriptionAr;
  final String descriptionEn;
  final double price;
  final String imagePath;
  final bool isAvailable;

  RecommendedItem({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.price,
    required this.imagePath,
    required this.isAvailable,
  });

  factory RecommendedItem.fromJson(Map<String, dynamic> json) {
    return RecommendedItem(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      descriptionAr: json['description_ar'],
      descriptionEn: json['description_en'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      imagePath: json['image_path'],
      isAvailable: json['is_available'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
      'price': price.toStringAsFixed(2),
      'image_path': imagePath,
      'is_available': isAvailable,
    };
  }
}
List<RecommendedItem> parseFoodItems(Map<String, dynamic> json) {
  return (json['data'] as List)
      .map((item) => RecommendedItem.fromJson(item))
      .toList();
}





class FavoriteItem {
  final int id;
  final int userId;
  final int foodItemId;

  FavoriteItem({
    required this.id,
    required this.userId,
    required this.foodItemId,
  });

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'],
      userId: json['user_id'],
      foodItemId: json['food_item_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'food_item_id': foodItemId,
    };
  }
}
class FoodItem {
  final int id;
  final String nameAr;
  final String nameEn;
  final String descriptionEn;
  final String descriptionAr;
  final double price;
  final String imagePath;
  final bool isAvailable;

  FoodItem({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.price,
    required this.imagePath,
    required this.isAvailable,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      descriptionEn: json['description_en'],
      descriptionAr: json['description_ar'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      imagePath: json['image_path'],
      isAvailable: json['is_available'],
    );
  }
}


class FoodItemDetail {
  final FoodItem foodItem;
  final double priceAfterDiscount;
  final double rating;
  final int numberOfReview;

  FoodItemDetail({
    required this.foodItem,
    required this.priceAfterDiscount,
    required this.rating,
    required this.numberOfReview,
  });

  factory FoodItemDetail.fromJson(Map<String, dynamic> json) {
    return FoodItemDetail(
      foodItem: FoodItem.fromJson(json['food_item']),
      priceAfterDiscount: double.tryParse(json['price_after_discount'].toString()) ?? 0.0,
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
      numberOfReview: json['number_of_review'] ?? 0,
    );
  }
}

class CartItem {
  final int id;
  final int foodItemId;
  final String name;
  final String description;
  final String imagePath;
  final String price;
  final bool isAvailable;
  final double ratingsAvgRate;
  final String quantity;

  CartItem({
    required this.id,
    required this.foodItemId,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.isAvailable,
    required this.ratingsAvgRate,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    final foodItem = json['food_item'] ?? {};

    return CartItem(
      id: json['id'],
      foodItemId: foodItem['id'],
      name: foodItem['name_en'],
      description: foodItem['description_en'],
      imagePath: foodItem['image_path'] ?? '',
      price: foodItem['price'] ?? '0.0',
      isAvailable: foodItem['is_available'] ?? false,
      ratingsAvgRate: (foodItem['ratings_avg_rate'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? '1',
    );
  }
}










