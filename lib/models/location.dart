class Location {
  final String id;
  final String name;
  final String climate;
  final String terrain;
  final String surfaceWater;
  final List<String> residents;
  final List<String> films;
  final String url;

  Location({
    required this.id,
    required this.name,
    required this.climate,
    required this.terrain,
    required this.surfaceWater,
    required this.residents,
    required this.films,
    required this.url,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      climate: json['climate'],
      terrain: json['terrain'],
      surfaceWater: json['surface_water'],
      residents: List<String>.from(json['residents']),
      films: List<String>.from(json['films']),
      url: json['url'],
    );
  }
}
