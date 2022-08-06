import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../data/model/get/detail.dart';
import '../provider/detail_provider.dart';
import 'drinks_restaurant_items.dart';
import 'foods_restaurant_items.dart';

class DetailRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  final DetailProvider provider;

   const DetailRestaurant({Key? key, required this.restaurant, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: restaurant.id,
                child: Image.network(
                    "${ApiService.baseUrlImage}medium/${restaurant.pictureId}"),
              ),
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(restaurant.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold)), // <-- Text
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(
                        // <-- Icon
                        Icons.place_outlined,
                        size: 16.0,
                      ),
                      Text(
                        restaurant.city,
                      ), // <-- Text
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(
                        // <-- Icon
                        Icons.star,
                        size: 16.0,
                      ),
                      Text(restaurant.rating.toString()), // <-- Text
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 16,
                    bottom: 10,
                  ),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Description',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    restaurant.description,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Foods',
                        style: Theme.of(context).textTheme.headline5,
                      )
                    ],
                  ),
                ),
                SizedBox(child: FoodsRestaurantItem(restaurant: restaurant)),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Drinks',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: DrinksRestaurantItem(restaurant: restaurant),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
