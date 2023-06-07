import 'dart:convert';

import '../model/restaurant.dart';

class RestaurantResponse {
  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  RestaurantResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantResponse.fromRawJson(String str) => RestaurantResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) => RestaurantResponse(
    error: json["error"],
    message: json["message"],
    count: json["count"],
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}