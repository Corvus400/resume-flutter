import '../../data/models/skill_entry.dart';
import '../../data/resume_data.dart';

class SkillsViewModel {
  Map<SkillCategory, List<SkillEntry>> get groupedSkills => skills;

  int get maxMonths => 96;
}
