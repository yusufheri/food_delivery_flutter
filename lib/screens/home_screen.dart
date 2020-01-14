import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/screens/restaurant_screen.dart';
import 'package:food_delivery/widgets/rating_starts.dart';
import 'package:food_delivery/widgets/recent_orders.dart';

import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  _buildNearlyRestaurant() {
    List<Widget> restaurantList = [];
    restaurants.forEach((Restaurant restaurant) {
      restaurantList.add(
        GestureDetector(
          onTap: () => Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (_) => RestaurantScreen(restaurant: restaurant),
            ),
          ),
          child: 
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              width: 1.0,
              color: Colors.grey[200]
            )
          ),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),                
                child: Hero(
                  tag: restaurant.name,
                  child: Image(
                        image: AssetImage(restaurant.imageUrl),
                        fit: BoxFit.cover,
                        height: 150.0,
                        width: 150.0,
                      )
                )
              ),
              Container(
                margin: EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      restaurant.name,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0,),
                    RatingStarts(rating: restaurant.rating, taille: 26.0,),
                    Text(
                      restaurant.address,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600
                      ),
                       overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0,),
                    Text(
                        '0.2 miles away',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                  ],
                ),
              )
            ],
          ),
        )
      )
      );
    });

    return Column(children: restaurantList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: AppBar(
           centerTitle: true,
           leading: IconButton(
             icon: Icon(Icons.account_circle),
             iconSize: 30.0,
             onPressed: () {},
           ),
           title: Text("Food Delivery"),
           actions: <Widget>[
             Stack(
               alignment: Alignment.center,
               children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 5.0, bottom: 5.0, top: 5.0),
                    margin: EdgeInsets.only(right: 5.0),
                    child: FloatingActionButton(               
                          backgroundColor: Theme.of(context).primaryColor,
                          tooltip: 'Mon panier',
                          isExtended: true,
                          heroTag: "Merci",
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 30.0                 
                          ),
                          onPressed: () => Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (_) => CartScreen()
                            )
                          )
                        )
                  ),                 
                  Positioned(                    
                    bottom: 37.0,
                    right: 30.0,
                    child: Text(
                      '${currentUser.cart.length}',
                      textAlign: TextAlign.center,                      
                      style: TextStyle(
                        color:  Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,                        
                        //  letterSpacing: 1.2
                      )
                    ),
                  )
               ],
             ),
           ],
         ),
         body: ListView(
           children: <Widget>[
             Padding(
               padding: EdgeInsets.all(18.0),
               child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(width: 0.8)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(width: 0.8, color: Theme.of(context).primaryColor)
                      ),
                      hintText: 'Search Food or Restaurants',
                      prefixIcon: Icon(
                        Icons.search, 
                        size: 30.0
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {},
                      )
                  ),
                )
             ),
             RecentOrders(),
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Padding(
                   padding: EdgeInsets.symmetric(horizontal: 20.0),
                   child: Text(
                     'Restaurants proches',
                     style: TextStyle(
                       fontSize: 24.0,
                       fontWeight: FontWeight.w600,
                       letterSpacing: 1.2,
                     )
                   ),
                 ),
                 _buildNearlyRestaurant()
               ],
             )       
           ],
         ),
       ),
    );
  }
}