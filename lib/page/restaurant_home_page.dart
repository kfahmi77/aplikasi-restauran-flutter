import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../data/api/api_service.dart';
import '../provider/restaurant_provider.dart';
import '../utils/state_helper.dart';
import '../widget/card_list_restaurant.dart';

class RestaurantHomePage extends StatefulWidget {
  static const routeName = '/restaurant_home_page';

  const RestaurantHomePage({Key? key}) : super(key: key);

  @override
  State<RestaurantHomePage> createState() => _RestaurantHomePageState();
}

class _RestaurantHomePageState extends State<RestaurantHomePage> {
  late RestaurantProvider provider;
  final TextEditingController _filter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                var top = constraints.biggest.height;
                return FlexibleSpaceBar(
                    title: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: 1,
                        child: Text(
                          top > 71 && top < 91 ? "Restaurant App" : "",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                    centerTitle: true,
                    background: Image.asset(
                      "assets/image/dashboard.gif",
                      fit: BoxFit.cover,
                    ));
              }),
              bottom: AppBar(
                title: Container(
                  width: double.infinity,
                  height: 40,
                  color: Colors.white,
                  child: Center(
                    child: TextField(
                      showCursor: true,
                      readOnly: false,
                      focusNode: FocusNode(),
                      controller: _filter,
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                          hintText: 'Cari nama restoran',
                          icon: Icon(Icons.search)),
                      onChanged: (query) => {
                        if (query != '')
                          {
                            provider.getRestaurantSearch(query),
                          }
                      },
                    ),
                  ),
                ),
              ),
              floating: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
            )
          ];
        },
        body: _buildItemList(context),
      ),
    );
  }

  Widget _buildItemList(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(apiService: ApiService(), id: ''),
      child: Consumer<RestaurantProvider>(
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
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              shrinkWrap: true,
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = state.result.restaurants[index];
                return CardListRestaurant(restaurant: restaurant);
              },
            );
          } else if (state.state == ResultState.noData) {
            return Center(child: Text(state.message));
          } else if (state.state == ResultState.error) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/image/no_internet.gif", width: 100),
                const SizedBox(
                  height: 10,
                ),
                const Text("Sepertinya koneksimu terputus :("),
                ElevatedButton(
                  child: const Text("refresh"),
                  onPressed: () {
                    provider.getAllRestaurants();
                  },
                ),
              ],
            ));
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    );
  }
}
