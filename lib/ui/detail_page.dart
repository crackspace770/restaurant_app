import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_service.dart';
import '../api/endpoints.dart';
import '../provider/restaurant_detail_provider.dart';
import '../provider/restaurant_provider.dart';
import 'package:http/http.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/detail_page';
  final String restaurantId;
  const RestaurantDetailPage({required this.restaurantId, super.key,});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) =>
          RestaurantDetailProvider(apiService: ApiService(Client()), restaurantId: restaurantId),
      child: Scaffold(
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              var restaurant = state.result.restaurant!;


              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget> [
                      Stack(
                        children: [
                          Image.network("${Endpoints.imageUrlLarge}" + "${restaurant.pictureId}"),
                          SafeArea(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  //  backgroundColor: Colors.grey,
                                  child: IconButton(
                                    icon: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.white
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                const FavoriteButton(),
                              ],
                            ),
                          ))
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          restaurant.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.place,
                                color: Colors.black38,),
                              Text(restaurant.city ??""),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
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
                      const Divider(
                        color: Colors.blueGrey,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          restaurant.description ,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),

                      const Divider(
                        color: Colors.blueGrey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Menus:'),

                          const SizedBox(
                            height: 20,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Food:'),


                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: restaurant.menus.foods.length,
                                    itemBuilder: (context, index){
                                      return Text(
                                          restaurant.menus.foods[index].name
                                      );
                                    },
                                  ),

                              const SizedBox(
                                height: 15,
                              ),

                              const Text('Drinks:'),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: restaurant.menus.drinks.length,
                                itemBuilder: (context, index){
                                  return Text(
                                      restaurant.menus.drinks[index].name
                                  );
                                },
                              ),
                            ],
                          ),

                        ],

                      ),

                    ],
                  ),

                ),
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Text(state.message),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text(''),
              );
            }
          },
        ),
      ),
    );
  }}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.blueAccent,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}

