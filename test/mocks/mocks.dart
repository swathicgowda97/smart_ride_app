import 'package:smart_ride/data/hive/repositories/trip_repository.dart';
import 'package:smart_ride/models/trip.dart';

class FakeTripRepository implements TripRepository {
  final List<Trip> trips;

  FakeTripRepository(this.trips);

  @override
  Future<List<Trip>> loadTrips() async => trips;

  @override
  Future<void> saveTrip(Trip trip) async {}

  @override
  Future<void> deleteTrip(String id) async {}
}
