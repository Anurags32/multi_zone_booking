import '../models/zone.dart';
import '../models/service.dart';

class DataService {
  static final List<Zone> _zones = [
    Zone(
      id: 'north',
      name: 'North Zone',
      description: 'Premium services in the northern district',
      imageUrl: 'assets/images/north_zone.jpg',
    ),
    Zone(
      id: 'south',
      name: 'South Zone',
      description: 'Affordable services in the southern district',
      imageUrl: 'assets/images/south_zone.jpg',
    ),
    Zone(
      id: 'east',
      name: 'East Zone',
      description: 'Modern services in the eastern district',
      imageUrl: 'assets/images/east_zone.jpg',
    ),
    Zone(
      id: 'west',
      name: 'West Zone',
      description: 'Traditional services in the western district',
      imageUrl: 'assets/images/west_zone.jpg',
    ),
  ];

  static final List<Service> _services = [
    Service(
      id: 'cleaning',
      name: 'Home Cleaning',
      description:
          'Professional home cleaning service with eco-friendly products',
      imageUrl: 'assets/images/cleaning.jpg',
      zoneIds: ['north', 'south', 'east', 'west'],
      zonePricing: {'north': 120.0, 'south': 80.0, 'east': 100.0, 'west': 90.0},
      availableOnWeekends: true,
      durationMinutes: 120,
      availableTimeSlots: ['09:00', '11:00', '13:00', '15:00', '17:00'],
    ),
    Service(
      id: 'plumbing',
      name: 'Plumbing Service',
      description: 'Expert plumbing repair and maintenance services',
      imageUrl: 'assets/images/plumbing.jpg',
      zoneIds: ['north', 'east', 'west'],
      zonePricing: {'north': 150.0, 'east': 120.0, 'west': 110.0},
      availableOnWeekends: false,
      durationMinutes: 90,
      availableTimeSlots: ['08:00', '10:00', '12:00', '14:00', '16:00'],
    ),
    Service(
      id: 'electrical',
      name: 'Electrical Work',
      description: 'Licensed electrical installation and repair services',
      imageUrl: 'assets/images/electrical.jpg',
      zoneIds: ['north', 'south', 'east'],
      zonePricing: {'north': 180.0, 'south': 140.0, 'east': 160.0},
      availableOnWeekends: false,
      durationMinutes: 120,
      availableTimeSlots: ['08:00', '10:00', '12:00', '14:00'],
    ),
    Service(
      id: 'gardening',
      name: 'Garden Maintenance',
      description: 'Complete garden care and landscaping services',
      imageUrl: 'assets/images/gardening.jpg',
      zoneIds: ['south', 'west'],
      zonePricing: {'south': 95.0, 'west': 85.0},
      availableOnWeekends: true,
      durationMinutes: 180,
      availableTimeSlots: ['07:00', '09:00', '11:00', '13:00', '15:00'],
    ),
    Service(
      id: 'painting',
      name: 'Interior Painting',
      description: 'Professional interior and exterior painting services',
      imageUrl: 'assets/images/painting.jpg',
      zoneIds: ['north', 'east'],
      zonePricing: {'north': 200.0, 'east': 170.0},
      availableOnWeekends: true,
      durationMinutes: 240,
      availableTimeSlots: ['08:00', '10:00', '12:00'],
    ),
    Service(
      id: 'carpentry',
      name: 'Carpentry Work',
      description: 'Custom woodwork and furniture repair services',
      imageUrl: 'assets/images/carpentry.jpg',
      zoneIds: ['west', 'south'],
      zonePricing: {'west': 130.0, 'south': 110.0},
      availableOnWeekends: false,
      durationMinutes: 150,
      availableTimeSlots: ['09:00', '11:00', '13:00', '15:00'],
    ),
  ];

  static List<Zone> getZones() {
    return _zones;
  }

  static List<Service> getServices() {
    return _services;
  }

  static List<Service> getServicesForZone(String zoneId) {
    return _services
        .where((service) => service.isAvailableInZone(zoneId))
        .toList();
  }

  static Service? getServiceById(String serviceId) {
    try {
      return _services.firstWhere((service) => service.id == serviceId);
    } catch (e) {
      return null;
    }
  }

  static Zone? getZoneById(String zoneId) {
    try {
      return _zones.firstWhere((zone) => zone.id == zoneId);
    } catch (e) {
      return null;
    }
  }
}
