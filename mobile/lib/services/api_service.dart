import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/profile.dart';
import '../models/project.dart';
import '../models/skill.dart';
import '../models/experience.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  Future<Profile> getProfile() async {
    final res = await http.get(Uri.parse('$baseUrl/profile/'));
    if (res.statusCode == 200) return Profile.fromJson(jsonDecode(res.body));
    throw Exception('Failed to load profile');
  }

  Future<List<Project>> getProjects() async {
    final res = await http.get(Uri.parse('$baseUrl/projects/'));
    if (res.statusCode == 200) {
      return (jsonDecode(res.body) as List).map((j) => Project.fromJson(j)).toList();
    }
    throw Exception('Failed to load projects');
  }

  Future<List<Skill>> getSkills() async {
    final res = await http.get(Uri.parse('$baseUrl/skills/'));
    if (res.statusCode == 200) {
      return (jsonDecode(res.body) as List).map((j) => Skill.fromJson(j)).toList();
    }
    throw Exception('Failed to load skills');
  }

  Future<List<Experience>> getExperience() async {
    final res = await http.get(Uri.parse('$baseUrl/experience/'));
    if (res.statusCode == 200) {
      return (jsonDecode(res.body) as List).map((j) => Experience.fromJson(j)).toList();
    }
    throw Exception('Failed to load experience');
  }
}
