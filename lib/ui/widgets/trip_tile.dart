import 'package:flutter/material.dart';
import '../../../../core/constants/ride_types.dart';
import '../../../../core/constants/trip_status.dart';
import '../../models/trip.dart';
import 'driver_tracking_widget.dart';

class TripTile extends StatelessWidget {
  final Trip trip;

  const TripTile({
    super.key,
    required this.trip,
  });

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

  String _formatDateTime(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} • '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange.shade50,
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              _rideIcon(trip.rideType),
              color: Colors.orange.shade700,
            ),
            title: Text('${trip.pickupLocation} → ${trip.dropLocation}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${trip.rideType.label} • ₹${trip.fare.toInt()}'),
                const SizedBox(height: 4),
                Text(
                  _formatDateTime(trip.dateTime),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            trailing: Text(
              trip.status.label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _statusColor(trip.status),
              ),
            ),
          ),

          /// DRIVER TRACKING (VISIBLE ILLUSION)
          if (trip.status == TripStatus.driverAssigned ||
              trip.status == TripStatus.rideStarted)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: DriverTrackingWidget(
                etaSeconds: trip.etaSeconds,
                progress: trip.progress,
              ),
            ),
        ],
      ),
    );
  }
}
