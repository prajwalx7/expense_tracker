import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker/models/expense_model.dart';

class ExpenseStorage {
  static const _keyExpenses = 'expenses';

  Future<List<ExpenseModel>> loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? expenseStrings = prefs.getStringList(_keyExpenses);
    if (expenseStrings == null) {
      return [];
    }
    return expenseStrings.map((expenseString) {
      final Map<String, dynamic> expenseJson = jsonDecode(expenseString);
      return ExpenseModel.fromJson(expenseJson);
    }).toList();
  }

  Future<void> saveExpense(ExpenseModel expense) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> expenseStrings = prefs.getStringList(_keyExpenses) ?? [];

    // Print expense object before encoding to JSON
    print('Expense object before encoding to JSON: $expense');

    // Encode expense object to JSON
    String jsonExpense = jsonEncode(expense.toJson());
    print('Encoded JSON string: $jsonExpense');

    // Add encoded JSON string to the list of expenses
    expenseStrings.add(jsonExpense);

    // Save the list of expenses to SharedPreferences
    await prefs.setStringList(_keyExpenses, expenseStrings);
  }

  Future<void> removeExpense(String expenseId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> expenseStrings = prefs.getStringList(_keyExpenses) ?? [];
    expenseStrings.removeWhere((expenseString) {
      final Map<String, dynamic> expenseJson = jsonDecode(expenseString);
      return expenseJson['id'] == expenseId;
    });
    await prefs.setStringList(_keyExpenses, expenseStrings);

    print('Expense removed from SharedPreferences: $expenseId');
  }
}
