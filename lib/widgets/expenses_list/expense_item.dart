import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, left: 10, right: 10),
      child: Card(
        color: const Color(0xff465262),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                categoryIcons[expense.category],
                color: expense.categoryColor,
                size: 50,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      expense.formatedDate,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'Rs ${expense.amount.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
