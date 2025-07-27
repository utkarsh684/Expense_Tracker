import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses =[
    Expense(
        title: 'Flutter Course',
        amount:19.99,
        date: DateTime.now(),
        category: Category.work
    ),
    Expense(
        title: 'Cinema',
        amount:15.69,
        date: DateTime.now(),
        category: Category.leisure
    ),
  ];

  void _openAddExpenseOverLay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense,),
    );
  }

  void _addExpense (Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex=_registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Expense Deleted'),
      duration: Duration(seconds: 3),
      action: SnackBarAction(label: 'Undo', onPressed: (){
        setState(() {
          _registeredExpenses.insert(expenseIndex, expense);
        });
      }),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    widget mainContent = const Center(
      child: Text('No expenses found,start adding some!'),
    );

    if(_registeredExpenses.isNotEmpty){
      mainContent=ExpensesList(
          _registeredExpenses,
          _removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverLay,
            icon: Icon(Icons.add),),
        ],
      ),
      body: Column(
        children: [
           Text('The chart'),
          Expanded(child: mainContent,
          ),
        ],
      ),
    );
  }
}
