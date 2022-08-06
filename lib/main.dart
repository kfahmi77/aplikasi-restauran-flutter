import 'package:flutter/material.dart';

import 'data/model/get/list.dart';
import '../page/splashscreen.dart';
import 'misc/style.dart';
import 'page/restaurant_detail_page.dart';
import 'page/restaurant_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      initialRoute: SplashScreen.routeName,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(elevation: 10),
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: Colors.black,
              secondary: secondaryColor,
            ),
      ),
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        RestaurantHomePage.routeName: (context) => const RestaurantHomePage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
