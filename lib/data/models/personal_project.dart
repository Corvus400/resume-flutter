class PersonalProject {
  const PersonalProject({
    required this.name,
    required this.kind,
    required this.summary,
    required this.repoUrl,
    required this.status,
    required this.tags,
    this.repoLinkEnabled = true,
    this.imageAssetPath,
  });

  final String name;
  final String kind;
  final String summary;
  final String repoUrl;
  final String status;
  final List<String> tags;
  final bool repoLinkEnabled;
  final String? imageAssetPath;
}
