import 'package:flutter/material.dart';

import '../../data/models/personal_project.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../common/components.dart';
import '../common/resume_shell.dart';
import 'personal_projects_view_model.dart';

class PersonalProjectsView extends StatelessWidget {
  const PersonalProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = PersonalProjectsViewModel();
    return ResumeShell(
      activeSection: ResumeSection.projects,
      mobileTitle: '個人開発',
      child: PageStage(
        children: [
          SectionHeader(
            eyebrow: '04 — Personal Projects',
            title: '個人開発',
            trailing: Text(
              viewModel.countLabel,
              style: TextStyle(color: AppColors.ink300, letterSpacing: 2),
            ),
          ),
          const SizedBox(height: AppSpacing.s8),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth < 760 ? 1 : 2;
              final cardHeight = columns == 1 ? 660.0 : 460.0;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: columns,
                mainAxisSpacing: AppSpacing.s6,
                crossAxisSpacing: AppSpacing.s6,
                childAspectRatio:
                    (constraints.maxWidth / columns - AppSpacing.s3) /
                    cardHeight,
                children: [
                  for (final project in viewModel.projects)
                    _ProjectCard(project: project),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.project});

  final PersonalProject project;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  var _hovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    return InkWell(
      onTap: () => launchExternalUrl(context, project.repoUrl),
      onHover: (hovered) => setState(() => _hovered = hovered),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(
            color: _hovered ? AppColors.primary : AppColors.line,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 180,
                width: double.infinity,
                child: project.imageAssetPath == null
                    ? const ColoredBox(
                        color: AppColors.surfaceAlt,
                        child: Center(
                          child: Eyebrow('App Screenshot — resume-flutter'),
                        ),
                      )
                    : Image.asset(project.imageAssetPath!, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.s6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            project.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        TagChip(
                          project.status,
                          highlight: project.status == '公開中',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s1),
                    Eyebrow(project.kind),
                    const SizedBox(height: AppSpacing.s4),
                    Text(
                      project.summary,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.s5),
                    Wrap(
                      spacing: AppSpacing.s2,
                      runSpacing: AppSpacing.s2,
                      children: [for (final tag in project.tags) TagChip(tag)],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s6,
                  vertical: AppSpacing.s4,
                ),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.lineSoft)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      project.status == '公開中' ? '公開リポジトリ' : '作成中',
                      style: const TextStyle(color: AppColors.ink500),
                    ),
                    Text(
                      'GitHub ↗',
                      style: TextStyle(
                        color: _hovered ? AppColors.primary : AppColors.ink900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
