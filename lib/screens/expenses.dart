import 'package:expense_tracker/screens/expense_history.dart';
import 'package:expense_tracker/storage/expense_storage.dart';
import 'package:expense_tracker/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expense_category_list.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/pie_chart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseModel> _registeredExpenses = [];

  void _onadd() {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          height: MediaQuery.of(context).size.height * 0.7,
          child: NewExpense(
            onAddExpense: addExpense,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Initialize Hive
    Hive.initFlutter();
    _loadExpenses();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  void _loadExpenses() async {
    try {
      final box = await Hive.openBox<ExpenseStorage>('expenses');
      final List<ExpenseStorage> expensesStorage = box.values.toList();
      final List<ExpenseModel> expenses = expensesStorage
          .map((expenseStorage) => ExpenseModel(
                title: expenseStorage.title,
                amount: expenseStorage.amount,
                date: expenseStorage.date,
                category: getCategoryFromString(expenseStorage.category),
                id: expenseStorage.id,
              ))
          .toList();
      setState(() {
        _registeredExpenses.addAll(expenses);
      });
      // Close the box
      await box.close();
    } catch (e) {
      print('Error loading expenses: $e');
    }
  }

  void addExpense(ExpenseModel expense) async {
    try {
      final box = await Hive.openBox<ExpenseStorage>('expenses');
      final expenseStorage = ExpenseStorage(
        expense.title,
        expense.amount,
        DateTime.now(), // Assign the current date
        expense.category.toString(), // Convert Category enum to string
        expense.id,
      );
      await box.add(expenseStorage);
      await box.close();

      setState(() {
        _registeredExpenses.add(expense);
      });
    } catch (e) {
      print('Error saving expense: $e');
    }
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/avatar.jpeg"),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Row(
                        children: [
                          const Text(
                            "Recent Activity",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 25.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExpenseHistory(
                                        expenses: _registeredExpenses),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  minimumSize: const Size(70, 10),
                                  elevation: 0,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.onPrimary),
                              child: const Text(
                                "view all",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    _registeredExpenses.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.only(top: 180),
                            child: Text(
                              "No data available",
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        : ExpensesList(
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
