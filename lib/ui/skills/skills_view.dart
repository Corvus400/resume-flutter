import 'package:flutter/material.dart';

import '../../data/models/skill_entry.dart';
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
          const SectionHeader(eyebrow: '06 — Skills', title: 'スキル'),
          const SizedBox(height: AppSpacing.s6),
          _SkillBlock(
            blockKey: const Key('skill-block-language'),
            title: '言語',
            entries: viewModel.groupedSkills[SkillCategory.language]!,
            maxMonths: viewModel.maxMonths,
            isFirst: true,
          ),
          _SkillBlock(
            blockKey: const Key('skill-block-platform'),
            title: 'プラットフォーム / フレームワーク',
            entries: viewModel.groupedSkills[SkillCategory.platform]!,
            maxMonths: viewModel.maxMonths,
          ),
          _SkillBlock(
            blockKey: const Key('skill-block-ai'),
            title: 'AI活用歴',
            entries: viewModel.groupedSkills[SkillCategory.ai]!,
            maxMonths: viewModel.maxMonths,
            isLast: true,
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
      child: Row(
        children: [
          SizedBox(
            width: 190,
            child: Text(
              entry.name,
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
          const SizedBox(width: AppSpacing.s5),
          SizedBox(
            width: 100,
            child: Text(
              entry.experienceLabel,
              style: const TextStyle(color: AppColors.ink500),
            ),
          ),
        ],
      ),
    );
  }
}
