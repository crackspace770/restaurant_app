import 'dart:convert';


class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) => Restaurant(
    id: restaurant["id"],
    name: restaurant["name"],
    description: restaurant["description"],
    pictureId: restaurant["pictureId"],
    city: restaurant["city"],
    rating: restaurant["rating"]?.toDouble(),
    menus: Menus.fromJson(restaurant["menus"]),
  );
}

class Menus {
  List<Menu> foods;
  List<Menu> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson( Map <String, dynamic> menu) => Menus(
    foods: List<Menu>.from(menu["foods"].map((x) => Menu.fromJson(x))),
    drinks: List<Menu>.from(menu["drinks"].map((x) => Menu.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
    "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
  };
}

class Menu {
  Menu({
    required this.name,
  });
  String name;

  factory Menu.fromJson(Map<String, dynamic> menu) => Menu(
    name: menu["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json);
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}