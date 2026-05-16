import '../../data/models/experience.dart';
import '../../data/resume_data.dart';

enum ExperienceFilter {
  all('すべて'),
  fullTime('正社員'),
  contract('業務委託'),
  flutter('Flutter'),
  ios('iOS'),
  android('Android');

  const ExperienceFilter(this.label);

  final String label;
}

class ExperienceListViewModel {
  List<Experience> get featuredExperiences => experiences.take(4).toList();

  List<ExperienceFilter> get filters => ExperienceFilter.values;

  List<Experience> filteredExperiences(ExperienceFilter filter) {
    return switch (filter) {
      ExperienceFilter.all => featuredExperiences,
      ExperienceFilter.fullTime =>
        featuredExperiences
            .where(
              (experience) =>
                  experience.employmentType == EmploymentType.fullTime,
            )
            .toList(),
      ExperienceFilter.contract =>
        featuredExperiences
            .where(
              (experience) =>
                  experience.employmentType == EmploymentType.contract,
            )
            .toList(),
      ExperienceFilter.flutter =>
        featuredExperiences
            .where((experience) => experience.techStack.contains('Flutter'))
            .toList(),
      ExperienceFilter.ios =>
        featuredExperiences
            .where((experience) => experience.techStack.contains('iOS'))
            .toList(),
      ExperienceFilter.android =>
        featuredExperiences
            .where((experience) => experience.techStack.contains('Android'))
            .toList(),
    };
  }

  String get totalLabel =>
      '最新 ${featuredExperiences.length} 件 / 全 $totalExperienceCount 件';

  String get resumeUrl => resumeRepositoryUrl;
}
