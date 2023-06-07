
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

import '../api/api_service.dart';
import '../response/restaurant_detail_response.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String? restaurantId;

  RestaurantDetailProvider(
      {required this.apiService, required this.restaurantId}) {
    fetchDetailRestaurant(restaurantId!);
  }

  late RestaurantDetailResponse _detailRestaurant;
  String _message = '';
  late ResultState _state;

  String get message => _message;
  RestaurantDetailResponse get result => _detailRestaurant;
  ResultState get state => _state;

  Future<dynamic> fetchDetailRestaurant(String restaurantId) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurants = await apiService.getDetailRestaurant(restaurantId);
      if (restaurants == null) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurant = restaurants;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Connection Error';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error -> $e';
    }
  }
}