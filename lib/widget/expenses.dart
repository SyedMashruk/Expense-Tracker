import 'package:expense_tracker/structures/expense.dart';
import 'package:expense_tracker/widget/chart/chart.dart';
import 'package:expense_tracker/widget/list_of_expenses/expenses_list.dart';
import 'package:expense_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      expenseName: 'Burger',
      cost: 19.99,
      date: DateTime.now(),
      catagory: Catagory.food,
    ),
    Expense(
      expenseName: 'Office',
      cost: 10,
      date: DateTime.now(),
      catagory: Catagory.travel,
    ),
  ];

  void _addExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
      ),
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _deleteExpense(Expense expense) {
    final index = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(
                index,
                expense,
              );
            });
          },
        ),
        duration: const Duration(
          seconds: 3,
        ),
        content: const Text('Expense Deleted'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _addExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 700
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: _registeredExpenses.isEmpty
                      ? const Center(
                          child: Text('No Expenses. Try to add some!'),
                        )
                      : ExpensesList(
                          expense: _registeredExpenses,
                          onDeleteExpense: _deleteExpense,
                        ),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(
                    expenses: _registeredExpenses,
                  ),
                ),
                Expanded(
                  child: _registeredExpenses.isEmpty
                      ? const Center(
                          child: Text('No Expenses. Try to add some!'),
                        )
                      : ExpensesList(
                          expense: _registeredExpenses,
                          onDeleteExpense: _deleteExpense,
                        ),
                ),
              ],
            ),
    );
  }
}
