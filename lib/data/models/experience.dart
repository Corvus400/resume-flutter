enum EmploymentType {
  fullTime('正社員'),
  contract('業務委託');

  const EmploymentType(this.label);

  final String label;
}

class Experience {
  const Experience({
    required this.id,
    required this.employmentType,
    required this.period,
    required this.duration,
    required this.bizType,
    required this.companyName,
    required this.projectName,
    required this.role,
    required this.techStack,
    required this.overview,
    required this.responsibility,
    required this.challenges,
    required this.approach,
    required this.ingenuity,
    this.team,
    this.collaboration,
  });

  final String id;
  final EmploymentType employmentType;
  final String period;
  final String duration;
  final String bizType;
  final String companyName;
  final String projectName;
  final String role;
  final List<String> techStack;
  final List<ResumeTextItem> overview;
  final List<ResumeTextItem> responsibility;
  final List<ResumeTextItem> challenges;
  final List<TakumiSection> approach;
  final List<ResumeTextItem> ingenuity;
  final String? team;
  final String? collaboration;
}

class TakumiSection {
  const TakumiSection({required this.title, required this.body});

  final String title;
  final ResumeTextItem body;
}

class ResumeTextItem {
  const ResumeTextItem(this.text, {this.links = const []});

  final String text;
  final List<ResumeLink> links;
}

class ResumeLink {
  const ResumeLink({required this.label, required this.url});

  final String label;
  final String url;
}
