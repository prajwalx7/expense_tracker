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
    expenseStrings.add(jsonEncode(expense.toJson())); 
    await prefs.setStringList(_keyExpenses, expenseStrings);
  }
}
