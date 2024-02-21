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
        return const Color(0xff756AB6);
      case Category.travel:
        return const Color(0xff7BD3EA);
      case Category.food:
        return const Color(0xff7ED7C1);
      case Category.work:
        return const Color(0xffFDFFAE);
      case Category.others:
        return const Color(0xffEF9595);
    }
  }
}

