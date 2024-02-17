import 'package:expense_tracker/widgets/expense_category_list.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/pie_chart.dart';
import 'package:flutter/Material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseModel> _registeredExpenses = [
    ExpenseModel(
      amount: 150,
      title: 'Lunch',
      date: DateTime.now(),
      category: Category.food,
    ),
    ExpenseModel(
      amount: 300,
      title: 'Grocery',
      date: DateTime.now(),
      category: Category.leisure,
    ),
    ExpenseModel(
      amount: 50,
      title: 'Stationery',
      date: DateTime.now(),
      category: Category.others,
    ),
    ExpenseModel(
      amount: 650,
      title: 'Tickets',
      date: DateTime.now(),
      category: Category.travel,
    ),
    ExpenseModel(
      amount: 500,
      title: 'Keyboard',
      date: DateTime.now(),
      category: Category.work,
    ),
    ExpenseModel(
      amount: 300,
      title: 'Hotel',
      date: DateTime.now(),
      category: Category.food,
    ),
    ExpenseModel(
      amount: 1000,
      title: 'Fees',
      date: DateTime.now(),
      category: Category.work,
    ),
  ];

  void _onadd() {
    showModalBottomSheet(
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
    Widget mainContent = const Center(
      child: Text(
        'No data available!',
        style: TextStyle(color: Colors.white),
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xff1F2537),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            onPressed: _onadd,
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            SizedBox(
              height: 240,
              width: 390,
              child: Card(
                color: const Color(0xffE0E1DD),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 1,
                        child: ExpenseCategoryList(),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: MyPieChart(
                          expenses: _registeredExpenses,
                        ),
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
            Expanded(
              child: mainContent,
            ),
          ],
        ),
      ),
    );
  }
}
