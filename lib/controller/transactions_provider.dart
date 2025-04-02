import 'package:flutter/material.dart';
import 'package:money_tracker/model/transaction.dart';

class TransactionsProvider extends ChangeNotifier {
  final List<Transaction> _transactions = [
    Transaction(
      type: TransactionType.income,
      amount: 1000.00,
      description: 'Salary',
    ),
    Transaction(
      type: TransactionType.expense,
      amount: -300.00,
      description: 'Rent',
    ),
  ];

  List<Transaction> get transactions => _transactions;

  double getTotalIncomes() {
    return _transactions
        .where((transaction) => transaction.type == TransactionType.income)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double getTotalExpenses() {
    return _transactions
        .where((transaction) => transaction.type == TransactionType.expense)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }

  double getBalance() {
    return getTotalIncomes() + getTotalExpenses();
  }

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }
}
