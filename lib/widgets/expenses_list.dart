import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/expenses.dart';
import 'package:expense_tracker/widgets/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(this.expenses,{super.key});
  
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => ExpenseItem(expenses[index]),
    );
  }
}
