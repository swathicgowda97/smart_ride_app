import 'package:flutter/material.dart';
import 'package:smart_ride/ui/dashboard/dashboard_screen.dart';

class SmartRideApp extends StatelessWidget {
  const SmartRideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Ride',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const DashboardScreen(),
    );
  }
}
