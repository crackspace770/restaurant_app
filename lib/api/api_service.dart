import 'dart:convert';
import 'package:http/http.dart' as http;

import '../response/restaurant_detail_response.dart';
import '../response/restaurant_response.dart';
import '../response/restaurant_search_response.dart';
import 'endpoints.dart';
import 'package:http/http.dart';

class ApiService {
  final Client client;
  ApiService(this.client);
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantResponse> getRestaurantList() async {
    final response = await client.get(Uri.parse("${_baseUrl}${Endpoints.restaurantList}"));
    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load menu');
    }
  }

  Future<RestaurantSearchResponse> searchRestaurant(String query) async {
    final response = await client.get(Uri.parse("${_baseUrl}${Endpoints.restaurantSearch}?q=${query}"));
    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load menu');
    }
  }

  Future<RestaurantDetailResponse> getDetailRestaurant(String id) async {
    try {
      final response = await client.get(Uri.parse("${_baseUrl}${Endpoints.restaurantDetail}${id}"));
      if (response.statusCode == 200) {
        return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load top headlines');
      }
    } on Error catch (e) {
      print('Error: $e');
      throw Exception('Something went wrong ');
    }
  }

}
