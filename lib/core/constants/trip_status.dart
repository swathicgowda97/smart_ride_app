enum TripStatus {
  requested,
  driverAssigned,
  rideStarted,
  completed,
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

  bool get isCompleted => this == TripStatus.completed;
}
