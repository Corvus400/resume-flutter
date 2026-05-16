import 'experience.dart';

class OutsideActivityGroup {
  const OutsideActivityGroup({
    required this.label,
    required this.title,
    required this.count,
    required this.items,
  });

  final String label;
  final String title;
  final String count;
  final List<OutsideActivity> items;
}

class OutsideActivity {
  const OutsideActivity({
    required this.period,
    required this.title,
    required this.detail,
    this.links = const [],
  });

  final String period;
  final String title;
  final String detail;
  final List<ResumeLink> links;
}
