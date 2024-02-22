import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(ExpenseModel expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.food;
  DateTime? _selectedDate;
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _currentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: now,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              primaryColor: Colors.blue[900],
            ),
            child: child!,
          );
        });

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title, amount and date was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      ExpenseModel(
          amount: enteredAmount,
          title: _titleController.text,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            controller: _titleController,
            maxLength: 15,
            decoration: const InputDecoration(
              counterStyle: TextStyle(color: Colors.white),
              label: Text(
                'Title',
                style: TextStyle(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          //*****************amount and date**************
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text(
                      'Amount',
                      style: TextStyle(color: Colors.white),
                    ),
                    prefixText: "Rs ",
                    prefixStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _selectedDate == null
                            ? "No Date Selected"
                            : DateFormat('MMM dd, yyyy').format(_selectedDate!),
                        style: const TextStyle(color: Colors.white),
                      ),
                      IconButton(
                        onPressed: _currentDatePicker,
                        icon: const Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          // ***************Dropdownbuttons******************
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(4)),
                child: DropdownButton(
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: const Color(0xff465262),
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 180,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 65, vertical: 20),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xffFDFFAE),
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                    ),
                    onPressed: () {
                      _submitExpenseData();
                    },
                    child: const Text(
                      'Save Expense',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
