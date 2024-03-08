import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_model.dart';

class ExpenseHistory extends StatelessWidget {
  final List<ExpenseModel> expenses;

  const ExpenseHistory({Key? key, required this.expenses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense History'),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 50, 
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    onTap: () {
                      
                    },
                    child: Container(
                      width: 100, 
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(expense.formattedDate),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return ListTile(
                  title: Text(expense.title),
                  subtitle:
                      Text('Amount: \$${expense.amount.toStringAsFixed(2)}'),
                  trailing: Text(expense.category.toString().split('.').last),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
