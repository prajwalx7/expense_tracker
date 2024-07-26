import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.h, right: 10.w),
          child: Text(
            "Daily Expenses",
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCategoryRow('Food', const Color(0xff7ED7C1)),
              const SizedBox(height: 5),
              buildCategoryRow('Shopping', const Color(0xffFDFFAE)),
              const SizedBox(height: 5),
              buildCategoryRow('Entertainment', const Color(0xff756AB6)),
              const SizedBox(height: 5),
              buildCategoryRow('Transportation', const Color(0xff7BD3EA)),
              const SizedBox(height: 5),
              buildCategoryRow('Miscellaneous', const Color(0xffEF9595)),
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
        height: 12.h,
        width: 12.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
      SizedBox(
        width: 5.w,
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
