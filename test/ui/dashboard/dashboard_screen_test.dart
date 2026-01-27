import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_ride/ui/dashboard/dashboard_screen.dart';
import 'package:smart_ride/state/trips/trip_provider.dart';
import 'package:smart_ride/state/trips/trip_notifier.dart';
import 'package:smart_ride/models/trip.dart';
import 'package:smart_ride/core/constants/ride_types.dart';
import 'package:smart_ride/core/constants/trip_status.dart';

import '../../mocks/mocks.dart';

void main() {
  testWidgets(
    'Dashboard shows correct total trips and amount spent',
        (tester) async {
      // Arrange
      final mockTrips = [
        Trip(
          id: '1',
          pickupLocation: 'A',
          dropLocation: 'B',
          rideType: RideType.mini,
          fare: 100,
          dateTime: DateTime.now(),
          status: TripStatus.completed,
        ),
        Trip(
          id: '2',
          pickupLocation: 'C',
          dropLocation: 'D',
          rideType: RideType.sedan,
          fare: 200,
          dateTime: DateTime.now(),
          status: TripStatus.completed,
        ),
        Trip(
          id: '3',
          pickupLocation: 'E',
          dropLocation: 'F',
          rideType: RideType.bike,
          fare: 50,
          dateTime: DateTime.now(),
          status: TripStatus.rideStarted, // ❌ not counted
        ),
      ];

      final fakeRepository = FakeTripRepository(mockTrips);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            tripProvider.overrideWith(
                  (ref) => TripNotifier(fakeRepository),
            ),
          ],
          child: const MaterialApp(
            home: DashboardScreen(),
          ),
        ),
      );

      // Allow async loadTrips()
      await tester.pumpAndSettle();

      // Assert – Total Trips (only completed)
      expect(find.text('2'), findsOneWidget);

      // Assert – Total Amount
      expect(find.text('₹300'), findsOneWidget);

      // Assert – Recent Trips section visible
      expect(find.text('Recent Trips'), findsOneWidget);
    },
  );
}
