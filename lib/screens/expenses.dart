import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expense_category_list.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/pie_chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseModel> _registeredExpenses = [
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
      backgroundColor: const Color(0xff465262),
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
        duration: const Duration(seconds: 3),
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
      backgroundColor: const Color(0xff1F2537),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Hi, Welcome Back!",
                  style: TextStyle(fontSize: 20, color: Colors.white),
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
                          color: const Color(0xff465262),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              const Expanded(
                                // flex: 1,
                                child: ExpenseCategoryList(),
                              ),
                              // const Spacer(),
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
                              color: Colors.white,
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
          backgroundColor: const Color(0xffFDFFAE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
