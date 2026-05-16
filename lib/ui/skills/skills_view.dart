import 'package:flutter/material.dart';

import '../../data/models/skill_entry.dart';
import '../../data/resume_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../common/components.dart';
import '../common/resume_shell.dart';
import 'skills_view_model.dart';

class SkillsView extends StatelessWidget {
  const SkillsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = SkillsViewModel();
    return ResumeShell(
      activeSection: ResumeSection.skills,
      mobileTitle: 'スキル',
      child: PageStage(
        children: [
          SectionHeader(
            eyebrow: skillsSection.eyebrow,
            title: skillsSection.title,
          ),
          const SizedBox(height: AppSpacing.s6),
          for (final indexed in viewModel.categoryOrder.indexed)
            _SkillBlock(
              blockKey: Key('skill-block-${indexed.$2.name}'),
              title: viewModel.categoryTitle(indexed.$2),
              entries: viewModel.groupedSkills[indexed.$2]!,
              maxMonths: viewModel.maxMonths,
              isFirst: indexed.$1 == 0,
              isLast: indexed.$1 == viewModel.categoryOrder.length - 1,
            ),
        ],
      ),
    );
  }
}

class _SkillBlock extends StatelessWidget {
  const _SkillBlock({
    required this.blockKey,
    required this.title,
    required this.entries,
    required this.maxMonths,
    this.isFirst = false,
    this.isLast = false,
  });

  final Key blockKey;
  final String title;
  final List<SkillEntry> entries;
  final int maxMonths;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      key: blockKey,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: isFirst ? Colors.transparent : AppColors.line),
          bottom: isLast
              ? const BorderSide(color: AppColors.line)
              : BorderSide.none,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: isFirst ? AppSpacing.s4 : AppSpacing.s8,
          bottom: AppSpacing.s6,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.s5),
            for (final entry in entries)
              _SkillRow(entry: entry, maxMonths: maxMonths),
          ],
        ),
      ),
    );
  }
}

class _SkillRow extends StatelessWidget {
  const _SkillRow({required this.entry, required this.maxMonths});

  final SkillEntry entry;
  final int maxMonths;

  @override
  Widget build(BuildContext context) {
    final ratio = (entry.experienceMonths / maxMonths).clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s2),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 360;
          return Row(
            children: [
              SizedBox(
                width: isNarrow ? 116 : 190,
                child: Text(
                  entry.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: ratio,
                    minHeight: 7,
                    backgroundColor: AppColors.surfaceAlt,
                    valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                  ),
                ),
              ),
              SizedBox(width: isNarrow ? AppSpacing.s3 : AppSpacing.s5),
              SizedBox(
                width: isNarrow ? 72 : 100,
                child: Text(
                  entry.experienceLabel,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.ink500),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
