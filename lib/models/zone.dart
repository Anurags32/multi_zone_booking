class Zone {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  Zone({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
