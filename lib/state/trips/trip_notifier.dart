import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/trip.dart';
import 'trip_state.dart';

class TripNotifier extends StateNotifier<TripState> {
  TripNotifier() : super(const TripState());

  void addTrip(Trip trip) {
    state = state.copyWith(
      trips: [...state.trips, trip],
    );
  }

  void updateTrip(Trip updatedTrip) {
    state = state.copyWith(
      trips: state.trips
          .map((trip) =>
      trip.id == updatedTrip.id ? updatedTrip : trip)
          .toList(),
    );
  }

  void removeTrip(String id) {
    state = state.copyWith(
      trips: state.trips.where((t) => t.id != id).toList(),
    );
  }
}
