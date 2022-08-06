import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../data/api/api_service.dart';
import '../data/model/get/list.dart';
import '../provider/detail_provider.dart';
import '../utils/state_helper.dart';
import '../widget/detail_restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail_page';

  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailProvider provider;
    return ChangeNotifierProvider<DetailProvider>(
      create: (_) =>
          DetailProvider(apiService: ApiService(), id: restaurant.id),
      child: SafeArea(
        child: Scaffold(
          body: Consumer<DetailProvider>(
            builder: (context, state, _) {
              provider = state;
              if (state.state == ResultState.loading) {
                return const Center(
                  child: SpinKitHourGlass(
                    color: Colors.green,
                    duration: Duration(microseconds: 1200),
                    size: 50,
                  ),
                );
              } else if (state.state == ResultState.hasData) {
                var restaurant = state.result.restaurant;
                return DetailRestaurant(
                  restaurant: restaurant,
                  provider: provider,
                );
              } else if (state.state == ResultState.noData) {
                return Center(child: Text(state.message));
              } else if (state.state == ResultState.error) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/image/no_internet.gif", width: 100),
                    const SizedBox(height: 10),
                    const Text("Sepertinya koneksimu terputus :("),
                    ElevatedButton(
                      child: const Text("refresh"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ));
              } else {
                return const Center(child: Text(''));
              }
            },
          ),
        ),
      ),
    );
  }
}
