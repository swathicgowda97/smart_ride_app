import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/ride_types.dart';
import '../../../core/constants/trip_status.dart';
import '../../data/hive/repositories/trip_repository.dart';
import '../../models/trip.dart';
import 'trip_state.dart';

class TripNotifier extends StateNotifier<TripState> {
  final TripRepository _repository;

  Timer? _driverTimer;

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

    // 🔥 start real-time simulation
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

  // DRIVER TRACKING (MOCK REAL-TIME)

  void _startDriverTracking({
    required String tripId,
    required int totalSeconds,
  }) {
    _driverTimer?.cancel();

    int remaining = totalSeconds;

    _driverTimer = Timer.periodic(
      const Duration(seconds: 2),
          (timer) {
        remaining -= 2;

        final trip = state.trips.firstWhere(
              (t) => t.id == tripId,
          orElse: () => throw Exception('Trip not found'),
        );

        if (remaining <= 0 ||
            trip.status == TripStatus.completed ||
            trip.status == TripStatus.cancelled) {
          timer.cancel();
          updateTrip(
            trip.copyWith(
              etaSeconds: 0,
              progress: 1.0,
            ),
          );
          return;
        }

        final progress = 1 - (remaining / totalSeconds);

        updateTrip(
          trip.copyWith(
            etaSeconds: remaining,
            progress: progress.clamp(0.0, 1.0),
          ),
        );
      },
    );
  }


// REAL-TIME STATUS SIMULATION (STATE-DRIVEN)

  void _simulateRideLifecycle(String tripId) async {
    Future<void> updateStatus(TripStatus status, Duration delay) async {
      await Future.delayed(delay);

      final trip = state.trips.firstWhere(
            (t) => t.id == tripId,
        orElse: () => throw Exception('Trip not found'),
      );

      // Stop if already finished
      if (trip.status == TripStatus.cancelled ||
          trip.status == TripStatus.completed) {
        return;
      }

      final updatedTrip = trip.copyWith(status: status);
      updateTrip(updatedTrip);

      // 🔗 HOOK DRIVER TRACKING TO STATUS
      if (status == TripStatus.driverAssigned) {
        _startDriverTracking(
          tripId: tripId,
          totalSeconds: 120, // driver approaching
        );
      }

      if (status == TripStatus.rideStarted) {
        _startDriverTracking(
          tripId: tripId,
          totalSeconds: 180, // ride in progress
        );
      }

      if (status == TripStatus.completed ||
          status == TripStatus.cancelled) {
        _driverTimer?.cancel();
      }
    }

    await updateStatus(
      TripStatus.driverAssigned,
      const Duration(seconds: 3),
    );

    await updateStatus(
      TripStatus.rideStarted,
      const Duration(seconds: 4),
    );

    await updateStatus(
      TripStatus.completed,
      const Duration(seconds: 6),
    );
  }

  @override
  void dispose() {
    _driverTimer?.cancel();
    super.dispose();
  }
}
