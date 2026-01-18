import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/ride_types.dart';
import '../../core/constants/trip_status.dart';
import '../../data/hive/repositories/spending_limit_repository.dart';
import '../trips/trip_provider.dart';
import 'spending_limit_state.dart';

final spendingLimitProvider =
StateNotifierProvider<SpendingLimitNotifier, SpendingLimitState>(
      (ref) => SpendingLimitNotifier(ref,SpendingLimitRepository(),),
);

class SpendingLimitNotifier extends StateNotifier<SpendingLimitState> {
  final Ref ref;
  final SpendingLimitRepository _repository;

  SpendingLimitNotifier(this.ref, this._repository)
      : super(SpendingLimitState.initial()) {
    _loadLimits();
  }

  Future<void> _loadLimits() async {
    final limits = await _repository.loadLimits();
    state = state.copyWith(limits: limits);
  }



  void setLimit(RideType type, double amount) {
    state = state.copyWith(
      limits: {
        ...state.limits,
        type: amount,
      },
    );

    _repository.saveLimit(type, amount);
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
