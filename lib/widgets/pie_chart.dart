import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_model.dart';

class MyPieChart extends StatelessWidget {
  const MyPieChart({Key? key, required this.expenses}) : super(key: key);

  final List<ExpenseModel> expenses;

  @override
  Widget build(BuildContext context) {
    // Access current theme
    final currentTheme = Theme.of(context);

    // Determine shadow colors based on theme mode
    Color shadowColor = currentTheme.brightness == Brightness.light
        ? Colors.black.withOpacity(0.2)
        : Colors.white.withOpacity(0.1);

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
        showTitle: true,
        title: '${percentage.toStringAsFixed(0)}%',
        radius: 40,
        titleStyle: const TextStyle(fontSize: 10, color: Colors.black),
      );
    }).toList();

    return SizedBox(
      height: 200,
      width: 200,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              height: 180,
              width: 180,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          currentTheme.colorScheme.onBackground,
                          currentTheme.colorScheme.onBackground,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          offset: const Offset(4, 4),
                          blurRadius: 6,
                          spreadRadius: -2,
                        ),
                        BoxShadow(
                          color: shadowColor,
                          offset: const Offset(-4, -4),
                          blurRadius: 6,
                          spreadRadius: -2,
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: 180,
                      width: 180,
                      child: PieChart(
                        swapAnimationDuration:
                            const Duration(milliseconds: 300),
                        swapAnimationCurve: Curves.easeOutQuad,
                        PieChartData(
                          sections: sections,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            // inner circle
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentTheme.colorScheme.onBackground,
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    offset: const Offset(-2, -2),
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: shadowColor,
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Rs $totalExpense',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: currentTheme.colorScheme.onTertiary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
