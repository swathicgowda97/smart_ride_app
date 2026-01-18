import 'package:flutter/material.dart';
import 'package:smart_ride/ui/trips/booking_home_screen.dart';
import 'package:smart_ride/ui/my_trips/trip_list_screen.dart';
import 'dashboard/dashboard_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      const DashboardScreen(),

      /// Booking tab
      BookHomeScreen(
        onTripBooked: () {
          setState(() {
            _currentIndex = 2;
          });
        },
      ),

      const TripListScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_taxi),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'My Trips',
          ),
        ],
      ),
    );
  }
}
