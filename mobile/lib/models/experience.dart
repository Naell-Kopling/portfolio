class Experience {
  final int id;
  final String role;
  final String company;
  final String? period;
  final String? description;

  Experience({required this.id, required this.role, required this.company, this.period, this.description});

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    id: json['id'], role: json['role'], company: json['company'], period: json['period'], description: json['description'],
  );
}
