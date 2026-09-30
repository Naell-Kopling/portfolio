import 'package:flutter/material.dart';
import '../models/skill.dart';

class SkillChip extends StatelessWidget {
  final Skill skill;
  const SkillChip({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1E1E1E)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(skill.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 2),
          Text((skill.category ?? 'Skill').toUpperCase(), style: TextStyle(fontSize: 10, color: Colors.white.withAlpha(75), letterSpacing: 1)),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: skill.level / 100,
              minHeight: 4,
              backgroundColor: const Color(0xFF262626),
              valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}
