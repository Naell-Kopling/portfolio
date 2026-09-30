import 'package:flutter/material.dart';
import '../models/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final int index;
  const ProjectCard({super.key, required this.project, this.index = 0});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E1E1E)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withAlpha(25),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text('${index + 1}'.padLeft(2, '0'), style: TextStyle(color: theme.colorScheme.primary, fontSize: 13, fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(height: 14),
          Text(project.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          if (project.description != null) ...[
            const SizedBox(height: 8),
            Text(project.description!, style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(127), height: 1.4)),
          ],
          if (project.techStack != null) ...[
            const SizedBox(height: 14),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: project.techStack!.split(',').map((t) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: const Color(0xFF0A0A0A), borderRadius: BorderRadius.circular(6)),
                child: Text(t.trim(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.white.withAlpha(150))),
              )).toList(),
            ),
          ],
          if (project.githubUrl != null) ...[
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(Icons.open_in_new, size: 14, color: theme.colorScheme.primary),
                const SizedBox(width: 6),
                Text('View on GitHub', style: TextStyle(fontSize: 13, color: theme.colorScheme.primary, fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
