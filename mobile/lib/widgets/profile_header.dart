import 'package:flutter/material.dart';
import '../models/profile.dart';

class ProfileHeader extends StatelessWidget {
  final Profile profile;
  const ProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withAlpha(25),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme.colorScheme.primary.withAlpha(75)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 6, height: 6, decoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle)),
                const SizedBox(width: 8),
                Text('Available for work', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: theme.colorScheme.primary, letterSpacing: 0.5)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(profile.name, style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w700, letterSpacing: -1.5, height: 1)),
          if (profile.title != null) ...[
            const SizedBox(height: 8),
            Text(profile.title!, style: TextStyle(fontSize: 20, color: theme.colorScheme.primary, fontWeight: FontWeight.w500)),
          ],
          if (profile.bio != null) ...[
            const SizedBox(height: 16),
            Text(profile.bio!, style: TextStyle(fontSize: 15, color: Colors.white.withAlpha(127), height: 1.5)),
          ],
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              if (profile.email != null && profile.email!.isNotEmpty) _chip(context, Icons.alternate_email, profile.email!),
              if (profile.github != null && profile.github!.isNotEmpty) _chip(context, Icons.code, 'GitHub'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(BuildContext context, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF262626)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white.withAlpha(127)),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(fontSize: 13, color: Colors.white.withAlpha(178))),
        ],
      ),
    );
  }
}
