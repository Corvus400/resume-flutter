import 'package:flutter/material.dart';

import '../../data/models/personal_project.dart';
import '../../data/resume_data.dart';
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
            eyebrow: projectsSection.eyebrow,
            title: projectsSection.title,
            trailing: Text(
              viewModel.countLabel,
              style: TextStyle(color: AppColors.ink300, letterSpacing: 2),
            ),
          ),
          const SizedBox(height: AppSpacing.s8),
          LayoutBuilder(
            builder: (context, constraints) {
              final isPhone =
                  MediaQuery.sizeOf(context).width < resumeBreakpoint;
              if (isPhone) {
                return Column(
                  children: [
                    for (final indexed in viewModel.projects.indexed) ...[
                      _ProjectCard(
                        key: Key('project-card-${indexed.$1}'),
                        project: indexed.$2,
                        index: indexed.$1,
                        compact: true,
                      ),
                      if (indexed.$1 != viewModel.projects.length - 1)
                        const SizedBox(height: AppSpacing.s6),
                    ],
                  ],
                );
              }

              final columns = constraints.maxWidth < 760 ? 1 : 2;
              final spacing = AppSpacing.s6;
              final cardWidth =
                  (constraints.maxWidth - spacing * (columns - 1)) / columns;
              return Wrap(
                key: const Key('project-grid'),
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  for (final indexed in viewModel.projects.indexed)
                    SizedBox(
                      width: cardWidth,
                      child: _ProjectCard(
                        key: Key('project-card-${indexed.$1}'),
                        project: indexed.$2,
                        index: indexed.$1,
                      ),
                    ),
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
  const _ProjectCard({
    super.key,
    required this.project,
    required this.index,
    this.compact = false,
  });

  final PersonalProject project;
  final int index;
  final bool compact;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  var _hovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final compact = widget.compact;
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
                height: compact ? 112 : 180,
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
                padding: EdgeInsets.all(
                  compact ? AppSpacing.s4 : AppSpacing.s6,
                ),
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
                            style: compact
                                ? Theme.of(context).textTheme.titleMedium
                                : Theme.of(context).textTheme.titleLarge,
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
              Container(
                key: Key('project-card-footer-${widget.index}'),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.s5,
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
