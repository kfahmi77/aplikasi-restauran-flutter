import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/get/list.dart';
import '../model/get/search.dart';
import '../model/get/detail.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String baseUrlImage = '${_baseUrl}images/';

  Future<RestaurantList> getRestaurantList() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<RestaurantSearch> getRestaurantSearch(String query) async {
    final response = await http.get(Uri.parse("${_baseUrl}search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
