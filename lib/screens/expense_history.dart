import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:intl/intl.dart';

class ExpenseHistory extends StatefulWidget {
  final List<ExpenseModel> expenses;

  const ExpenseHistory({Key? key, required this.expenses}) : super(key: key);

  @override
  ExpenseHistoryState createState() => ExpenseHistoryState();
}

class ExpenseHistoryState extends State<ExpenseHistory> {
  late List<DateTime> _dates;
  late DateTime _selectedDate;
  late ScrollController _dateScrollController;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _dates = _generateMonthDates(DateTime.now());
    _dateScrollController = ScrollController();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollToDate(_selectedDate));
  }

  @override
  void dispose() {
    _dateScrollController.dispose();
    super.dispose();
  }

  List<DateTime> _generateMonthDates(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    final List<DateTime> dates = [];
    for (var i = firstDayOfMonth;
        i.isBefore(lastDayOfMonth);
        i = i.add(const Duration(days: 1))) {
      dates.add(i);
    }
    return dates;
  }

  List<ExpenseModel> _getExpensesForDate(DateTime date) {
    final String formattedSelectedDate = DateFormat('yyyy-MM-dd').format(date);
    return widget.expenses
        .where((expense) =>
            DateFormat('yyyy-MM-dd').format(expense.date) ==
            formattedSelectedDate)
        .toList();
  }

  void _scrollToDate(DateTime date) {
    final index = _dates.indexWhere((d) =>
        d.year == date.year && d.month == date.month && d.day == date.day);
    if (index != -1) {
      _dateScrollController.animateTo(index * 100.0,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense History'),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _dateScrollController,
                itemCount: _dates.length,
                itemBuilder: (context, index) {
                  final date = _dates[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedDate = date;
                        });
                      },
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: _selectedDate.year == date.year &&
                                      _selectedDate.month == date.month &&
                                      _selectedDate.day == date.day
                                  ? Colors.blue
                                  : Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(DateFormat('MMM dd').format(date)),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: _getExpensesForDate(_selectedDate).isEmpty
                  ? const Center(
                      child: Text(
                        'No expenses for selected date',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _getExpensesForDate(_selectedDate).length,
                      itemBuilder: (context, index) {
                        final expense =
                            _getExpensesForDate(_selectedDate)[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onBackground,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            height: 90,
                            width: 80,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Image(
                                      image: categoryIcons[expense.category] ??
                                          const AssetImage(
                                              "assets/images/shopping.png"),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // titel
                                        Text(
                                          expense.title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          // Category name
                                          expense.category
                                              .toString()
                                              .split('.')
                                              .last,
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                        const SizedBox(height: 5),
                                        // amount
                                        Text(
                                          'Rs ${expense.amount.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 14),
                                    width: 80,
                                    child: Text(
                                      expense.formattedDate,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
