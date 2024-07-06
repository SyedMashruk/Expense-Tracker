import 'package:expense_tracker/structures/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItemList extends StatelessWidget {
  const ExpenseItemList(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.expenseName,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 17,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  '\$${expense.cost.toStringAsFixed(2)}',
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(catagoryIcon[expense.catagory]),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      expense.formattedDate,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
