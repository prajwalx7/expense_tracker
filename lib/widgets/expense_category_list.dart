import 'package:flutter/material.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          const Text(
            "Daily Expenses",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCategoryRow('Food', const Color.fromRGBO(123, 201, 82, 1)),
              buildCategoryRow('Travel', const Color.fromRGBO(46, 198, 255, 1)),
              buildCategoryRow('Leisure', const Color.fromRGBO(82, 98, 255, 1)),
              buildCategoryRow('Work', const Color.fromRGBO(255, 171, 67, 1)),
              buildCategoryRow('Others', const Color.fromRGBO(252, 91, 57, 1)),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCategoryRow(String category, Color color) {
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
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
}
