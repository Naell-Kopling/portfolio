class Skill {
  final int id;
  final String name;
  final String? category;
  final int level;

  Skill({required this.id, required this.name, this.category, this.level = 50});

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
    id: json['id'], name: json['name'], category: json['category'], level: json['level'] ?? 50,
  );
}
