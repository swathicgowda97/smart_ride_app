import 'package:hive/hive.dart';

part 'trip_status.g.dart';

@HiveType(typeId: 2)
enum TripStatus {
  @HiveField(0)
  requested,

  @HiveField(1)
  driverAssigned,

  @HiveField(2)
  rideStarted,

  @HiveField(3)
  completed,

  @HiveField(4)
  cancelled,
}

extension TripStatusX on TripStatus {
  String get label {
    switch (this) {
      case TripStatus.requested:
        return 'Requested';
      case TripStatus.driverAssigned:
        return 'Driver Assigned';
      case TripStatus.rideStarted:
        return 'Ride Started';
      case TripStatus.completed:
        return 'Completed';
      case TripStatus.cancelled:
        return 'Cancelled';
    }
  }

  /// ADD THIS
  bool get isCompleted => this == TripStatus.completed;
}
