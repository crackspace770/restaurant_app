import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/widget/platform_widget.dart';
import 'common/styles.dart';
import 'detail_page.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/list_page';
  const RestaurantListPage({Key? key}) : super(key: key);

  Widget _buildList(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/restaurant.json'),
        builder: (context, snapshot) {
          final List restaurants = parseRestaurant(snapshot.data);
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return _buildRestaurantItem(context, restaurants[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurant.pictureId,
          child: Image.network(
            restaurant.pictureId,
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
                Text(restaurant.rating.toString()),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routeName,
              arguments: restaurant);
        },
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RestoApp'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('RestoApp'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  Widget _buildWeb(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('RestoApp'),
      ),
      body: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
      webBuilder: _buildWeb
    );
  }
}
