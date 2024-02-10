import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(children: [
            Text(
              expense.title,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text('Rs ${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category],
                        color: expense.categoryColor),
                    const SizedBox(width: 5),
                    Text(expense.formatedDate),
                  ],
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
