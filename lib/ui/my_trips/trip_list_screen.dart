import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_ride/ui/widgets/trip_tile.dart';
import '../../core/constants/trip_status.dart';
import '../../state/trips/trip_provider.dart';

class TripListScreen extends ConsumerStatefulWidget {
  const TripListScreen({super.key});

  @override
  ConsumerState<TripListScreen> createState() => _TripListScreenState();
}

class _TripListScreenState extends ConsumerState<TripListScreen> {
  final Map<String, TripStatus> _lastStatuses = {};
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    ref.listen(tripProvider, (_, next) {

      // First provider emission → seed silently
      if (!_initialized) {
        for (final trip in next.trips) {
          _lastStatuses[trip.id] = trip.status;
        }
        _initialized = true;
        return;
      }

      // Real-time updates ONLY
      for (final trip in next.trips) {
        final lastStatus = _lastStatuses[trip.id];

        ///  CASE 1: Brand new trip → show "Requested"
        if (lastStatus == null && trip.status == TripStatus.requested) {
          _showSnack(context, trip.status);
        }

        ///  CASE 2: Existing trip → status changed
        if (lastStatus != null && lastStatus != trip.status) {
          _showSnack(context, trip.status);
        }

        _lastStatuses[trip.id] = trip.status;
      }
    });

    final trips = [...ref.watch(tripProvider).trips]
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));

    return Scaffold(
      appBar: AppBar(title: const Text('My Trips')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: trips.length,
        itemBuilder: (_, i) => TripTile(trip: trips[i]),
      ),
    );
  }

  void _showSnack(BuildContext context, TripStatus status) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Ride ${status.label}',
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.orange.shade300,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} • '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
  }

}
