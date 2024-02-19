import 'package:expense_tracker/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

class UserStatistics extends StatelessWidget {
  const UserStatistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Statistics Page',
                style: TextStyle(color: Colors.black),
              ),
            ),
            MyBottomBar(
              onAdd: () {},
              onNavigateHome: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              onNavigateStatistics: () {},
            ),
          ],
        ),
      ),
    );
  }
}
