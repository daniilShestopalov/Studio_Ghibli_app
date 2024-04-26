class Vehicle {
  final String id;
  final String name;
  final String description;
  final String vehicleClass;
  final String length;
  final String pilot;
  final List<String> films;
  final String url;

  Vehicle({
    required this.id,
    required this.name,
    required this.description,
    required this.vehicleClass,
    required this.length,
    required this.pilot,
    required this.films,
    required this.url,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      vehicleClass: json['vehicle_class'],
      length: json['length'],
      pilot: json['pilot'],
      films: List<String>.from(json['films']),
      url: json['url'],
    );
  }
}
