import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/ride_types.dart';
import '../../state/limits/spending_limit_notifier.dart';

class SpendingLimitScreen extends ConsumerWidget {
  const SpendingLimitScreen({super.key});

  Color _statusColor(double spent, double limit) {
    if (limit == 0) return Colors.grey;
    if (spent > limit) return Colors.red;
    if (spent > limit * 0.8) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(spendingLimitProvider);
    final notifier = ref.read(spendingLimitProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Ride Spending Limits')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: RideType.values.map((type) {
          final limit = state.limits[type] ?? 0;
          final spent = notifier.spentFor(type);
          final color = _statusColor(spent, limit);

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type.label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    'Spent: ₹${spent.toStringAsFixed(0)} / ₹${limit.toStringAsFixed(0)}',
                    style: TextStyle(color: color),
                  ),

                  Slider(
                    value: limit,
                    min: 0,
                    max: 10000,
                    divisions: 20,
                    label: limit.toStringAsFixed(0),
                    onChanged: (value) {
                      notifier.setLimit(type, value);
                    },
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
