import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';
import '../services/data_service.dart';
import '../widgets/zone_card.dart';
import 'zone_services_screen.dart';
import 'my_bookings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Zone Service Booking'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyBookingsScreen(),
                ),
              );
            },
            tooltip: 'My Bookings',
          ),
        ],
      ),
      body: Column(
        children: [
          // Header section
          Container(
            // padding: const EdgeInsets.all(20),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose Your Zone',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  'Select a zone to view available services and pricing',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          // Zones grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: DataService.getZones().length,
              itemBuilder: (context, index) {
                final zone = DataService.getZones()[index];
                return ZoneCard(
                  zone: zone,
                  onTap: () {
                    context.read<BookingProvider>().selectZone(zone);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ZoneServicesScreen(zone: zone),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
