import 'package:flutter/material.dart';
import 'package:smart_ride/ui/trips/trip_tile.dart';
import '../../../core/constants/ride_types.dart';
import '../../../core/constants/trip_status.dart';
import '../../models/trip.dart';
import 'add_edit_trip_screen.dart';

class TripListScreen extends StatelessWidget {
  const TripListScreen({super.key});

  List<Trip> get mockTrips => [
    Trip(
      id: '1',
      pickupLocation: 'BTM Layout',
      dropLocation: 'Whitefield',
      rideType: RideType.sedan,
      fare: 420,
      dateTime: DateTime.now(),
      status: TripStatus.completed,
    ),
    Trip(
      id: '2',
      pickupLocation: 'Indiranagar',
      dropLocation: 'MG Road',
      rideType: RideType.mini,
      fare: 180,
      dateTime: DateTime.now(),
      status: TripStatus.rideStarted,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Trips')),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockTrips.length,
        itemBuilder: (_, i) => TripTile(trip: mockTrips[i]),
      ),
    );
  }
}
