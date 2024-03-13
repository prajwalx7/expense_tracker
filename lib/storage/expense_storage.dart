import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker/models/expense_model.dart';

class ExpenseStorage {
  static const _keyExpenses = 'expenses';

  Future<List<ExpenseModel>> loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? expenseStrings = prefs.getStringList(_keyExpenses);
    return expenseStrings
            ?.map((expenseString) =>
                ExpenseModel.fromJson(jsonDecode(expenseString)))
            .toList() ??
        [];
  }

  Future<void> saveExpense(ExpenseModel expense) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> expenseStrings = prefs.getStringList(_keyExpenses) ?? [];
    final String jsonExpense = jsonEncode(expense.toJson());
    expenseStrings.add(jsonExpense);
    await prefs.setStringList(_keyExpenses, expenseStrings);
  }

  Future<void> removeExpense(String expenseId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> expenseStrings = prefs.getStringList(_keyExpenses) ?? [];
    expenseStrings.removeWhere(
        (expenseString) => jsonDecode(expenseString)['id'] == expenseId);
    await prefs.setStringList(_keyExpenses, expenseStrings);
  }
}
