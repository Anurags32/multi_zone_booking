# Multi-Zone Service Booking App (MZSB)

A Flutter application that allows users to view services available in their local zone, select services, and book appointments with dynamic pricing and availability rules.

## Features

### 🔹 1. Zone-Based Service Rendering
- Display of service zones (North Zone, South Zone, East Zone, West Zone)
- Dynamic filtering of services based on selected zone
- Services can belong to multiple zones
- Smart zone-service relationship modeling

### 🔹 2. Service Detail + Booking Screen
- Comprehensive service information display
- Zone-specific pricing (varies by zone)
- Date and time slot selection
- Quantity selection
- Weekend availability rules (configurable per service)
- Add to "My Bookings" functionality

### 🔹 3. "My Bookings" Section
- View all added bookings
- Modify booking details (edit functionality)
- Remove bookings
- Total cost calculation
- Zone-wise subtotal breakdown

## Technical Implementation

### Architecture
- **State Management**: Provider pattern for app-wide state
- **Models**: Zone, Service, and Booking data models
- **Services**: Data service with mock data
- **Screens**: Home, Zone Services, Service Detail, My Bookings
- **Widgets**: Reusable UI components

### Key Features
- **Dynamic Pricing**: Services have different prices per zone
- **Availability Rules**: Some services are not available on weekends
- **Date/Time Selection**: Smart date picker with availability constraints
- **Quantity Management**: Users can select multiple quantities
- **Zone-wise Analytics**: Cost breakdown by zone

### Data Structure
```dart
// Zone-Service Relationship
Service {
  zoneIds: ['north', 'south', 'east', 'west']
  zonePricing: {
    'north': 120.0,
    'south': 80.0,
    'east': 100.0,
    'west': 90.0
  }
  availableOnWeekends: true/false
}
```

## Getting Started

### Prerequisites
- Flutter SDK (3.8.0 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd multi_zone
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## App Structure

```
lib/
├── models/
│   ├── zone.dart
│   ├── service.dart
│   └── booking.dart
├── providers/
│   └── booking_provider.dart
├── services/
│   └── data_service.dart
├── screens/
│   ├── home_screen.dart
│   ├── zone_services_screen.dart
│   ├── service_detail_screen.dart
│   └── my_bookings_screen.dart
├── widgets/
│   ├── zone_card.dart
│   ├── service_card.dart
│   └── booking_card.dart
└── main.dart
```

## Mock Data

The app includes comprehensive mock data with:
- 4 zones (North, South, East, West)
- 6 services (Cleaning, Plumbing, Electrical, Gardening, Painting, Carpentry)
- Zone-specific pricing
- Availability rules
- Time slots

## Features Demonstrated

1. **Dynamic Filtering**: Services are filtered based on selected zone
2. **Conditional Logic**: Weekend availability rules per service
3. **State Management**: Provider pattern for booking management
4. **Data Modeling**: Smart zone-service relationships
5. **UI/UX**: Modern Material Design 3 interface
6. **Validation**: Date selection with availability constraints

## Future Enhancements

- Real API integration
- User authentication
- Payment processing
- Push notifications
- Service provider profiles
- Rating and reviews system
