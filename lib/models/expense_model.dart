import 'package:flutter/Material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

enum Category { food, travel, grocery, shopping, entertainment }

const categoryIcons = {
  Category.food: AssetImage("assets/images/food.png"),
  Category.shopping: AssetImage("assets/images/shopping.png"),
  Category.travel: AssetImage("assets/images/travel.png"),
  Category.grocery: AssetImage("assets/images/grocery.png"),
  Category.entertainment: AssetImage("assets/images/entertainment.png"),
};

class ExpenseModel {
  ExpenseModel(
      {required this.amount,
      required this.title,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final double amount;
  final DateTime date;
  final String id;
  final String title;
  final Category category;

  String get formatedDate {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  // Pie Chart Colors

  Color get categoryColor {
    switch (category) {
      case Category.grocery:
        return const Color(0xff756AB6);
      case Category.travel:
        return const Color(0xff7BD3EA);
      case Category.food:
        return const Color(0xff7ED7C1);
      case Category.shopping:
        return const Color(0xffFDFFAE);
      case Category.entertainment:
        return const Color(0xffEF9595);
    }
  }
}
