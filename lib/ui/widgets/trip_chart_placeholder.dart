import 'package:flutter/material.dart';

class TripChartPlaceholder extends StatelessWidget {
  const TripChartPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 180,
        child: Center(
          child: Text(
            'Trip Distribution Chart\n(Coming Soon)',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
      ),
    );
  }
}
