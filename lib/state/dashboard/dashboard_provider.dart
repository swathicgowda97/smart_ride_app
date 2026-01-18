import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dashboard_state.dart';

final dashboardProvider =
StateProvider<DashboardState>((ref) {
  return const DashboardState();
});
