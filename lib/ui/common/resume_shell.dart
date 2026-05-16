import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/resume_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

const resumeBreakpoint = 600.0;
const _phoneRailWidth = 52.0;

enum ResumeSection {
  home('/', 'トップ', Icons.home_outlined),
  experience('/experience', '職務経歴', Icons.work_outline),
  projects('/projects', '個人開発', Icons.code),
  activities('/activities', 'その他活動', Icons.campaign_outlined),
  skills('/skills', 'スキル', Icons.bar_chart_rounded);

  const ResumeSection(this.path, this.label, this.icon);

  final String path;
  final String label;
  final IconData icon;
}

class ResumeShell extends StatelessWidget {
  const ResumeShell({
    super.key,
    required this.activeSection,
    required this.child,
    this.mobileTitle,
  });

  final ResumeSection activeSection;
  final Widget child;
  final String? mobileTitle;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isPhonePortrait =
            constraints.maxWidth < resumeBreakpoint &&
            constraints.maxWidth < constraints.maxHeight;
        final isMobile = constraints.maxWidth < resumeBreakpoint;
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                right: isPhonePortrait ? _phoneRailWidth : 0,
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: isMobile ? 420 : 1200,
                      ),
                      margin: EdgeInsets.all(
                        isMobile ? AppSpacing.s4 : AppSpacing.s6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.bg,
                        border: Border.all(color: AppColors.line),
                        borderRadius: BorderRadius.circular(isMobile ? 10 : 12),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _AppBar(
                            activeSection: activeSection,
                            isMobile: isMobile,
                            mobileTitle: mobileTitle,
                          ),
                          child,
                          const _Footer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (isPhonePortrait)
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: _PhoneNavigationRail(activeSection: activeSection),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    required this.activeSection,
    required this.isMobile,
    required this.mobileTitle,
  });

  final ResumeSection activeSection;
  final bool isMobile;
  final String? mobileTitle;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.bg,
        border: Border(bottom: BorderSide(color: AppColors.line)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: isMobile ? 68 : 64,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? AppSpacing.s5 : AppSpacing.s12,
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 14,
                    backgroundImage: AssetImage(
                      'assets/images/profile/avatar.png',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      isMobile
                          ? (mobileTitle ?? activeSection.label)
                          : profileName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink900,
                      ),
                    ),
                  ),
                  if (!isMobile)
                    for (final section in ResumeSection.values)
                      _NavItem(
                        section: section,
                        active: section == activeSection,
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

class _PhoneNavigationRail extends StatelessWidget {
  const _PhoneNavigationRail({required this.activeSection});

  final ResumeSection activeSection;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: const Key('phone-nav-rail'),
      width: _phoneRailWidth,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(left: BorderSide(color: AppColors.line)),
        ),
        child: SafeArea(
          left: false,
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.s4),
              for (final section in ResumeSection.values)
                _PhoneNavItem(
                  section: section,
                  active: section == activeSection,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneNavItem extends StatelessWidget {
  const _PhoneNavItem({required this.section, required this.active});

  final ResumeSection section;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: section.label,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Semantics(
          label: section.label,
          button: true,
          selected: active,
          child: Material(
            key: Key('phone-nav-${section.name}'),
            color: active ? AppColors.primaryContainer : Colors.transparent,
            shape: const StadiumBorder(),
            child: InkWell(
              customBorder: const StadiumBorder(),
              onTap: () => context.go(section.path),
              child: SizedBox(
                width: 44,
                height: 38,
                child: Icon(
                  section.icon,
                  size: 23,
                  color: active ? AppColors.primary : AppColors.ink500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.section, required this.active});

  final ResumeSection section;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go(section.path),
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? AppColors.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          section.label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < resumeBreakpoint;
    const copyright = Text(
      '© 2026 とだやま.ℝ(TODAYAMA_R)',
      style: TextStyle(fontSize: 11, letterSpacing: 2, color: AppColors.ink300),
    );
    const buildLabel = Text(
      'FLUTTER WEB · HASH ROUTING',
      style: TextStyle(fontSize: 11, letterSpacing: 2, color: AppColors.ink300),
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        final useStackedFooter = isMobile || constraints.maxWidth < 760;
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? AppSpacing.s5 : AppSpacing.s12,
            vertical: AppSpacing.s5,
          ),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.line)),
          ),
          child: useStackedFooter
              ? const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    copyright,
                    SizedBox(height: AppSpacing.s2),
                    buildLabel,
                  ],
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [copyright, buildLabel],
                ),
        );
      },
    );
  }
}
