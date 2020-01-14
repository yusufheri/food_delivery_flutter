import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/restaurant.dart';

class Order {
  final Restaurant restaurant;
  final Food food;
  int quantity;
  final String date;

  Order({
    this.restaurant,
    this.food,
    this.date,
    this.quantity
  });
}