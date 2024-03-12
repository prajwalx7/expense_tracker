import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


enum Category { food, shopping, entertainment, transportation, miscellaneous }

Category getCategoryFromString(String categoryString) {
  switch (categoryString) {
    case 'food':
      return Category.food;
    case 'shopping':
      return Category.shopping;
    case 'entertainment':
      return Category.entertainment;
    case 'transportation':
      return Category.transportation;
    case 'miscellaneous':
      return Category.miscellaneous;
    default:
      return Category.miscellaneous; // Default to miscellaneous if categoryString is not recognized
  }
}

const categoryIcons = {
  Category.food: AssetImage("assets/images/food.png"),
  Category.shopping: AssetImage("assets/images/shopping.png"),
  Category.entertainment: AssetImage("assets/images/entertainment.png"),
  Category.transportation: AssetImage("assets/images/travel.png"),
  Category.miscellaneous: AssetImage("assets/images/grocery.png"),
};

class ExpenseModel {
  ExpenseModel({
    required this.amount,
    required this.title,
    required this.date,
    required this.category,
    required this.id,
  });

  final double amount;
  final DateTime date;
  final String id;
  final String title;
  final Category category;


  String get formattedDate {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  // Piechrt colors
  Color get categoryColor {
    switch (category) {
      case Category.food:
        return const Color(0xff7ED7C1);
      case Category.shopping:
        return const Color(0xffFDFFAE);
      case Category.entertainment:
        return const Color(0xff756AB6);
      case Category.transportation:
        return const Color(0xff7BD3EA);
      case Category.miscellaneous:
        return const Color(0xffEF9595);
      default:
        return Colors.black;
    }
  }
}
