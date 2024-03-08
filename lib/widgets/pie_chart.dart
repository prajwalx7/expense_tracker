import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_model.dart';

class MyPieChart extends StatelessWidget {
  const MyPieChart({Key? key, required this.expenses}) : super(key: key);

  final List<ExpenseModel> expenses;

  @override
  Widget build(BuildContext context) {
    // Calculate total expense amount
    double totalExpense = expenses.fold(0, (prev, curr) => prev + curr.amount);

    // Group expenses by category manually
    final Map<Category, List<ExpenseModel>> groupedExpenses = {};
    for (var expense in expenses) {
      final category = expense.category;
      groupedExpenses[category] ??= []; // Initialize list if not existing
      groupedExpenses[category]!.add(expense);
    }

    // Calculate section data based on grouped expenses
    List<PieChartSectionData> sections = groupedExpenses.entries.map((entry) {
      final categoryExpenses = entry.value;
      double totalExpenseForCategory =
          categoryExpenses.fold(0, (prev, curr) => prev + curr.amount);
      double percentage = (totalExpenseForCategory / totalExpense) * 100;
      return PieChartSectionData(
          color: categoryExpenses.first.categoryColor,
          value: percentage,
          title: '');
    }).toList();

    // outer circle
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              height: 170,
              width: 170,
              child: PieChart(
                swapAnimationDuration: const Duration(milliseconds: 300),
                swapAnimationCurve: Curves.easeOutQuad,
                PieChartData(
                  sections: sections,
                ),
              ),
            ),
          ),

          // inner circle
          Center(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontWeight: FontWeight.w100, fontSize: 12),
                  ),
                  Center(
                    child: Text(
                      'Rs $totalExpense',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
