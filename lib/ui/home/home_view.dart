import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/resume_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../common/components.dart';
import '../common/resume_shell.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = HomeViewModel();
    return ResumeShell(
      activeSection: ResumeSection.home,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 900;
          return PageStage(
            padding: EdgeInsets.fromLTRB(
              isMobile ? AppSpacing.s5 : AppSpacing.s12,
              isMobile ? AppSpacing.s5 : AppSpacing.s20,
              isMobile ? AppSpacing.s5 : AppSpacing.s12,
              isMobile ? AppSpacing.s5 : AppSpacing.s24,
            ),
            children: [
              if (isMobile) ...[
                _HeroLead(isMobile: isMobile),
                const SizedBox(height: AppSpacing.s8),
                _ProfileCard(avatarAssetPath: viewModel.avatarAssetPath),
              ] else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _HeroLead(isMobile: isMobile)),
                    const SizedBox(width: AppSpacing.s6),
                    SizedBox(
                      width: 360,
                      child: _ProfileCard(
                        avatarAssetPath: viewModel.avatarAssetPath,
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}

class _HeroLead extends StatelessWidget {
  const _HeroLead({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final displayStyle = Theme.of(context).textTheme.displayLarge!.copyWith(
      fontSize: isMobile ? 40 : 84,
      height: 1.02,
      fontWeight: FontWeight.w800,
      letterSpacing: isMobile ? -0.4 : -5.0,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 40, height: 1, color: AppColors.ink300),
            const SizedBox(width: AppSpacing.s3),
            const Eyebrow('Resume · 2026'),
          ],
        ),
        const SizedBox(height: 28),
        RichText(
          text: TextSpan(
            style: displayStyle,
            children: const [
              TextSpan(text: '経験と実装を\n'),
              TextSpan(
                text: 'Flutter Web',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(text: ' で\n構造化して伝える。'),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Text(
          '$profileName — $profileRole',
          style: const TextStyle(
            color: AppColors.ink700,
            fontSize: 18,
            height: 1.67,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.s5),
        Text(
          'Android Mobile 8年、Kotlin 7年を軸に、設計・実装・テスト基盤まで一貫して扱います。',
          style: const TextStyle(
            color: AppColors.ink500,
            fontSize: 15,
            height: 1.87,
          ),
        ),
        const SizedBox(height: AppSpacing.s8),
        const Divider(color: AppColors.line),
        const SizedBox(height: AppSpacing.s5),
        Wrap(
          spacing: 28,
          runSpacing: AppSpacing.s2,
          children: const [
            _Meta(label: '拠点', value: '日本'),
            _Meta(label: 'モバイル経験', value: '8 年'),
            _Meta(label: '母語', value: '日本語'),
          ],
        ),
        const SizedBox(height: 36),
        FilledButton(
          onPressed: () => context.go('/experience'),
          child: const Text('職務経歴を見る  →'),
        ),
      ],
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.ink900,
            ),
          ),
          TextSpan(
            text: ' · $value',
            style: const TextStyle(color: AppColors.ink500),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.avatarAssetPath});

  final String avatarAssetPath;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      key: const Key('profile-card'),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: DecoratedBox(
                key: const Key('profile-avatar-frame'),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.lineStrong, width: 3),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 18,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipOval(
                    child: Image.asset(
                      avatarAssetPath,
                      width: 284,
                      height: 284,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.s6),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    profileName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(width: AppSpacing.s3),
                Text(
                  '2026',
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 2,
                    color: AppColors.ink300,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s8),
            const Eyebrow('At a glance'),
            const SizedBox(height: AppSpacing.s5),
            const Wrap(
              spacing: AppSpacing.s10,
              runSpacing: AppSpacing.s6,
              children: [
                _Stat(value: '8年', label: 'Android Mobile'),
                _Stat(value: '7年', label: 'Kotlin'),
                _Stat(value: '24件', label: '職務経歴'),
                _Stat(value: '247件', label: 'DroidKaigi マージPR'),
              ],
            ),
            const SizedBox(height: AppSpacing.s6),
            const Divider(color: AppColors.lineSoft),
            const _ProfileLink(
              label: 'GitHub',
              value: '@Corvus400 ↗',
              url: githubProfileUrl,
              valueKey: Key('profile-link-value-github'),
            ),
            const _ProfileLink(
              label: 'X (旧 Twitter)',
              value: '@Todayama_R ↗',
              url: xProfileUrl,
              valueKey: Key('profile-link-value-x'),
            ),
            const _ProfileLink(
              label: 'Resume',
              value: 'resume repository ↗',
              url: resumeRepositoryUrl,
              valueKey: Key('profile-link-value-resume'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 36,
              height: 1,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: AppSpacing.s2),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.ink500),
          ),
        ],
      ),
    );
  }
}

class _ProfileLink extends StatelessWidget {
  const _ProfileLink({
    required this.label,
    required this.value,
    required this.url,
    required this.valueKey,
  });

  final String label;
  final String value;
  final String url;
  final Key valueKey;

  @override
  Widget build(BuildContext context) {
    return ExternalTextLink(
      url: url,
      padding: const EdgeInsets.only(top: AppSpacing.s3),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.ink700),
            ),
          ),
          const SizedBox(width: AppSpacing.s3),
          SizedBox(
            width: 160,
            child: Align(
              key: valueKey,
              alignment: Alignment.centerRight,
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: const TextStyle(color: AppColors.ink300),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
