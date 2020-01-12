
import 'package:flutter/material.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/widgets/recent_orders.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
             FlatButton(
               child: Text(
                 "Cart (${currentUser.cart.length})",
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 18.0
                 )
                ),
               onPressed: () {},
             )
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
             RecentOrders()           
           ],
         ),
       ),
    );
  }
}