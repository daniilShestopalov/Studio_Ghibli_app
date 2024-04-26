class Species {
  final String id;
  final String name;
  final String classification;
  final String eyeColors;
  final String hairColors;
  final List<String> people;
  final List<String> films;
  final String url;

  Species({
    required this.id,
    required this.name,
    required this.classification,
    required this.eyeColors,
    required this.hairColors,
    required this.people,
    required this.films,
    required this.url,
  });

  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(
      id: json['id'],
      name: json['name'],
      classification: json['classification'],
      eyeColors: json['eye_colors'],
      hairColors: json['hair_colors'],
      people: List<String>.from(json['people']),
      films: List<String>.from(json['films']),
      url: json['url'],
    );
  }
}
