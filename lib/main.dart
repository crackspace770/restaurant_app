import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant_detail.dart';
import 'package:restaurant_app/response/restaurant_detail_response.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:http/http.dart';
import 'model/restaurant.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestoApp',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        RestaurantSearchPage.routeName:  (context) => RestaurantSearchPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
          restaurantId:
          ModalRoute.of(context)?.settings.arguments as String,
        ),

      },
    );
  }
}

