import 'package:flutter/material.dart';
import '../../../../core/constants/trip_status.dart';
import '../../core/constants/ride_types.dart';
import '../../models/trip.dart';

class TripTile extends StatelessWidget {
  final Trip trip;

  const TripTile({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange.shade50,
      child: ListTile(
        leading: const Icon(Icons.local_taxi),
        title: Text('${trip.pickupLocation} → ${trip.dropLocation}'),
        subtitle: Text('${trip.rideType.label} • ₹${trip.fare.toInt()}'),
        trailing: Text(
          trip.status.label,
          style: TextStyle(
            color: trip.status == TripStatus.completed
                ? Colors.green
                : Colors.orange,
          ),
        ),
      ),
    );
  }
}
