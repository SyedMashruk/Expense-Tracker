import 'package:expense_tracker/structures/expense.dart';
import 'package:expense_tracker/widget/list_of_expenses/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expense, required this.onDeleteExpense});

  final void Function(Expense expense) onDeleteExpense;
  final List<Expense> expense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          color: Theme.of(context)
              .colorScheme
              .error
              .withBlue(255)
              .withOpacity(.10),
          margin: Theme.of(context).cardTheme.margin,
        ),
        key: ValueKey(
          expense[index],
        ),
        onDismissed: (direction) {
          onDeleteExpense(expense[index]);
        },
        child: ExpenseItemList(
          expense[index],
        ),
      ),
    );
  }
}
