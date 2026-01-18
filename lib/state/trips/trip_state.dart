import '../../models/trip.dart';

class TripState {
  final List<Trip> trips;

  const TripState({this.trips = const []});

  TripState copyWith({List<Trip>? trips}) {
    return TripState(trips: trips ?? this.trips);
  }
}
