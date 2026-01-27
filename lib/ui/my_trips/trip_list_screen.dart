import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_ride/ui/widgets/trip_tile.dart';
import '../../core/constants/trip_status.dart';
import '../../state/trips/trip_provider.dart';
import '../../models/trip.dart';

class TripListScreen extends ConsumerStatefulWidget {
  const TripListScreen({super.key});

  @override
  ConsumerState<TripListScreen> createState() => _TripListScreenState();
}

class _TripListScreenState extends ConsumerState<TripListScreen> {
  final Map<String, TripStatus> _lastStatuses = {};
  bool _initialized = false;

  Trip? _recentlyDeletedTrip;

  @override
  Widget build(BuildContext context) {
    ref.listen(tripProvider, (_, next) {
      // Seed initial statuses silently
      if (!_initialized) {
        for (final trip in next.trips) {
          _lastStatuses[trip.id] = trip.status;
        }
        _initialized = true;
        return;
      }

      // Real-time status notifications
      for (final trip in next.trips) {
        final lastStatus = _lastStatuses[trip.id];

        if (lastStatus == null && trip.status == TripStatus.requested) {
          _showSnack(context, trip.status);
        }

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
        itemBuilder: (_, i) {
          final trip = trips[i];

          return Dismissible(
            key: ValueKey(trip.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.red.shade400,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (_) {
              _recentlyDeletedTrip = trip;

              ref.read(tripProvider.notifier).removeTrip(trip.id);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Trip deleted',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.orange.shade300,
                  duration: const Duration(seconds: 4),
                  action: SnackBarAction(
                    label: 'UNDO',
                    textColor: Colors.black,
                    onPressed: () {
                      if (_recentlyDeletedTrip != null) {
                        ref
                            .read(tripProvider.notifier)
                            .addTrip(_recentlyDeletedTrip!);
                        _recentlyDeletedTrip = null;
                      }
                    },
                  ),
                ),
              );
            },
            child: TripTile(trip: trip),
          );
        },
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
}
