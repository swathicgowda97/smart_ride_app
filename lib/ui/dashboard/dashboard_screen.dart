import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/trips/trip_provider.dart';
import '../widgets/recent_trip_tile.dart';
import '../widgets/summary_card.dart';
import '../widgets/trip_chart_placeholder.dart';
import '../../../core/constants/trip_status.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trips = ref.watch(tripProvider).trips;

    final completedTrips =
    trips.where((t) => t.status == TripStatus.completed).toList();

    final totalSpent =
    completedTrips.fold(0.0, (sum, t) => sum + t.fare);

    final recentTrips =
    trips.reversed.take(5).toList();

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
                    value: trips.length.toString(),
                    icon: Icons.directions_car,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SummaryCard(
                    title: 'Amount Spent',
                    value: '₹${totalSpent.toInt()}',
                    icon: Icons.currency_rupee,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Chart placeholder (next step)
            const TripChartPlaceholder(),

            const SizedBox(height: 24),

            /// Recent trips
            const Text(
              'Recent Trips',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            if (recentTrips.isEmpty)
              const Text('No trips yet'),

            ...recentTrips.map(
                  (trip) => RecentTripTile(trip: trip),
            ),
          ],
        ),
      ),
    );
  }
}
