import 'package:flutter/material.dart';
import '../../../../core/constants/trip_status.dart';
import '../../../../core/constants/ride_types.dart';
import '../../models/trip.dart';

class TripTile extends StatelessWidget {
  final Trip trip;

  const TripTile({super.key, required this.trip});

  IconData _rideIcon(RideType type) {
    switch (type) {
      case RideType.mini:
        return Icons.directions_car;
      case RideType.sedan:
        return Icons.local_taxi;
      case RideType.auto:
        return Icons.electric_rickshaw;
      case RideType.bike:
        return Icons.two_wheeler;
    }
  }

  Color _statusColor(TripStatus status) {
    switch (status) {
      case TripStatus.requested:
        return Colors.orange;
      case TripStatus.completed:
        return Colors.green;
      default:
        return Colors.blueAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange.shade50,
      child: ListTile(
        leading: Icon(
          _rideIcon(trip.rideType),
          color: Colors.orange.shade700,
        ),
        title: Text('${trip.pickupLocation} → ${trip.dropLocation}'),
        subtitle: Text('${trip.rideType.label} • ₹${trip.fare.toInt()}'),
        trailing: Text(
          trip.status.label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _statusColor(trip.status),
          ),
        ),
      ),
    );
  }
}
