import 'package:flutter/material.dart';
import '../page/restaurant_detail_page.dart';
import '../data/model/get/list.dart';
import '../data/api/api_service.dart';

class CardListRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardListRestaurant({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          "${ApiService.baseUrlImage}small/${restaurant.pictureId}",
                        ),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
                  mainAxisSize: MainAxisSize.min,
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
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                arguments: restaurant);
          }),
    );
  }
}
