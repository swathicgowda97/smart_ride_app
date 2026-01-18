import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/ride_types.dart';
import '../../models/trip.dart';
import 'trip_state.dart';

class TripNotifier extends StateNotifier<TripState> {
  TripNotifier() : super(const TripState());

  double calculateFare({
    required String pickup,
    required String drop,
    required RideType rideType,
  }) {
    if (pickup.isEmpty || drop.isEmpty) return 0;

    final distance = (pickup.length - drop.length).abs() + 5;

    return distance * _ratePerKm(rideType);
  }

  double _ratePerKm(RideType type) {
    switch (type) {
      case RideType.mini:
        return 10;
      case RideType.sedan:
        return 14;
      case RideType.auto:
        return 8;
      case RideType.bike:
        return 6;
    }
  }

  void addTrip(Trip trip) {
    state = state.copyWith(trips: [...state.trips, trip]);
  }

  void updateTrip(Trip updatedTrip) {
    state = state.copyWith(
      trips: state.trips
          .map((trip) => trip.id == updatedTrip.id ? updatedTrip : trip)
          .toList(),
    );
  }

  void removeTrip(String id) {
    state = state.copyWith(
      trips: state.trips.where((t) => t.id != id).toList(),
    );
  }
}
