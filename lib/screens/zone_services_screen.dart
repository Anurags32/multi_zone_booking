import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/zone.dart';
import '../providers/booking_provider.dart';
import '../widgets/service_card.dart';
import 'service_detail_screen.dart';

class ZoneServicesScreen extends StatelessWidget {
  final Zone zone;

  const ZoneServicesScreen({super.key, required this.zone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        title: Text('${zone.name} Services'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Consumer<BookingProvider>(
        builder: (context, bookingProvider, child) {
          final services = bookingProvider.availableServices;

          if (services.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No services available in this zone',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildZoneHeader(context, zone, services.length),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ServiceCard(
                        service: service,
                        zoneId: zone.id,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceDetailScreen(
                                service: service,
                                zone: zone,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildZoneHeader(BuildContext context, Zone zone, int serviceCount) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Icon(
              //   _getZoneIcon(zone.name),
              //   color: Theme.of(context).colorScheme.primary,
              //   size: 28,
              // ),
              // const SizedBox(width: 10),
              Text(
                zone.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            zone.description,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.black87),
          ),
          const SizedBox(height: 6),
          Text(
            '$serviceCount services available',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  IconData _getZoneIcon(String zoneName) {
    switch (zoneName.toLowerCase()) {
      case 'north zone':
        return Icons.north;
      case 'south zone':
        return Icons.south;
      case 'east zone':
        return Icons.east;
      case 'west zone':
        return Icons.west;
      default:
        return Icons.location_on;
    }
  }
}
