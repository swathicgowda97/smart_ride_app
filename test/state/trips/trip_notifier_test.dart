import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:smart_ride/core/constants/ride_types.dart';
import 'package:smart_ride/core/constants/trip_status.dart';
import 'package:smart_ride/state/trips/trip_notifier.dart';
import 'package:smart_ride/state/trips/trip_state.dart';
import 'package:smart_ride/models/trip.dart';
import 'package:smart_ride/data/hive/repositories/trip_repository.dart';

/// ------------------------------
/// Fake Repository (in-memory)
/// ------------------------------
class FakeTripRepository implements TripRepository {
  final List<Trip> _storage = [];

  @override
  Future<List<Trip>> loadTrips() async {
    return _storage;
  }

  @override
  Future<void> saveTrip(Trip trip) async {
    _storage.removeWhere((t) => t.id == trip.id);
    _storage.add(trip);
  }

  @override
  Future<void> deleteTrip(String id) async {
    _storage.removeWhere((t) => t.id == id);
  }
}

void main() {
  late TripNotifier notifier;
  late FakeTripRepository repository;

  setUp(() {
    repository = FakeTripRepository();
    notifier = TripNotifier(repository);
  });

  test('addTrip should add a trip to state', () async {
    final trip = Trip(
      id: '1',
      pickupLocation: 'A',
      dropLocation: 'B',
      rideType: RideType.mini,
      fare: 100,
      dateTime: DateTime.now(),
      status: TripStatus.requested,
    );

    notifier.addTrip(trip);

    expect(notifier.state.trips.length, 1);
    expect(notifier.state.trips.first.id, '1');
  });

  test('removeTrip should remove trip from state', () async {
    final trip = Trip(
      id: '2',
      pickupLocation: 'A',
      dropLocation: 'B',
      rideType: RideType.auto,
      fare: 80,
      dateTime: DateTime.now(),
      status: TripStatus.requested,
    );

    notifier.addTrip(trip);
    notifier.removeTrip(trip.id);

    expect(notifier.state.trips.isEmpty, true);
  });

  test('calculateFare returns correct fare for ride type', () {
    final fare = notifier.calculateFare(
      pickup: 'BTM',
      drop: 'Whitefield',
      rideType: RideType.sedan,
    );

    expect(fare > 0, true);
  });

  test('ride lifecycle transitions to completed', () async {
    final trip = Trip(
      id: '3',
      pickupLocation: 'A',
      dropLocation: 'B',
      rideType: RideType.mini,
      fare: 120,
      dateTime: DateTime.now(),
      status: TripStatus.requested,
    );

    notifier.addTrip(trip);

    // Wait long enough for lifecycle to complete
    await Future.delayed(const Duration(seconds: 15));

    final updatedTrip =
    notifier.state.trips.firstWhere((t) => t.id == trip.id);

    expect(updatedTrip.status, TripStatus.completed);
  });
}
