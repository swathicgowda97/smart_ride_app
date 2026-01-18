import 'package:flutter/material.dart';

class RecentTripTile extends StatelessWidget {
  const RecentTripTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange.shade50,
      child: ListTile(
        leading: const Icon(Icons.local_taxi),
        title: const Text('MG Road → Indiranagar'),
        subtitle: const Text('Mini • ₹180'),
        trailing: const Text('Completed'),
      ),
    );
  }
}
