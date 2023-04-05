import 'package:flutter/material.dart';

import '../../widgets/expenses/user_transaction.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                elevation: 5,
                child: Text('Chart!'),
              ),
            ),
            UserTransactions(),
          ],
        ),
      ),
    );
  }
}
