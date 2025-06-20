import 'package:flutter/foundation.dart';
import '../models/booking.dart';
import '../models/zone.dart';
import '../models/service.dart';
import '../services/data_service.dart';

class BookingProvider with ChangeNotifier {
  List<Booking> _bookings = [];
  Zone? _selectedZone;
  List<Service> _availableServices = [];

  List<Booking> get bookings => _bookings;
  Zone? get selectedZone => _selectedZone;
  List<Service> get availableServices => _availableServices;

  double get totalCost {
    return _bookings.fold(0.0, (sum, booking) => sum + booking.totalPrice);
  }

  Map<String, double> get zoneWiseSubtotals {
    Map<String, double> subtotals = {};
    for (var booking in _bookings) {
      subtotals[booking.zoneName] =
          (subtotals[booking.zoneName] ?? 0.0) + booking.totalPrice;
    }
    return subtotals;
  }

  void selectZone(Zone zone) {
    _selectedZone = zone;
    _availableServices = DataService.getServicesForZone(zone.id);
    notifyListeners();
  }

  void addBooking(Booking booking) {
    _bookings.add(booking);
    notifyListeners();
  }

  void removeBooking(String bookingId) {
    _bookings.removeWhere((booking) => booking.id == bookingId);
    notifyListeners();
  }

  void updateBooking(Booking updatedBooking) {
    final index = _bookings.indexWhere(
      (booking) => booking.id == updatedBooking.id,
    );
    if (index != -1) {
      _bookings[index] = updatedBooking;
      notifyListeners();
    }
  }

  void clearBookings() {
    _bookings.clear();
    notifyListeners();
  }

  List<Booking> getBookingsForZone(String zoneId) {
    return _bookings.where((booking) => booking.zoneId == zoneId).toList();
  }
}
