import '../../../core/constants/ride_types.dart';

class SpendingLimitState {
  final Map<RideType, double> limits;

  const SpendingLimitState({
    required this.limits,
  });

  factory SpendingLimitState.initial() {
    return SpendingLimitState(
      limits: {
        for (final type in RideType.values) type: 0,
      },
    );
  }

  SpendingLimitState copyWith({
    Map<RideType, double>? limits,
  }) {
    return SpendingLimitState(
      limits: limits ?? this.limits,
    );
  }
}
