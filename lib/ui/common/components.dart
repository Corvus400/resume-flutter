import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/experience.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

Future<void> launchExternalUrl(BuildContext context, String url) async {
  final uri = Uri.parse(url);
  final launched = await launchUrl(
    uri,
    webOnlyWindowName: '_blank',
    mode: LaunchMode.platformDefault,
  );
  if (!launched && context.mounted) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('リンクを開けませんでした: $url')));
  }
}

class PageStage extends StatelessWidget {
  const PageStage({super.key, required this.children, this.padding});

  final List<Widget> children;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    return Padding(
      padding:
          padding ?? EdgeInsets.all(isMobile ? AppSpacing.s5 : AppSpacing.s12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        color: AppColors.ink300,
        fontSize: 11,
        height: 1.45,
        fontWeight: FontWeight.w600,
        letterSpacing: 2,
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.trailing,
  });

  final String eyebrow;
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    final titleText = Text(
      title,
      key: const Key('section-header-title'),
      maxLines: isMobile ? 1 : null,
      overflow: isMobile ? TextOverflow.visible : null,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
        fontSize: isMobile ? 32 : null,
        height: isMobile ? 1.16 : null,
      ),
    );
    return Container(
      padding: const EdgeInsets.only(bottom: AppSpacing.s6),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.line)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Eyebrow(eyebrow),
                const SizedBox(height: AppSpacing.s3),
                titleText,
              ],
            ),
          ),
          if (trailing != null) ...[
            SizedBox(width: isMobile ? AppSpacing.s2 : AppSpacing.s4),
            Flexible(flex: 0, child: trailing!),
          ],
        ],
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  const TagChip(this.label, {super.key, this.highlight = false});

  final String label;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: highlight ? AppColors.accentSoft : AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          label,
          style: TextStyle(
            color: highlight ? AppColors.accent : AppColors.ink500,
            fontSize: 13,
            height: 1.54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class SelectableTagChip extends StatelessWidget {
  const SelectableTagChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final background = selected ? AppColors.ink900 : AppColors.surfaceAlt;
    final foreground = selected ? AppColors.onPrimary : AppColors.ink500;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(999),
        hoverColor: AppColors.lineSoft.withValues(alpha: 0.45),
        focusColor: Colors.transparent,
        splashColor: AppColors.line.withValues(alpha: 0.25),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: background,
            border: Border.all(
              color: selected ? AppColors.ink900 : AppColors.lineSoft,
            ),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: foreground,
              fontSize: 13,
              height: 1.54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class ExternalTextLink extends StatelessWidget {
  const ExternalTextLink({
    super.key,
    required this.url,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.alignment = Alignment.centerLeft,
  });

  final String url;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchExternalUrl(context, url),
      hoverColor: AppColors.lineSoft.withValues(alpha: 0.35),
      focusColor: Colors.transparent,
      splashColor: AppColors.line.withValues(alpha: 0.25),
      child: Padding(
        padding: padding,
        child: Align(alignment: alignment, child: child),
      ),
    );
  }
}

class ResumeTextBlock extends StatelessWidget {
  const ResumeTextBlock({super.key, required this.item});

  final ResumeTextItem item;

  @override
  Widget build(BuildContext context) {
    final text = Text(item.text, style: Theme.of(context).textTheme.bodyMedium);
    if (item.links.isEmpty) {
      return text;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text,
        const SizedBox(height: AppSpacing.s2),
        Wrap(
          spacing: AppSpacing.s3,
          runSpacing: AppSpacing.s1,
          children: [
            for (final link in item.links)
              ExternalTextLink(
                key: Key('resume-link-${link.url}'),
                url: link.url,
                child: Text(
                  '${link.label} ↗',
                  style: const TextStyle(
                    color: AppColors.ink300,
                    fontSize: 11,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class NumberedTextRow extends StatelessWidget {
  const NumberedTextRow({super.key, required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s5),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.lineSoft)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 56,
            child: Text(
              index.toString().padLeft(2, '0'),
              style: const TextStyle(
                color: AppColors.ink300,
                fontSize: 11,
                letterSpacing: 2,
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
