import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/dashboard/dashboard_provider.dart';
import '../widgets/recent_trip_tile.dart';
import '../widgets/summary_card.dart';
import '../widgets/trip_chart_placeholder.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Summary cards
            Row(
              children: [
                Expanded(
                  child: SummaryCard(
                    title: 'Total Trips',
                    value: dashboardState.totalTrips.toString(),
                    icon: Icons.directions_car,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SummaryCard(
                    title: 'Amount Spent',
                    value: '₹${dashboardState.totalSpent.toInt()}',
                    icon: Icons.currency_rupee,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Chart placeholder
            const TripChartPlaceholder(),

            const SizedBox(height: 24),

            /// Recent trips
            const Text(
              'Recent Trips',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            /// UI placeholder (will connect to Trips later)
            ...List.generate(5, (_) => const RecentTripTile()),
          ],
        ),
      ),
    );
  }
}
