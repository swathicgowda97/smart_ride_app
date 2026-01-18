import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_ride/ui/widgets/trip_tile.dart';
import '../../state/trips/trip_provider.dart';

class TripListScreen extends ConsumerWidget {
  const TripListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trips = ref.watch(tripProvider).trips;

    return Scaffold(
      appBar: AppBar(title: const Text('My Trips')),

      body: trips.isEmpty
          ? const Center(child: Text('No trips yet'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: trips.length,
        itemBuilder: (_, i) => TripTile(trip: trips[i]),
      ),
    );
  }
}
