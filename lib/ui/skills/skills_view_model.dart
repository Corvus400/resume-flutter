import '../../data/models/skill_entry.dart';
import '../../data/resume_data.dart';

class SkillsViewModel {
  Map<SkillCategory, List<SkillEntry>> get groupedSkills => skills;

  List<SkillCategory> get categoryOrder => skillCategoryOrder;

  int get maxMonths => 96;

  String categoryTitle(SkillCategory category) =>
      skillCategoryTitles[category]!;
}
