import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/hive/repositories/trip_repository.dart';
import 'trip_notifier.dart';
import 'trip_state.dart';

final tripProvider =
StateNotifierProvider<TripNotifier, TripState>((ref) {
  return TripNotifier(TripRepository());
});
