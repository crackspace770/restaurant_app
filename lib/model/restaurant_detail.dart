// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

Detail restaurantDetailFromJson(String str) =>
    Detail.fromJson(json.decode(str));

class RestaurantDetail {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  num rating;
  List<Category> categories;
  Menus menus;
  List<CustomerReview> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.rating,
    required this.categories,
    required this.menus,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        rating: json["rating"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "city": city,
    "address": address,
    "pictureId": pictureId,
    "rating": rating,
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "menus": menus.toJson(),
    "customerReviews":
    List<dynamic>.from(customerReviews.map((x) => x.toJson())),
  };
}

class Detail {
  bool error;
  String message;
  RestaurantDetail restaurant;

  Detail({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    error: json["error"],
    message: json["message"],
    restaurant: json["restaurant"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "restaurant": restaurant.toJson(),
  };
}

class Category {
  String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class Menus {
  List<Category> foods;
  List<Category> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
    foods:
    List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
    drinks: List<Category>.from(
        json["drinks"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "foods": List<dynamic>.from(foods.map((e) => e.toJson())),
    "drinks": List<dynamic>.from(drinks.map((e) => e.toJson())),
  };
}

class CustomerReview {
  String name;
  String review;
  String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
    name: json["name"],
    review: json["review"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "review": review,
    "date": date,
  };
}
