import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/ride_types.dart';
import '../../../../core/constants/trip_status.dart';
import '../../state/trips/trip_provider.dart';
import '../limits/spending_limit_screen.dart';
import '../widgets/trip_tile.dart';
import '../widgets/spending_limit_card.dart';
import '../widgets/summary_card.dart';
import '../widgets/trip_chart.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trips = ref.watch(tripProvider).trips;

    final completedTrips = trips
        .where((t) => t.status == TripStatus.completed)
        .toList()
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));


    final totalAmount = completedTrips.fold<double>(
      0,
          (sum, t) => sum + t.fare,
    );

    final tripCounts = <RideType, int>{
      for (final type in RideType.values)
        type: completedTrips.where((t) => t.rideType == type).length
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Summary Cards
            Row(
              children: [
                Expanded(
                  child: SummaryCard(
                    title: 'Total Trips',
                    value: completedTrips.length.toString(),
                    icon: Icons.directions_car,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SummaryCard(
                    title: 'Amount Spent',
                    value: '₹${totalAmount.toStringAsFixed(0)}',
                    icon: Icons.currency_rupee,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            SpendingLimitCard(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SpendingLimitScreen(),
                  ),
                );
              },
            ),


            const SizedBox(height: 24),

            /// Chart
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TripChart(tripCounts: tripCounts),
              ),
            ),

            const SizedBox(height: 24),

            /// Recent Trips
            const Text(
              'Recent Trips',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ...completedTrips
                .take(5)
                .map((trip) => TripTile(trip: trip))
                .toList(),
          ],
        ),
      ),
    );
  }
}
