import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../page/restaurant_detail_page.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key,
      required this.imageUrl,
      required this.nameRestaurant,
      required this.city,
      required this.rating,
      required this.resto})
      : super(key: key);

  final String imageUrl;
  final String nameRestaurant;
  final String city;
  final double rating;

  final Restaurant resto;

  static const routeName = '/resto_list';

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
                          imageUrl,
                        ),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(nameRestaurant,
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
                      city,
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
                    Text(resto.rating.toString()), // <-- Text
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, RestoDetailPage.routeName,
                arguments: resto);
          }),
    );
  }
}
