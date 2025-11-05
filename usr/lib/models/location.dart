class Location {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final bool isBlocked;
  final String restaurantId;

  Location({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.isBlocked = false,
    required this.restaurantId,
  });

  Location copyWith({
    String? id,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    bool? isBlocked,
    String? restaurantId,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isBlocked: isBlocked ?? this.isBlocked,
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'isBlocked': isBlocked,
      'restaurantId': restaurantId,
    };
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      isBlocked: json['isBlocked'] ?? false,
      restaurantId: json['restaurantId'],
    );
  }
}