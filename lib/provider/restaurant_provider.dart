import 'dart:async';

import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../utils/state_helper.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantProvider({required this.apiService, required this.id}) {
    getAllRestaurants();
  }

  late dynamic _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  dynamic get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> getAllRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantList = await apiService.getRestaurantList();
      notifyListeners();
      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantResult = restaurantList;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }

  Future<dynamic> getRestaurantSearch(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantSearch = await apiService.getRestaurantSearch(query);
      if (restaurantSearch.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data tidak ada';
      } else if (restaurantSearch.restaurants.isNotEmpty) {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurantSearch;
      } else {
        _state = ResultState.error;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;

      return _message = 'Error: $e';
    }
  }
}
