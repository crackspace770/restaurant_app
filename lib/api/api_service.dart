import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/#/';
  static const String _category = 'business';
  static const String _country = 'id';

  Future<Restaurant> topHeadlines() async {
    final response = await http.get(Uri.parse("${_baseUrl}top-headlines?country=$_country&category=$_category"));
    if (response.statusCode == 200) {
      return Restaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
