import 'package:flutter/material.dart';

class SpendingLimitCard extends StatelessWidget {
  final VoidCallback onTap;

  const SpendingLimitCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange.shade100,
      child: ListTile(
        leading: Icon(
          Icons.account_balance_wallet,
          color: Colors.orange.shade800,
        ),
        title: const Text(
          'Ride Spending Limits',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text('Set monthly limits per ride type'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
