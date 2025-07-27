import 'package:flutter/material.dart';
import 'package:expense_tracker/expenses.dart';

void main() {
  runApp(
     MaterialApp(
      home: Expenses(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
    )
  );
}