import 'package:flutter/material.dart';
import 'add_edit_trip_screen.dart';

class BookingHomeScreen extends StatelessWidget {
  final VoidCallback onTripBooked;

  const BookingHomeScreen({required this.onTripBooked});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book a Ride'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            /// Primary Action Card
            ActionCard(
              icon: Icons.add_circle_outline,
              title: 'Book New Trip',
              subtitle: 'Create a new ride booking',
              color: Colors.orange.shade50,
              onTap: () async {
                final success = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(builder: (_) => const AddEditTripScreen()),
                );

                if (success == true) {
                  onTripBooked();
                }
              },
            ),

            const SizedBox(height: 12),

            /// Secondary Action Cards
            Row(
              children: [
                Expanded(
                  child: SmallActionCard(
                    icon: Icons.history,
                    label: 'Repeat Trip',
                    color: Colors.blue.shade50,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SmallActionCard(
                    icon: Icons.schedule,
                    label: 'Schedule Ride',
                    color: Colors.green.shade50,
                    onTap: () {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// Tip Section
            const Text('Tip', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              'Use quick actions to save time when booking frequent rides.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(icon, size: 32, color: Colors.orange),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class SmallActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const SmallActionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color, // ✅ CARD COLOR FIXED
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28, color: Colors.black87),
              const SizedBox(height: 8),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
