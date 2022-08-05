import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../widgets/drinks_restaurant_items.dart';
import '../widgets/foods_restaurant_items.dart';

class RestoDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail_page';

  final Restaurant restaurant;

  const RestoDetailPage({Key? key, required this.restaurant}) : super(key: key);

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
                child: Image.network(restaurant.pictureId),
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
