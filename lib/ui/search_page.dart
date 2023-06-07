import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/restaurant_provider.dart';
import '../provider/restaurant_search_provider.dart';
import '../widget/card_restaurant.dart';

class RestaurantSearchPage extends StatelessWidget{

  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  RestaurantSearchPage({super.key});
  static const routeName = '/search_page';
  static const String searchTitle = 'Search';


  @override
  Widget build(BuildContext context) {
    final searchRestaurantsState = Provider.of<RestaurantSearchProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Search', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: _textEditingController,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      prefixIcon:
                      const Icon(Icons.search),
                      fillColor: Color(0xFFF6F7FB),
                      hintText: "Where do you want to eat?",
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                    onChanged: (keyword) {
                      searchRestaurantsState.searchRestaurant(keyword);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                child: Consumer<RestaurantSearchProvider>(builder: (context, state, _) {
                  if (state.state == ResultState.loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.state == ResultState.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.result.restaurants!.length,
                        itemBuilder: (context, index) {
                          var restaurant = state.result.restaurants![index];
                          return CardRestaurant( restaurant: restaurant,);
                        });
                  } else if (state.state == ResultState.noData) {
                    return const Column(
                      children: [
                        Text("Data Not Found"),
                      ],
                    );
                  } else if (state.state == ResultState.error) {
                    return Column(
                      children: [Text(state.message)],
                    );
                  } else if (state.state == ResultState.initialLoad) {
                    return const Column(
                      children: [
                        Text(
                          "You can look up any restaurant here",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                         //   fontFamily: GoogleFonts.montserrat().fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            // color: Colors.black,
                          ),
                        )
                      ],
                    );
                  } else {
                    return Center(child: Text(''));
                  }
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}