import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/ride_types.dart';
import '../../../core/constants/trip_status.dart';
import '../../data/hive/repositories/trip_repository.dart';
import '../../models/trip.dart';
import 'trip_state.dart';

class TripNotifier extends StateNotifier<TripState> {
  final TripRepository _repository;

  TripNotifier(this._repository) : super(const TripState()) {
    _loadTrips();
  }

  // LOAD PERSISTED DATA

  Future<void> _loadTrips() async {
    final trips = await _repository.loadTrips();
    state = state.copyWith(trips: trips);
  }

  // FARE CALCULATION (UNCHANGED)

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

  // CRUD + PERSISTENCE

  void addTrip(Trip trip) {
    state = state.copyWith(trips: [...state.trips, trip]);
    _repository.saveTrip(trip);

    // start real-time simulation
    _simulateRideLifecycle(trip.id);
  }

  void updateTrip(Trip updatedTrip) {
    state = state.copyWith(
      trips: state.trips
          .map((t) => t.id == updatedTrip.id ? updatedTrip : t)
          .toList(),
    );

    _repository.saveTrip(updatedTrip);
  }

  void removeTrip(String id) {
    state = state.copyWith(
      trips: state.trips.where((t) => t.id != id).toList(),
    );

    _repository.deleteTrip(id);
  }

  // REAL-TIME STATUS SIMULATION

  void _simulateRideLifecycle(String tripId) async {
    Future<void> updateStatus(TripStatus status, Duration delay) async {
      await Future.delayed(delay);

      final trip = state.trips.firstWhere(
        (t) => t.id == tripId,
        orElse: () => throw Exception('Trip not found'),
      );

      // Prevent updating cancelled/completed trips
      if (trip.status == TripStatus.cancelled ||
          trip.status == TripStatus.completed)
        return;

      updateTrip(trip.copyWith(status: status));
    }

    await updateStatus(TripStatus.driverAssigned, const Duration(seconds: 3));

    await updateStatus(TripStatus.rideStarted, const Duration(seconds: 4));

    await updateStatus(TripStatus.completed, const Duration(seconds: 6));
  }
}
