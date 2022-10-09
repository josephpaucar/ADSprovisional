class Recomendation {
  Recomendation({
    required this.id,
    required this.description,
    required this.category,
  });
  final String id;
  final String description;
  final String category;

  factory Recomendation.fromMap(Map<String, dynamic> data) {
    final String id = data['id'];
    final String description = data['description'];
    final String category = data['category'];

    return Recomendation(
      id: id,
      description: description,
      category: category,
    );
  }
}
