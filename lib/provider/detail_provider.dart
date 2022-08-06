import 'dart:async';

import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../utils/state_helper.dart';



class DetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailProvider({required this.apiService, required this.id}) {
    getRestaurantDetail(id);
  }

  late dynamic _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  dynamic get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> getRestaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantDetail = await apiService.getRestaurantDetail(id);
      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantResult = restaurantDetail;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }

}
