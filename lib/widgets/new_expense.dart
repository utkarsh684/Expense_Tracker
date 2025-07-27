import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/expenses.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key,required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {

  final _textController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory=Category.leisure;

  void _submitExpenseData() {
    final enteredAmount=double.tryParse(_amountController.text);
    final amountIsInvalid=enteredAmount == null || enteredAmount <= 0;
    if(_textController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedCategory==null){
      showDialog(context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please make sure a valid title, amount, date and category was entered'),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(ctx);
            },
              child: const Text('Okay'),
            ),
          ],
        ),);
      return;
    }
    final newExpense = Expense(
      title: _textController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    );
    widget.onAddExpense(newExpense);
    Navigator.pop(context);
  }

  void _presentDatePicker() async {
    final now=DateTime.now();
    final firstDate=DateTime(now.year-1,now.month,now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate=pickedDate;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(16,48,16,16),
      child: Column(
        children: [
          TextField(
            controller: _textController,
            maxLength: 50,
            decoration: InputDecoration(
              label:Text('title'),
            ),
          ),
          Row(
            children: [
              Expanded(child:TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixText: '\$ ',
              label:Text('amount'),
            ),
          ),
              ),
              SizedBox(width: 16,),
              Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Selected Date'),
                  IconButton(onPressed: _presentDatePicker, icon: const Icon(Icons.calendar_month),),
                ],
              ),
              ),
          ],
          ),
          SizedBox(height: 16,),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items:Category.values.map((category) => DropdownMenuItem(
                    value: category,
                    child: Text(category.name.toUpperCase()),
                  ),
              ).toList(),
                  onChanged: (value){
                    if(value==null){
                      return;
                    }
                setState(() {
                  _selectedCategory=value;
                });
                  }),
              const Spacer(),
              TextButton(
                onPressed: (){
                Navigator.pop(context);
              }, child: Text('Cancel'),),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: Text("Save Expense"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
