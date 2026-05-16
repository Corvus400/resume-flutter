import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/experience.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../common/components.dart';
import '../common/resume_shell.dart';
import 'experience_detail_view_model.dart';

class ExperienceDetailView extends StatelessWidget {
  const ExperienceDetailView({super.key, required this.viewModel});

  final ExperienceDetailViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final experience = viewModel.experience;
    return ResumeShell(
      activeSection: ResumeSection.experience,
      mobileTitle: '職務経歴',
      child: PageStage(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s12,
          AppSpacing.s12,
          AppSpacing.s12,
          AppSpacing.s24,
        ),
        children: [
          InkWell(
            key: const Key('experience-detail-back-link'),
            onTap: () => context.go('/experience'),
            borderRadius: BorderRadius.circular(4),
            hoverColor: AppColors.lineSoft.withValues(alpha: 0.35),
            focusColor: AppColors.accentSoft.withValues(alpha: 0.45),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.s2),
              child: Text(
                '← 職務経歴',
                style: TextStyle(
                  color: AppColors.ink300,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 36),
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 700;
              final lead = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Eyebrow(experience.period),
                  const SizedBox(height: AppSpacing.s5),
                  Text(
                    experience.companyName,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  Text(
                    '${experience.projectName} / ${experience.role}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              );
              final meta = _MetaCard(experience: experience);

              if (isMobile) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    lead,
                    const SizedBox(height: AppSpacing.s6),
                    meta,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: lead),
                  const SizedBox(width: AppSpacing.s12),
                  meta,
                ],
              );
            },
          ),
          const SizedBox(height: AppSpacing.s8),
          const Divider(color: AppColors.line),
          const SizedBox(height: AppSpacing.s6),
          const Eyebrow('触れた技術スタック'),
          const SizedBox(height: AppSpacing.s4),
          Wrap(
            spacing: AppSpacing.s2,
            runSpacing: AppSpacing.s2,
            children: [for (final tag in experience.techStack) TagChip(tag)],
          ),
          const SizedBox(height: AppSpacing.s8),
          _TextSection(title: '概要', items: experience.overview),
          _TextSection(title: '担当', items: experience.responsibility),
          _TextSection(title: '課題', items: experience.challenges),
          _ApproachSection(items: experience.approach),
          _TextSection(title: '工夫した点', items: experience.ingenuity),
        ],
      ),
    );
  }
}

class _MetaCard extends StatelessWidget {
  const _MetaCard({required this.experience});

  final Experience experience;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s5),
        child: SizedBox(
          width: 260,
          child: Wrap(
            runSpacing: AppSpacing.s4,
            children: [
              _Meta(label: '期間', value: experience.duration),
              _Meta(label: '領域', value: experience.bizType),
              if (experience.team != null)
                _Meta(label: 'チーム', value: experience.team!),
              if (experience.collaboration != null)
                _Meta(label: '連携', value: experience.collaboration!),
            ],
          ),
        ),
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.ink300, fontSize: 11),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.ink900,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _TextSection extends StatelessWidget {
  const _TextSection({required this.title, required this.items});

  final String title;
  final List<ResumeTextItem> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.s8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(title),
          for (var i = 0; i < items.length; i++)
            NumberedTextRow(
              index: i + 1,
              child: ResumeTextBlock(item: items[i]),
            ),
        ],
      ),
    );
  }
}

class _ApproachSection extends StatelessWidget {
  const _ApproachSection({required this.items});

  final List<TakumiSection> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.s8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('取り組み'),
          for (var i = 0; i < items.length; i++)
            NumberedTextRow(
              index: i + 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    items[i].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.s2),
                  ResumeTextBlock(item: items[i].body),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: AppSpacing.s3),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.lineSoft)),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.ink300,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
