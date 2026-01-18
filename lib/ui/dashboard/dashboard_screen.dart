import 'package:flutter/material.dart';
import '../widgets/recent_trip_tile.dart';
import '../widgets/summary_card.dart';
import '../widgets/trip_chart_placeholder.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Summary cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Expanded(
                  child: SummaryCard(
                    title: 'Total Trips',
                    value: '24',
                    icon: Icons.directions_car,
                  ),
                ),
                SizedBox(width: 2),
                Expanded(
                  child: SummaryCard(
                    title: 'Amount Spent',
                    value: '₹4,560',
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

            ...List.generate(5, (index) => const RecentTripTile()),
          ],
        ),
      ),
    );
  }
}
