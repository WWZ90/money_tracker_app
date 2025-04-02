import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/controller/transactions_provider.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:provider/provider.dart';

class AddTransactionsDialog extends StatefulWidget {
  const AddTransactionsDialog({super.key});

  @override
  State<AddTransactionsDialog> createState() => _AddTransactionsDialogState();
}

class _AddTransactionsDialogState extends State<AddTransactionsDialog> {
  int? typeIndex = 0;
  TransactionType type = TransactionType.income;
  double amount = 0;
  String description = '';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 650,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 48,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(3)),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'NEW TRANSACTION',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 200,
            child: CupertinoSlidingSegmentedControl(
                groupValue: typeIndex,
                children: const {
                  0: Text('Income'),
                  1: Text('Expense'),
                },
                onValueChanged: (value) {
                  typeIndex = value;
                  type = value == 0
                      ? TransactionType.income
                      : TransactionType.expense;
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'AMOUNT',
            style:
                textTheme.bodySmall!.copyWith(color: Colors.teal, fontSize: 18),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            inputFormatters: [
              CurrencyTextInputFormatter.currency(symbol: '\$')
            ],
            textAlign: TextAlign.center,
            decoration: const InputDecoration.collapsed(
                hintText: '\$0.00', hintStyle: TextStyle(color: Colors.grey)),
            keyboardType: TextInputType.number,
            autofocus: true,
            onChanged: (value) {
              final valueWithoutDollarSign = value.replaceAll('\$', '');
              final valueWithoutComma =
                  valueWithoutDollarSign.replaceAll(',', '');
              if (valueWithoutComma.isNotEmpty) {
                amount = double.parse(valueWithoutComma);
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'DESCRIPTION',
            style:
                textTheme.bodySmall!.copyWith(color: Colors.teal, fontSize: 18),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            textAlign: TextAlign.center,
            decoration: const InputDecoration.collapsed(
                hintText: 'Enter a description here',
                hintStyle: TextStyle(color: Colors.grey)),
            keyboardType: TextInputType.text,
            onChanged: (value) {
              description = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  final transaction = Transaction(
                      type: type, amount: type == TransactionType.income ? amount : -amount, description: description);
                  Provider.of<TransactionsProvider>(context, listen: false)
                      .addTransaction(transaction);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }
}
