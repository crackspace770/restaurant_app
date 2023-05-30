import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/detail_page';
  final Restaurant restaurant;
  const RestaurantDetailPage({Key? key, required this.restaurant,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Hero(
          tag: restaurant.pictureId,
          child: Column(
            children: [
              Row(
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
              Image.network(restaurant.pictureId),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        restaurant.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.place,
                                    color: Colors.black38,),
                              Text(restaurant.city),
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
                              Text(restaurant.rating.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    const Text('Description'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      restaurant.description,
                      overflow: TextOverflow.clip,
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Menus:'),
                        const SizedBox(
                          height: 10,
                        ),

                        Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Food:'),
                                SizedBox(
                                  child:Card(
                                    color: Colors.white38,
                                    child:ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: restaurant.menus.foods.length,
                                      itemBuilder: (context, index){
                                        return Text(
                                            restaurant.menus.foods[index].name
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 5,
                                ),

                                const Text('Drinks:'),

                                Container(
                                  child:Card(
                                    color: Colors.white38,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: restaurant.menus.drinks.length,
                                      itemBuilder: (context, index){
                                        return Text(
                                            restaurant.menus.drinks[index].name
                                        );
                                      },

                                    ),
                                  ),

                                ),

                              ],
                            ),



                        ),



                      ],

                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
