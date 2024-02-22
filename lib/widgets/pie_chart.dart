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

    // Calculate the percentage of each category
    List<PieChartSectionData> sections = expenses.map((expense) {
      double percentage = (expense.amount / totalExpense) * 100;
      return PieChartSectionData(
          color: expense.categoryColor, value: percentage, title: '');
    }).toList();

    // outer circle
    return Container(
      height: 200,
      width: 200,
      decoration: const BoxDecoration(
        color: Color(0xff1F2537),
        shape: BoxShape.circle,
        // boxShadow: [
        //   BoxShadow(
        //     spreadRadius: -2,
        //     blurRadius: 20,
        //     offset: Offset(5, 5),
        //     color: Color.fromARGB(255, 208, 252, 65),
        //   ),
        //   BoxShadow(
        //     spreadRadius: -2,
        //     blurRadius: 15,
        //     offset: Offset(-5, -5),
        //     color: Color.fromARGB(255, 204, 249, 40),
        //   )
        // ],
      ),
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              height: 170,
              width: 170,
              child: PieChart(
                swapAnimationDuration: const Duration(milliseconds: 750),
                swapAnimationCurve: Curves.easeInOutQuint,
                PieChartData(
                  sections: sections,
                ),
              ),
            ),
          ),

          // inner circle
          Center(
            child: Container(
              height: 90,
              decoration: const BoxDecoration(
                color: Color(0xff1F2537),
                shape: BoxShape.circle,
                // boxShadow: [
                //   const BoxShadow(
                //     blurRadius: 1,
                //     offset: Offset(-1, -1),
                //     color: Colors.white,
                //   ),
                //   BoxShadow(
                //     spreadRadius: -2,
                //     blurRadius: 10,
                //     offset: const Offset(5, 5),
                //     color: Colors.black.withOpacity(0.5),
                //   )
                // ],
              ),
              child: Center(
                child: Text(
                  'Rs $totalExpense',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}