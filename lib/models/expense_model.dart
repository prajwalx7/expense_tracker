import 'package:flutter/Material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formater = DateFormat.yMd();

enum Category { food, travel, leisure, work, others }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.work: Icons.work,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.others: Icons.adjust,
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
    return formater.format(date);
  }

  Color get categoryColor {
    switch (category) {
      case Category.leisure:
        return const Color.fromRGBO(82, 98, 255, 1);
      case Category.travel:
        return const Color.fromRGBO(46, 198, 255, 1);
      case Category.food:
        return const Color.fromRGBO(123, 201, 82, 1);
      case Category.work:
        return const Color.fromRGBO(255, 171, 67, 1);
      case Category.others:
        return const Color.fromRGBO(252, 91, 57, 1);
    }
  }
}

  // rgb(46, 198, 255)
   // rgb(123, 201, 82)
   // rgb(255, 171, 67)
  //  rgb(252, 91, 57)
  // Color.fromRGBO(139, 135, 130, 1), 