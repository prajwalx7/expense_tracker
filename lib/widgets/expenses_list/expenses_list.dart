import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({
    Key? key,
    required this.expenses,
    required this.onRemoveExpense,
  }) : super(key: key);

  final List<ExpenseModel> expenses;
  final void Function(ExpenseModel expense) onRemoveExpense;

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          MediaQuery.of(context).size.height * 0.6, 
      child: FadingEdgeScrollView.fromScrollView(
        gradientFractionOnEnd: 0.08,
        gradientFractionOnStart: 0.08,
        child: ListView.builder(
          controller: _controller,
          padding: const EdgeInsets.only(bottom: 140),
          itemCount: widget.expenses.length,
          itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(widget.expenses[index]),
            onDismissed: (direction) {
              widget.onRemoveExpense(widget.expenses[index]);
            },
            child: ExpenseItem(
              widget.expenses[index],
            ),
          ),
        ),
      ),
    );
  }
}
