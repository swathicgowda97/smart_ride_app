
import '../core/constants/ride_types.dart';
import '../core/constants/trip_status.dart';

class Trip {
  final String id;
  final String pickupLocation;
  final String dropLocation;
  final RideType rideType;
  final double fare;
  final DateTime dateTime;
  final TripStatus status;

  const Trip({
    required this.id,
    required this.pickupLocation,
    required this.dropLocation,
    required this.rideType,
    required this.fare,
    required this.dateTime,
    required this.status,
  });
}
