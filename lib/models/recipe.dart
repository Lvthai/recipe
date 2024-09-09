class Recipe {
  final int? id;
  final String name;
  final String category;

  Recipe({this.id, required this.name, required this.category});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      name: map['name'],
      category: map['category'],
    );
  }

  Recipe copy({int? id, String? name, String? category}) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
    );
  }
}
