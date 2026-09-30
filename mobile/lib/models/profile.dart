class Profile {
  final int id;
  final String name;
  final String? title;
  final String? bio;
  final String? email;
  final String? github;
  final String? linkedin;
  final String? avatarUrl;

  Profile({required this.id, required this.name, this.title, this.bio, this.email, this.github, this.linkedin, this.avatarUrl});

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json['id'], name: json['name'], title: json['title'], bio: json['bio'],
    email: json['email'], github: json['github'], linkedin: json['linkedin'], avatarUrl: json['avatar_url'],
  );
}
