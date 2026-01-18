import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/ride_types.dart';

class TripChart extends StatelessWidget {
  final Map<RideType, int> tripCounts;

  const TripChart({
    super.key,
    required this.tripCounts,
  });

  Color _color(RideType type) {
    switch (type) {
      case RideType.mini:
        return Colors.orange;
      case RideType.sedan:
        return Colors.blue;
      case RideType.auto:
        return Colors.green;
      case RideType.bike:
        return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = tripCounts.values.fold(0, (a, b) => a + b);

    if (total == 0) {
      return const Center(
        child: Text('No completed trips yet'),
      );
    }

    return AspectRatio(
      aspectRatio: 1.3,
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          sections: RideType.values.map((type) {
            final count = tripCounts[type] ?? 0;
            if (count == 0) return PieChartSectionData(value: 0);

            return PieChartSectionData(
              value: count.toDouble(),
              title: '${type.label}\n$count',
              color: _color(type),
              radius: 60,
              titleStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
