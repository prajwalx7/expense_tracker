import 'package:expense_tracker/screens/expense_history.dart';
import 'package:expense_tracker/storage/expense_storage.dart';
import 'package:expense_tracker/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expense_category_list.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/pie_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseModel> _registeredExpenses = [];
  late ExpenseStorage _expenseStorage;

  @override
  void initState() {
    super.initState();
    _expenseStorage = ExpenseStorage(); // Initialize expense store
    _loadExpenses(); // Load expenses when the widget initialise
  }

  void _loadExpenses() async {
    List<ExpenseModel> expenses = await _expenseStorage.loadExpenses();
    setState(() {
      _registeredExpenses
          .addAll(expenses); // Add loaded expenses to _registeredExpenses
    });
  }

  void _onadd() {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          height: MediaQuery.of(context).size.height * 0.6,
          child: NewExpense(
            onAddExpense: _addExpense,
          ),
        ),
      ),
    );
  }

  void _addExpense(ExpenseModel expense) {
    _registeredExpenses.add(expense);
    _expenseStorage.saveExpense(expense).then((_) {
      // print('Expense saved successfully:');
    }).catchError((error) {
      // print('Error saving expense: $error');
    });
    setState(() {});
  }

  void _removeExpense(ExpenseModel expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    _expenseStorage.removeExpense(expense.id);
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
            _expenseStorage.saveExpense(expense);
          },
        ),
      ),
    );

    // print('Expense removed from _registeredExpenses: $_registeredExpenses');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundImage: AssetImage("assets/images/avatar.jpeg"),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome Back!",
                              style: TextStyle(fontSize: 15.sp),
                            ),
                            Text(
                              "Prajwal Dudhatkar",
                              style: TextStyle(fontSize: 18.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: IconButton(
                        iconSize: 30.sp,
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 180.h,
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15.r),
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
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 18.0.w),
                        child: Row(
                          children: [
                            Text(
                              "Recent Activity",
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 25.0.w),
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
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 5.h),
                                    minimumSize: Size(70.w, 10.h),
                                    elevation: 0,
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                                child: Text(
                                  "view all",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      _registeredExpenses.isEmpty
                          ? Padding(
                              padding: EdgeInsets.only(top: 100.h),
                              child: Text(
                                "No data available",
                                style: TextStyle(fontSize: 16.sp),
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
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(right: 10.w),
        child: FloatingActionButton(
          onPressed: _onadd,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
