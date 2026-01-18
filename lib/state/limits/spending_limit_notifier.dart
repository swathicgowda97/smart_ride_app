import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/ride_types.dart';
import '../../core/constants/trip_status.dart';
import '../trips/trip_provider.dart';
import 'spending_limit_state.dart';

final spendingLimitProvider =
StateNotifierProvider<SpendingLimitNotifier, SpendingLimitState>(
      (ref) => SpendingLimitNotifier(ref),
);

class SpendingLimitNotifier extends StateNotifier<SpendingLimitState> {
  final Ref ref;

  SpendingLimitNotifier(this.ref)
      : super(SpendingLimitState.initial());

  void setLimit(RideType type, double amount) {
    state = state.copyWith(
      limits: {
        ...state.limits,
        type: amount,
      },
    );
  }

  /// Derived real-time spending
  double spentFor(RideType type) {
    final trips = ref.read(tripProvider).trips;

    return trips
        .where(
          (t) =>
      t.rideType == type &&
          t.status.isCompleted,
    )
        .fold(0.0, (sum, t) => sum + t.fare);
  }
}
