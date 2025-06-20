class Service {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<String> zoneIds;
  final Map<String, double> zonePricing; // zoneId -> price
  final bool availableOnWeekends;
  final int durationMinutes;
  final List<String> availableTimeSlots;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.zoneIds,
    required this.zonePricing,
    required this.availableOnWeekends,
    required this.durationMinutes,
    required this.availableTimeSlots,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      zoneIds: List<String>.from(json['zoneIds']),
      zonePricing: Map<String, double>.from(json['zonePricing']),
      availableOnWeekends: json['availableOnWeekends'],
      durationMinutes: json['durationMinutes'],
      availableTimeSlots: List<String>.from(json['availableTimeSlots']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'zoneIds': zoneIds,
      'zonePricing': zonePricing,
      'availableOnWeekends': availableOnWeekends,
      'durationMinutes': durationMinutes,
      'availableTimeSlots': availableTimeSlots,
    };
  }

  double getPriceForZone(String zoneId) {
    return zonePricing[zoneId] ?? 0.0;
  }

  bool isAvailableInZone(String zoneId) {
    return zoneIds.contains(zoneId);
  }
}
