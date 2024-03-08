import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

// const uuid = Uuid();

enum Category { food, shopping, entertainment, transportation, miscellaneous }

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

  // constrctor to create expense model from JSON data
  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      amount: json['amount'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      category: _categoryFromString(json['category']),
      id: json['id'],
    );
  }

  // convert expense moodel object to JSON data
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'title': title,
      'date': date.toIso8601String(),
      'category': category.toString().split('.').last,
      'id': id,
    };
  }

  // helper method to convert string to Category enum
  static Category _categoryFromString(String categoryString) {
    return Category.values.firstWhere(
      (category) => category.toString().split('.').last == categoryString,
    );
  }

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
