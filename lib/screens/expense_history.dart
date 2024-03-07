import 'package:flutter/material.dart';

class ExpenseHistory extends StatelessWidget {
  const ExpenseHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Expense History"),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: const Center(child: Text("We are still working here!")),
    );
  }
}
