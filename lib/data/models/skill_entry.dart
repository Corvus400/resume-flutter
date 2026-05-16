enum SkillCategory { language, platform, ai }

class SkillEntry {
  const SkillEntry({
    required this.name,
    required this.experienceLabel,
    required this.experienceMonths,
  });

  final String name;
  final String experienceLabel;
  final int experienceMonths;
}
