class Recipe {
  final String name;
  final String imageUrl;
  final double rating;
  final String totalTime;

  Recipe({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.totalTime,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    String name = json['seo']?['web']?['meta-tags']?['title'] ?? 'No Title';
    String imageUrl = json['seo']?['web']?['image-url'] ?? '';
    double rating = json['rating']?.toDouble() ?? 0.0;
    String totalTime = json['totalTime'] ?? 'No Time';

    return Recipe(
      name: name,
      imageUrl: imageUrl,
      rating: rating,
      totalTime: totalTime,
    );
  }

  static List<Recipe> recipesFromSnapshot(List<dynamic> snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data as Map<String, dynamic>);
    }).toList();
  }
}
