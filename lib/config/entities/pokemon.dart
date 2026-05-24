

class Pokemon {
  final int id;
  final String name;
  final int altitud;
  final int weight;
  final List<String> faculties;
  final String? faceImage;
  
  Pokemon({
    required this.id,
    required this.name,
    required this.altitud,
    required this.weight,
    required this.faculties,
    this.faceImage,
  });
}