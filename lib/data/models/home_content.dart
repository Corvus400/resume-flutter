class HomeHeroSegment {
  const HomeHeroSegment({required this.text, this.highlight = false});

  final String text;
  final bool highlight;
}

class HomeMetaItem {
  const HomeMetaItem({required this.label, required this.value});

  final String label;
  final String value;
}

class HomeStatItem {
  const HomeStatItem({required this.value, required this.label});

  final String value;
  final String label;
}
