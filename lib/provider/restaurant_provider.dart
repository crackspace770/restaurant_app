import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/response/restaurant_response.dart';
import '../api/api_service.dart';


enum ResultState { loading, noData, hasData, error, initialLoad }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllArticle();
  }

  late RestaurantResponse _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantResponse get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllArticle() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant= await apiService.getRestaurantList();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Connection Error';
    }
  }
}