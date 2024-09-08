import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatDate = DateFormat.yMMMd();
const uid = Uuid();

enum Catagory {
  food,
  work,
  travel,
  leisure,
  others,
}

const catagoryIcon = {
  Catagory.food: Icons.lunch_dining,
  Catagory.leisure: Icons.movie_filter,
  Catagory.travel: Icons.flight_takeoff,
  Catagory.work: Icons.work,
  Catagory.others: Icons.all_inclusive,
};

class Expense {
  Expense({
    required this.expenseName,
    required this.cost,
    required this.date,
    required this.catagory,
  }) : id = uid.v4();

  final String id;
  final String expenseName;
  final double cost;
  final DateTime date;
  final Catagory catagory;

  String get formattedDate {
    return formatDate.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({
    required this.catagory,
    required this.expenses,
  });

  ExpenseBucket.forCatagory(List<Expense> allExpenses, this.catagory)
      : expenses = allExpenses
            .where((expense) => expense.catagory == catagory)
            .toList();

  final Catagory catagory;
  final List<Expense> expenses;

  double get totalExpense {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.cost;
    }
    return sum;
  }
}
