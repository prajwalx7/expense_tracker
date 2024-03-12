import 'package:hive/hive.dart';
part 'expense_storage.g.dart';

@HiveType(typeId: 0)
class ExpenseStorage extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late double amount;

  @HiveField(2)
  late DateTime date;

  @HiveField(3)
  late String category;

  @HiveField(4)
  late String id;

  ExpenseStorage(this.title, this.amount, this.date, this.category, this.id);
}

void saveExpense(ExpenseStorage expense) async {
  final box = await Hive.openBox('expenses');
  await box.add(expense);
  await box.close();
}

Future<List<ExpenseStorage>> loadExpenses() async {
  final box = await Hive.openBox('expenses');
  final expenses = box.values.toList().cast<ExpenseStorage>();

  await box.close();
  return expenses;
}

void dispose() {
  Hive.close();
}
