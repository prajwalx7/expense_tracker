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
            style: TextStyle(fontSize: 18,),
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
              buildCategoryRow('Food', const Color(0xff7ED7C1)),
              const SizedBox(height: 5),
              buildCategoryRow('Travel', const Color(0xff7BD3EA)),
              const SizedBox(height: 5),
              buildCategoryRow('grocery', const Color(0xff756AB6)),
              const SizedBox(height: 5),
              buildCategoryRow('Shopping', const Color(0xffFDFFAE)),
              const SizedBox(height: 5),
              buildCategoryRow('Entertainment', const Color(0xffEF9595)),
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
