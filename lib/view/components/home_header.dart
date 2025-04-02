import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:money_tracker/controller/transactions_provider.dart';

import '../widgets/header_card.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final provider = Provider.of<TransactionsProvider>(context);
    final balance = provider.getBalance();
    final incomes = provider.getTotalIncomes();
    final expenses = provider.getTotalExpenses();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.teal,
      ),
      height: 240,
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'MONEY TRACKER',
            style: textTheme.titleSmall?.copyWith(
                color: const Color.fromARGB(255, 0, 39, 33),
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Balance:',
            style: textTheme.bodySmall?.copyWith(
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.w200,
                fontSize: 20),
          ),
          Text(
            '\$${balance.toStringAsFixed(2)}',
            style: textTheme.headlineLarge?.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                HeaderCard(
                  title: 'Incomes',
                  amount: incomes,
                  icon: const Icon(
                    Icons.attach_money,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                HeaderCard(
                  title: 'Expenses',
                  amount: expenses,
                  icon: const Icon(
                    Icons.money_off,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
