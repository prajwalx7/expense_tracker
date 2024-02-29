import 'package:expense_tracker/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expense_category_list.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/pie_chart.dart';
import 'package:provider/provider.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseModel> _registeredExpenses = [
    // dummy expenses
    ExpenseModel(
      amount: 250,
      title: 'Lunch',
      date: DateTime.now(),
      category: Category.food,
    ),
    ExpenseModel(
      amount: 300,
      title: 'Grocery',
      date: DateTime.now(),
      category: Category.grocery,
    ),
    ExpenseModel(
      amount: 500,
      title: 'Movie',
      date: DateTime.now(),
      category: Category.entertainment,
    ),
    ExpenseModel(
      amount: 650,
      title: 'Fuel',
      date: DateTime.now(),
      category: Category.travel,
    ),
    ExpenseModel(
      amount: 500,
      title: 'Clothes',
      date: DateTime.now(),
      category: Category.shopping,
    ),
  ];

  void _onadd() {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: NewExpense(
            onAddExpense: _addExpense,
          ),
        ),
      ),
    );
  }

  void _addExpense(ExpenseModel expense) {
    _registeredExpenses.add(expense);
    setState(() {});
  }

  void _removeExpense(ExpenseModel expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense has been deleted'),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/avatar.jpeg"),
                    ),
                    const SizedBox(width: 10),
                    const Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back!",
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            "Prajwal Dudhatkar",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: IconButton(
                        iconSize: 30,
                        onPressed: () {
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme();
                        },
                        icon: Icon(
                          Theme.of(context).brightness == Brightness.light
                              ? Icons.dark_mode_outlined
                              : Icons.light_mode_outlined,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 240,
                      width: 390,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onBackground,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              const Expanded(
                                child: ExpenseCategoryList(),
                              ),
                              MyPieChart(
                                expenses: _registeredExpenses,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 18.0),
                      child: Row(
                        children: [
                          Text(
                            "Recent Activity",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ExpensesList(
                      expenses: _registeredExpenses,
                      onRemoveExpense: _removeExpense,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(right: 10),
        child: FloatingActionButton(
          onPressed: _onadd,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
