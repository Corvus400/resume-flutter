import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/experience.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../common/components.dart';
import '../common/resume_shell.dart';
import 'experience_list_view_model.dart';

class ExperienceListView extends StatefulWidget {
  const ExperienceListView({super.key});

  @override
  State<ExperienceListView> createState() => _ExperienceListViewState();
}

class _ExperienceListViewState extends State<ExperienceListView> {
  final ExperienceListViewModel viewModel = ExperienceListViewModel();
  ExperienceFilter _selectedFilter = ExperienceFilter.all;

  @override
  Widget build(BuildContext context) {
    final visibleExperiences = viewModel.filteredExperiences(_selectedFilter);
    return ResumeShell(
      activeSection: ResumeSection.experience,
      mobileTitle: '職務経歴',
      child: PageStage(
        key: const Key('experience-list-stage'),
        padding: EdgeInsets.fromLTRB(
          AppSpacing.s12,
          AppSpacing.s16,
          AppSpacing.s12,
          AppSpacing.s24,
        ),
        children: [
          SectionHeader(
            eyebrow: '02 — Work Experience',
            title: '職務経歴',
            trailing: Text(
              viewModel.totalLabel,
              style: TextStyle(color: AppColors.ink300, letterSpacing: 2),
            ),
          ),
          const SizedBox(height: AppSpacing.s8),
          Wrap(
            spacing: AppSpacing.s2,
            runSpacing: AppSpacing.s2,
            children: [
              for (final filter in viewModel.filters)
                SelectableTagChip(
                  key: Key('experience-filter-${filter.name}'),
                  label: filter.label,
                  selected: filter == _selectedFilter,
                  onPressed: () => setState(() => _selectedFilter = filter),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.s4),
          if (visibleExperiences.isEmpty)
            const _EmptyExperienceList()
          else
            for (final experience in visibleExperiences)
              _ExperienceRow(experience: experience),
          const SizedBox(height: AppSpacing.s6),
          Container(
            key: const Key('experience-resume-link'),
            width: double.infinity,
            padding: const EdgeInsets.only(top: AppSpacing.s4),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.line)),
            ),
            child: ExternalTextLink(
              url: viewModel.resumeUrl,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '全24件の職務経歴を見る',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: AppSpacing.s2),
                  Text(
                    'resume repository ↗',
                    style: TextStyle(
                      color: AppColors.ink500,
                      fontSize: 12,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyExperienceList extends StatelessWidget {
  const _EmptyExperienceList();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s8),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.line),
          bottom: BorderSide(color: AppColors.line),
        ),
      ),
      child: const Text(
        '該当する職務経歴はありません。',
        style: TextStyle(color: AppColors.ink500),
      ),
    );
  }
}

class _ExperienceRow extends StatefulWidget {
  const _ExperienceRow({required this.experience});

  final Experience experience;

  @override
  State<_ExperienceRow> createState() => _ExperienceRowState();
}

class _ExperienceRowState extends State<_ExperienceRow> {
  var _hovered = false;
  var _focused = false;

  @override
  Widget build(BuildContext context) {
    final experience = widget.experience;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: FocusableActionDetector(
        key: Key('experience-row-focus-${experience.id}'),
        mouseCursor: SystemMouseCursors.click,
        onFocusChange: (focused) => setState(() => _focused = focused),
        onShowFocusHighlight: (focused) => setState(() => _focused = focused),
        child: InkWell(
          onTap: () => context.go('/experience/${experience.id}'),
          onFocusChange: (focused) => setState(() => _focused = focused),
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: AppColors.line.withValues(alpha: 0.22),
          child: AnimatedContainer(
            key: Key('experience-row-${experience.id}'),
            duration: const Duration(milliseconds: 140),
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border(
                top: const BorderSide(color: AppColors.line),
                bottom: (_hovered || _focused)
                    ? const BorderSide(color: AppColors.lineStrong)
                    : BorderSide.none,
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 680;
                final dateBlock = _DateBlock(experience: experience);
                final contentBlock = _ExperienceContent(experience: experience);
                final arrowActive = _hovered || _focused;
                final arrow = CircleAvatar(
                  key: Key('experience-row-arrow-${experience.id}'),
                  radius: 22,
                  backgroundColor: arrowActive
                      ? AppColors.primary
                      : AppColors.surface,
                  child: Text(
                    '→',
                    style: TextStyle(
                      color: arrowActive
                          ? AppColors.onPrimary
                          : AppColors.ink700,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );

                if (isMobile) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: dateBlock),
                          const SizedBox(width: AppSpacing.s4),
                          arrow,
                        ],
                      ),
                      const SizedBox(height: AppSpacing.s4),
                      contentBlock,
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 120, child: dateBlock),
                    const SizedBox(width: AppSpacing.s8),
                    Expanded(child: contentBlock),
                    const SizedBox(width: AppSpacing.s8),
                    arrow,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _DateBlock extends StatelessWidget {
  const _DateBlock({required this.experience});

  final Experience experience;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          experience.period,
          style: const TextStyle(color: AppColors.ink300, letterSpacing: 1.5),
        ),
        const SizedBox(height: AppSpacing.s2),
        Text(
          experience.duration,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _ExperienceContent extends StatelessWidget {
  const _ExperienceContent({required this.experience});

  final Experience experience;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          experience.companyName,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.s2),
        Text(experience.role, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: AppSpacing.s3),
        Wrap(
          spacing: AppSpacing.s2,
          runSpacing: AppSpacing.s2,
          children: [
            for (final tag in experience.techStack.take(5)) TagChip(tag),
          ],
        ),
      ],
    );
  }
}
