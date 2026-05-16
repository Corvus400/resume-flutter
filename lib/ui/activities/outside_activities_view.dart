import 'package:flutter/material.dart';

import '../../data/models/experience.dart';
import '../../data/models/outside_activity.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../common/components.dart';
import '../common/resume_shell.dart';
import 'outside_activities_view_model.dart';

class OutsideActivitiesView extends StatelessWidget {
  const OutsideActivitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = OutsideActivitiesViewModel();
    return ResumeShell(
      activeSection: ResumeSection.activities,
      mobileTitle: 'その他活動',
      child: PageStage(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: AppSpacing.s6),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.line)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Eyebrow('05 — Outside Activities'),
                const SizedBox(height: AppSpacing.s3),
                Text('その他活動', style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: AppSpacing.s2),
                Text(
                  'DroidKaigi コントリビュート、Zenn での振り返り、Android Developers 翻訳動画など、業務外活動の記録。',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          for (final indexed in viewModel.groups.indexed)
            _ActivityGroupView(group: indexed.$2, isFirst: indexed.$1 == 0),
        ],
      ),
    );
  }
}

class _ActivityGroupView extends StatelessWidget {
  const _ActivityGroupView({required this.group, required this.isFirst});

  final OutsideActivityGroup group;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s6),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: isFirst ? Colors.transparent : AppColors.line),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 720;
          final header = SizedBox(
            width: isMobile ? double.infinity : 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Eyebrow(group.label),
                const SizedBox(height: AppSpacing.s2),
                Text(
                  group.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.s3),
                Text(
                  group.count,
                  style: const TextStyle(color: AppColors.ink500),
                ),
              ],
            ),
          );
          final rows = SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                for (final item in group.items) _ActivityRow(item: item),
              ],
            ),
          );

          if (isMobile) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header,
                const SizedBox(height: AppSpacing.s4),
                rows,
              ],
            );
          }

          return Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header,
              const SizedBox(width: AppSpacing.s10),
              Flexible(child: rows),
            ],
          );
        },
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.item});

  final OutsideActivity item;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s4),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.lineSoft)),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.period,
                  style: const TextStyle(color: AppColors.ink300),
                ),
                const SizedBox(height: AppSpacing.s2),
                _ActivityBody(item: item),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    item.period,
                    style: const TextStyle(color: AppColors.ink300),
                  ),
                ),
                const SizedBox(width: AppSpacing.s6),
                Expanded(child: _ActivityBody(item: item)),
              ],
            ),
    );
  }
}

class _ActivityBody extends StatelessWidget {
  const _ActivityBody({required this.item});

  final OutsideActivity item;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    return LayoutBuilder(
      builder: (context, constraints) {
        final canPlaceLinksInline =
            item.links.isNotEmpty && !isMobile && constraints.maxWidth >= 560;
        final links = _ActivityLinks(links: item.links);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (canPlaceLinksInline)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s4),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 280),
                    child: Align(alignment: Alignment.topRight, child: links),
                  ),
                ],
              )
            else
              Text(item.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.s2),
            Text(item.detail, style: Theme.of(context).textTheme.bodyMedium),
            if (item.links.isNotEmpty && !canPlaceLinksInline) ...[
              const SizedBox(height: AppSpacing.s2),
              links,
            ],
          ],
        );
      },
    );
  }
}

class _ActivityLinks extends StatelessWidget {
  const _ActivityLinks({required this.links});

  final List<ResumeLink> links;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.s3,
      runSpacing: AppSpacing.s2,
      alignment: WrapAlignment.end,
      children: [
        for (final link in links)
          ExternalTextLink(
            key: Key('outside-activity-link-${link.url}'),
            url: link.url,
            child: Text(
              '${link.label} ↗',
              style: const TextStyle(
                color: AppColors.ink300,
                fontSize: 11,
                letterSpacing: 2,
              ),
            ),
          ),
      ],
    );
  }
}
