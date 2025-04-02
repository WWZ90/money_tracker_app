import 'package:flutter/material.dart';
import 'package:money_tracker/view/components/add_transactions_dialog.dart';

import 'components/home_header.dart';
import 'components/transactions_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: const SafeArea(
        bottom: false,
        child: Column(
          children: [HomeHeader(), TransactionsList()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return const AddTransactionsDialog();
                });
          },
          backgroundColor: Colors.teal,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}
