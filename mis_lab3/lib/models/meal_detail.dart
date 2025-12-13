class MealDetail {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final String? youtube;
  final List<Map<String, String>> ingredients;

  MealDetail({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    required this.ingredients,
    this.youtube,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    List<Map<String, String>> ing = [];
    for (int i = 1; i <= 20; i++) {
      final ingKey = json['strIngredient$i'];
      final measKey = json['strMeasure$i'];
      if (ingKey != null && (ingKey as String).trim().isNotEmpty) {
        ing.add({ingKey: (measKey ?? '').toString()});
      }
    }

    return MealDetail(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      category: json['strCategory'] ?? '',
      area: json['strArea'] ?? '',
      instructions: json['strInstructions'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
      youtube: (json['strYoutube'] as String?)?.trim().isEmpty == true ? null : json['strYoutube'] as String?,
      ingredients: ing,
    );
  }
}
