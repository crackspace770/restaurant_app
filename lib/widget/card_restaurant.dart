import 'package:flutter/material.dart';

import '../api/endpoints.dart';
import '../common/styles.dart';
import '../model/restaurant.dart';
import '../ui/detail_page.dart';

class CardRestaurant extends StatelessWidget{

  final Restaurant restaurant;
  const CardRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context){
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurant.pictureId!,
          child: Image.network(
            "${Endpoints.imageUrlSmall}${restaurant.pictureId}",
            width: 100,
            errorBuilder: (ctx, error, _) => const Center(child: Icon(
              Icons.error_outline_sharp,
              color: Colors.red,)),
          ),
        ),
        title: Text(
          restaurant.name,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.place,
                  color: Colors.black38,
                ),
                Text(restaurant.city),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.blueAccent,
                ),
                Text(restaurant.rating.toString() ),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routeName,
              arguments: restaurant.id);
        },
      ),
    );
  }

}