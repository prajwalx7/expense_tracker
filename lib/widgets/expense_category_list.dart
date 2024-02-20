import 'package:flutter/material.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10), 
          child: Text(
            "Today's Expenses",
            style: TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCategoryRow('Food', const Color.fromRGBO(123, 201, 82, 1)),
              const SizedBox(height: 5), // Add spacing between rows
              buildCategoryRow('Travel', const Color.fromRGBO(46, 198, 255, 1)),
              const SizedBox(height: 5), // Add spacing between rows
              buildCategoryRow('Leisure', const Color.fromRGBO(82, 98, 255, 1)),
              const SizedBox(height: 5), // Add spacing between rows
              buildCategoryRow('Work', const Color.fromRGBO(255, 171, 67, 1)),
              const SizedBox(height: 5), // Add spacing between rows
              buildCategoryRow('Others', const Color.fromRGBO(252, 91, 57, 1)),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildCategoryRow(String category, Color color) {
  return Row(
    children: [
      Container(
        height: 12,
        width: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
      const SizedBox(
        width: 5,
      ),
      Expanded(
        child: Text(
          category,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    ],
  );
}
