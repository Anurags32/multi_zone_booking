import 'package:uuid/uuid.dart';

class Booking {
  final String id;
  final String serviceId;
  final String serviceName;
  final String zoneId;
  final String zoneName;
  final DateTime date;
  final String timeSlot;
  final int quantity;
  final double totalPrice;
  final DateTime createdAt;

  Booking({
    String? id,
    required this.serviceId,
    required this.serviceName,
    required this.zoneId,
    required this.zoneName,
    required this.date,
    required this.timeSlot,
    required this.quantity,
    required this.totalPrice,
    DateTime? createdAt,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now();

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      serviceId: json['serviceId'],
      serviceName: json['serviceName'],
      zoneId: json['zoneId'],
      zoneName: json['zoneName'],
      date: DateTime.parse(json['date']),
      timeSlot: json['timeSlot'],
      quantity: json['quantity'],
      totalPrice: json['totalPrice'].toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'zoneId': zoneId,
      'zoneName': zoneName,
      'date': date.toIso8601String(),
      'timeSlot': timeSlot,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Booking copyWith({
    String? id,
    String? serviceId,
    String? serviceName,
    String? zoneId,
    String? zoneName,
    DateTime? date,
    String? timeSlot,
    int? quantity,
    double? totalPrice,
    DateTime? createdAt,
  }) {
    return Booking(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      zoneId: zoneId ?? this.zoneId,
      zoneName: zoneName ?? this.zoneName,
      date: date ?? this.date,
      timeSlot: timeSlot ?? this.timeSlot,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
