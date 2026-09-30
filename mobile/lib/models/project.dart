class Project {
  final int id;
  final String title;
  final String? description;
  final String? techStack;
  final String? githubUrl;
  final String? demoUrl;
  final String? imageUrl;

  Project({required this.id, required this.title, this.description, this.techStack, this.githubUrl, this.demoUrl, this.imageUrl});

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json['id'], title: json['title'], description: json['description'],
    techStack: json['tech_stack'], githubUrl: json['github_url'], demoUrl: json['demo_url'], imageUrl: json['image_url'],
  );
}
