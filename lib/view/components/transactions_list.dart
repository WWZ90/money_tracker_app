import 'package:flutter/material.dart';
import 'package:money_tracker/controller/transactions_provider.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:provider/provider.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final transactions =
        Provider.of<TransactionsProvider>(context).transactions;

    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            final type = transaction.type == TransactionType.income
                ? 'Income'
                : 'Expense';
            final color = transaction.type == TransactionType.income
                ? Colors.teal
                : Colors.red;
            final value = transaction.type == TransactionType.income
                ? '\$${transaction.amount.toStringAsFixed(2)}'
                : '-\$${transaction.amount.abs().toStringAsFixed(2)}';
            final icon = transaction.type == TransactionType.income
                ? const Icon(Icons.attach_money, color: Colors.teal)
                : const Icon(Icons.money_off, color: Colors.red);
            return ListTile(
              leading: icon,
              title: Text(transaction.description),
              subtitle: Text(type),
              trailing: Text(
                value,
                style: TextStyle(fontSize: 16, color: color),
              ),
            );
          },
        ),
        /*
        child: ListView(
          children: const [
            ListTile(
              leading: Icon(
                Icons.attach_money,
                color: Colors.teal,
              ),
              title: Text('Income'),
              subtitle: Text('Salary'),
              trailing: Text('\$95.00', style: TextStyle(fontSize: 16),),
            ),
            ListTile(
              leading: Icon(
                Icons.money_off,
                color: Colors.red,
              ),
              
              title: Text('Expenses'),
              subtitle: Text('Rent'),
              trailing: Text('-\$95.00', style: TextStyle(fontSize: 16),),
            ),
          ],
        ),
        */
      ),
    );
  }
}
