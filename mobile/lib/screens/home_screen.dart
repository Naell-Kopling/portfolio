import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/profile.dart';
import '../models/project.dart';
import '../models/skill.dart';
import '../models/experience.dart';
import '../widgets/profile_header.dart';
import '../widgets/project_card.dart';
import '../widgets/skill_chip.dart';
import '../widgets/experience_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _api = ApiService();
  late Future<Profile> _profile;
  late Future<List<Project>> _projects;
  late Future<List<Skill>> _skills;
  late Future<List<Experience>> _experience;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _profile = _api.getProfile();
    _projects = _api.getProjects();
    _skills = _api.getSkills();
    _experience = _api.getExperience();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: RefreshIndicator(
        color: theme.colorScheme.primary,
        backgroundColor: const Color(0xFF141414),
        onRefresh: () async => setState(() => _loadData()),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            // Profile
            SliverToBoxAdapter(
              child: FutureBuilder<Profile>(
                future: _profile,
                builder: (ctx, snap) {
                  if (snap.hasData) return ProfileHeader(profile: snap.data!);
                  if (snap.hasError) return _error('${snap.error}');
                  return const SizedBox(height: 280, child: Center(child: CircularProgressIndicator()));
                },
              ),
            ),
            _divider(),

            // Skills
            _sectionTitle('Skills'),
            SliverToBoxAdapter(
              child: FutureBuilder<List<Skill>>(
                future: _skills,
                builder: (ctx, snap) {
                  if (snap.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.7),
                        itemCount: snap.data!.length,
                        itemBuilder: (ctx, i) => SkillChip(skill: snap.data![i]),
                      ),
                    );
                  }
                  if (snap.hasError) return _error('${snap.error}');
                  return _loading();
                },
              ),
            ),
            _divider(),

            // Projects
            _sectionTitle('Projects'),
            SliverToBoxAdapter(
              child: FutureBuilder<List<Project>>(
                future: _projects,
                builder: (ctx, snap) {
                  if (snap.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(children: List.generate(snap.data!.length, (i) => ProjectCard(project: snap.data![i], index: i))),
                    );
                  }
                  if (snap.hasError) return _error('${snap.error}');
                  return _loading();
                },
              ),
            ),
            _divider(),

            // Experience
            _sectionTitle('Experience'),
            SliverToBoxAdapter(
              child: FutureBuilder<List<Experience>>(
                future: _experience,
                builder: (ctx, snap) {
                  if (snap.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(children: snap.data!.map((e) => ExperienceCard(experience: e)).toList()),
                    );
                  }
                  if (snap.hasError) return _error('${snap.error}');
                  return _loading();
                },
              ),
            ),

            // Footer
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 48),
                child: Center(child: Text('Built with Flutter & FastAPI', style: TextStyle(fontSize: 12, color: Colors.white.withAlpha(50), letterSpacing: 1))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _sectionTitle(String title) => SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
      child: Row(
        children: [
          Container(width: 3, height: 18, decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 12),
          Text(title.toUpperCase(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white.withAlpha(127), letterSpacing: 1.5)),
        ],
      ),
    ),
  );

  SliverToBoxAdapter _divider() => SliverToBoxAdapter(
    child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20), child: Container(height: 1, color: const Color(0xFF1A1A1A))),
  );

  Widget _error(String msg) => Padding(padding: const EdgeInsets.all(24), child: Text(msg, style: const TextStyle(color: Colors.redAccent)));
  Widget _loading() => const Padding(padding: EdgeInsets.all(32), child: Center(child: CircularProgressIndicator()));
}
