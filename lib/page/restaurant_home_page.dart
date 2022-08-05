import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../widgets/custom_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/restaurant_home_page';

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
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/json/data-dummy.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              final List<Restaurant> restaurant =
                  parseRestaurant(snapshot.data ?? 'data kosong');
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: restaurant.length,
                  itemBuilder: (context, index) {
                    return _buildRestoItem(context, restaurant[index]);
                  });
            } else {
              return const Center(child: Center(child: Text('Koneksi gagal')));
            }
          }
        },
      ),
    ));
  }
}

Widget _buildRestoItem(BuildContext context, Restaurant resto) {
  return CustomCard(
      imageUrl: resto.pictureId,
      nameRestaurant: resto.name,
      city: resto.city,
      rating: resto.rating,
      resto: resto);
}
