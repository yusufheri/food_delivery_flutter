import 'package:flutter/material.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/widgets/rating_starts.dart';

class RestaurantScreen extends StatefulWidget {

  final Restaurant restaurant;

  RestaurantScreen({this.restaurant});

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _buildMenuItem(Food menuItem) {
   
    double taille = MediaQuery.of(context).size.width / 2.25;
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: taille,
            width: taille,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(menuItem.imageUrl),
                fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.circular(15.0)
            ),
          ),
          Container(
            height:taille,
            width: taille,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black87.withOpacity(0.3),
                  Colors.black54.withOpacity(0.3),
                  Colors.black38.withOpacity(0.3),
                ],
                stops: [0.1, 0.4, 0.6, 0.9],
              )
            ),
          ),
          Positioned(
            bottom: 65.0,
            child: Column(
              children: <Widget>[
                Text(
                  menuItem.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2
                  )
                ),
                Text(
                  '\$${menuItem.price}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2
                  )
                )
              ],
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: Container(
              width: 48.0,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30.0)
              ),
              child: IconButton(
                icon: Icon(Icons.add),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: () {
                  currentUser.cart.add(
                    new Order(food: menuItem, quantity: 1, restaurant: widget.restaurant, date: DateTime.now().toString())
                  );
                  _snack(menuItem);
                },
              ),
            )
          )
        ],
      ),
    );
  }

  _snack(Food menuItem) {
    SnackBar snackBar = new SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content:Text(
        '${menuItem.name} a été ajouté dans votre panier',
        style: TextStyle(
          fontWeight: FontWeight.w600
        ),
      ),
      elevation: 1.0,
      action: SnackBarAction(
        label: "Annuler",
        textColor: Colors.white,
        onPressed: () {
          currentUser.cart.removeAt(currentUser.cart.length-1);
        },
      ),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key : _scaffoldKey,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Hero(
                tag: widget.restaurant.name,
                child:  Image(
                    height: 200.0,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    image: AssetImage(widget.restaurant.imageUrl),
                  )
              ) ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      iconSize: 30.0,
                      onPressed: () {Navigator.pop(context);},
                    ),
                      IconButton(
                      icon: Icon(Icons.favorite),
                      color: Theme.of(context).primaryColor,
                      iconSize: 50.0,
                      onPressed: () {},
                    )
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.restaurant.name,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600
                      )
                    ),
                    Text(
                    '0.2 miles away',
                      style: TextStyle(
                        fontSize: 18.0,
                      )
                    )
                  ],
                ),
                RatingStarts(rating: widget.restaurant.rating, taille: 35.0,),
              SizedBox(height: 6.0,),
              Text(
                widget.restaurant.address,
                style: TextStyle(
                  fontSize: 15.0
                )
              )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,             
            children: <Widget>[
            FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Text(
                  'Reviews',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0
                  )
                ),
                onPressed: () {},
              ),
            FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Text(
                  'Contact',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0
                  )
                ),
                onPressed: () {},
              ),
            ],
          ),
        SizedBox(height: 6.0),
        Center(
            child: Text(
              'Menu',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2
              )
            ),
          ),
          SizedBox(height: 10.0,),
          Expanded(
            child: GridView.count(
                  padding: EdgeInsets.all(10.0),
                  crossAxisCount: 2,
                  //  crossAxisSpacing: 15.0,                    
                  children: List.generate(widget.restaurant.menu.length, (index) {
                    Food food = widget.restaurant.menu[index];
                    return _buildMenuItem(food);
                  }),
                )
          ),            
        ],
      ),
    );
  }
}