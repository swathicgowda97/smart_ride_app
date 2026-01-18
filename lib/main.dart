import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'core/constants/ride_types.dart';
import 'core/constants/trip_status.dart';
import 'data/hive/spending_limit_hive_model.dart';
import 'data/hive/trip_hive_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TripHiveModelAdapter());
  Hive.registerAdapter(RideTypeAdapter());
  Hive.registerAdapter(TripStatusAdapter());
  Hive.registerAdapter(SpendingLimitHiveModelAdapter());


  runApp(const ProviderScope(child: SmartRideApp()));
}