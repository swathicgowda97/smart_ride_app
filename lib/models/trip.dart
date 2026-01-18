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

  Trip copyWith({
    String? id,
    String? pickupLocation,
    String? dropLocation,
    RideType? rideType,
    double? fare,
    DateTime? dateTime,
    TripStatus? status,
  }) {
    return Trip(
      id: id ?? this.id,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      dropLocation: dropLocation ?? this.dropLocation,
      rideType: rideType ?? this.rideType,
      fare: fare ?? this.fare,
      dateTime: dateTime ?? this.dateTime,
      status: status ?? this.status,
    );
  }
}
