// GENERATED CODE - DO NOT MODIFY BY HAND.
// Run `dart run tool/generate_resume_content.dart` after editing content/resume/*.yaml.

import '../models/experience.dart';
import '../models/home_content.dart';
import '../models/outside_activity.dart';
import '../models/personal_project.dart';
import '../models/section_content.dart';
import '../models/skill_entry.dart';

const profileName = 'とだやま.ℝ(Todayama_R)';
const profileRole = 'Android / Flutter ソフトウェアエンジニア';
const resumeRepositoryUrl = 'https://github.com/Corvus400/resume';
const githubProfileUrl = 'https://github.com/Corvus400';
const xProfileUrl = 'https://x.com/Todayama_R';
const zennProfileUrl = 'https://zenn.dev/todayama_r';
const totalExperienceCount = 24;
const droidKaigiMergedPrCount = 247;

const homeHeroEyebrow = 'Resume · 2026';
const homeHeroHeadlineSegments = <HomeHeroSegment>[
  HomeHeroSegment(text: 'AI時代', highlight: true),
  HomeHeroSegment(text: 'の\nモバイル開発を、\n設計力と検証力で\n加速する。', highlight: false),
];
const homeHeroSummary = 'Android Mobile 8年、Kotlin 7年を軸に、設計・実装・テスト基盤まで一貫して扱います。';
const homeHeroCtaLabel = '職務経歴を見る  →';
const homeHeroMetaItems = <HomeMetaItem>[
  HomeMetaItem(label: '拠点', value: '日本'),
  HomeMetaItem(label: 'モバイル経験', value: '8 年'),
  HomeMetaItem(label: '母語', value: '日本語'),
];
const homeProfileCardYear = '2026';
const homeProfileCardEyebrow = 'At a glance';
const homeProfileAvatarAssetPath = 'assets/images/profile/avatar.png';
const homeProfileStats = <HomeStatItem>[
  HomeStatItem(value: '8年', label: 'Android Mobile'),
  HomeStatItem(value: '7年', label: 'Kotlin'),
  HomeStatItem(value: '24件', label: '職務経歴'),
  HomeStatItem(value: '247件', label: 'DroidKaigi マージPR'),
];

const experienceSection = ResumeSectionContent(
  eyebrow: 'Work Experience',
  title: '職務経歴',
  summary: null,
);
const projectsSection = ResumeSectionContent(
  eyebrow: 'Personal Projects',
  title: '個人開発',
  summary: null,
);
const activitiesSection = ResumeSectionContent(
  eyebrow: 'Outside Activities',
  title: 'その他活動',
  summary:
      'DroidKaigi コントリビュート、Zenn での振り返り、Android Developers 翻訳動画など、業務外活動の記録。',
);
const skillsSection = ResumeSectionContent(
  eyebrow: 'Skills',
  title: 'スキル',
  summary: null,
);

const skillCategoryOrder = <SkillCategory>[
  SkillCategory.ai,
  SkillCategory.language,
  SkillCategory.platform,
];
const skillCategoryTitles = <SkillCategory, String>{
  SkillCategory.ai: 'AI活用歴',
  SkillCategory.language: '言語',
  SkillCategory.platform: 'プラットフォーム / フレームワーク',
};
const skills = <SkillCategory, List<SkillEntry>>{
  SkillCategory.language: <SkillEntry>[
    SkillEntry(
      name: 'Kotlin',
      experienceLabel: '7年(86ヶ月)',
      experienceMonths: 86,
    ),
    SkillEntry(name: 'Java', experienceLabel: '3年(35ヶ月)', experienceMonths: 35),
    SkillEntry(
      name: 'C++',
      experienceLabel: '1.5年(18ヶ月)',
      experienceMonths: 18,
    ),
    SkillEntry(name: 'Swift', experienceLabel: '8ヶ月', experienceMonths: 8),
    SkillEntry(
      name: 'JavaScript',
      experienceLabel: '6ヶ月相当',
      experienceMonths: 6,
    ),
    SkillEntry(name: 'Dart', experienceLabel: '4ヶ月', experienceMonths: 4),
    SkillEntry(
      name: 'Objective-C',
      experienceLabel: '1ヶ月相当',
      experienceMonths: 1,
    ),
  ],
  SkillCategory.platform: <SkillEntry>[
    SkillEntry(
      name: 'Android Mobile',
      experienceLabel: '8年(96ヶ月)',
      experienceMonths: 96,
    ),
    SkillEntry(
      name: 'Cocos2d-x',
      experienceLabel: '1.5年(18ヶ月)',
      experienceMonths: 18,
    ),
    SkillEntry(name: 'iOS', experienceLabel: '8ヶ月', experienceMonths: 8),
    SkillEntry(name: 'Android TV', experienceLabel: '6ヶ月', experienceMonths: 6),
    SkillEntry(name: 'Flutter', experienceLabel: '4ヶ月', experienceMonths: 4),
  ],
  SkillCategory.ai: <SkillEntry>[
    SkillEntry(
      name: 'Claude Code',
      experienceLabel: '9ヶ月',
      experienceMonths: 9,
    ),
    SkillEntry(
      name: 'GitHub Copilot CLI',
      experienceLabel: '2ヶ月',
      experienceMonths: 2,
    ),
    SkillEntry(name: 'Devin', experienceLabel: '2ヶ月', experienceMonths: 2),
    SkillEntry(name: 'Codex', experienceLabel: '2ヶ月', experienceMonths: 2),
    SkillEntry(
      name: 'Claude Design',
      experienceLabel: '1ヶ月',
      experienceMonths: 1,
    ),
  ],
};

const experiences = <Experience>[
  Experience(
    id: 'oisix',
    employmentType: EmploymentType.contract,
    period: '2025.09 - 2026.03',
    duration: '7ヶ月',
    bizType: 'BtoC',
    companyName: 'オイシックス・ラ・大地株式会社',
    projectName: 'Oisix ECアプリ開発',
    role: 'Androidアプリの機能開発・保守・技術基盤改善',
    team: '約10名',
    collaboration: 'iOSチーム',
    techStack: <String>[
      'Kotlin',
      'Kotlin Coroutines',
      'Kotlin Flow',
      'Jetpack Compose',
      'Android',
      'KMP (Kotlin Multiplatform)',
      'Swift (iOS連携)',
      'Ktor (Mock Server構築)',
      'Claude Code',
      'Devin',
      'GitHub Actions',
      'Roborazzi (Screenshot Testing)',
      'ADR (Architecture Decision Records)',
    ],
    overview: <ResumeTextItem>[
      ResumeTextItem('会員数360万人超のEC定期便サービス「Oisix」のAndroid/iOSアプリ開発に従事。'),
      ResumeTextItem(
        'Android版ストアは此方',
        links: <ResumeLink>[
          ResumeLink(
            label: 'Android版ストア',
            url:
                'https://play.google.com/store/apps/details?id=com.oisix.oisixAndroid&hl=ja',
          ),
        ],
      ),
      ResumeTextItem(
        '30以上のマルチモジュール構成で、KMP (Kotlin Multiplatform) によるiOSとのコード共有を推進中。',
      ),
      ResumeTextItem(
        'アーキテクチャはClean Architecture + DDDに基づき、UseCase層を中心としたドメインロジックの設計。',
      ),
    ],
    responsibility: <ResumeTextItem>[
      ResumeTextItem('Androidアプリの機能開発・保守、および技術基盤改善を担当。'),
      ResumeTextItem('チーム人数は約10名（Android専任）、iOSチームとの連携あり。'),
    ],
    challenges: <ResumeTextItem>[
      ResumeTextItem('Claude等AI導入によって実装までは早くなったものの、レビューが最大のボトルネックになっている。'),
      ResumeTextItem(
        'クリティカル導線テストを実施する際に曜日に依存する仕様やテストの前提条件となるアカウントの用意が困難な箇所があり、テストの実施が困難となっている。',
      ),
      ResumeTextItem(
        'KMPによって提供しているUseCaseが十分に検証されておらず、iOS側で使用された際にクラッシュする問題を引き起こすなど種々の問題を引き起こしていた。',
      ),
      ResumeTextItem(
        'GitHub Copilotコードレビューが導入されているが、copilot-instructions.mdの内容が適切ではないため、ハルシネーション頻度が高く、レビュイー・レビュワー双方が対応しなければならない指摘まで無視してしまう頻度が増えていた。',
        links: <ResumeLink>[
          ResumeLink(
            label: 'GitHub Copilotコードレビュー',
            url:
                'https://docs.github.com/ja/copilot/how-tos/use-copilot-agents/request-a-code-review/use-code-review',
          ),
        ],
      ),
      ResumeTextItem(
        'oss-licenses-pluginが使用されているが、EdgeToEdgeに対応できず、アップデートされる度に無視できない頻度でライセンス情報が表示出来なくなるなど品質に問題を抱えており、対応される速度が非常に遅い。',
        links: <ResumeLink>[
          ResumeLink(
            label: 'oss-licenses-plugin',
            url:
                'https://github.com/google/play-services-plugins/tree/main/oss-licenses-plugin',
          ),
        ],
      ),
      ResumeTextItem(
        'SwiftExportの導入を検討しているが、誰も手が空いておらず導入検討を行うことができていない。',
        links: <ResumeLink>[
          ResumeLink(
            label: 'SwiftExport',
            url: 'https://kotlinlang.org/docs/native-swift-export.html',
          ),
        ],
      ),
      ResumeTextItem(
        'Devinがチームで使用可能になったが、誰も手が空いておらず初期設定やどのように運用していくかを検討できていない。',
        links: <ResumeLink>[
          ResumeLink(label: 'Devin', url: 'https://devin.ai/'),
        ],
      ),
      ResumeTextItem(
        'レガシーな「HostService」パターンがテスタビリティとKMP移行の障壁となっていた。RxJavaベースの実装が多く、Coroutine移行が進んでいない。iOS側との共通化を阻む設計上の問題。',
      ),
      ResumeTextItem('アーキテクチャ決定の経緯が暗黙知化しており、新規メンバーのキャッチアップに時間がかかる。'),
    ],
    approach: <TakumiSection>[
      TakumiSection(
        title: 'PRのレビューを半自動化する大規模なClaudeスキルの作成',
        body: ResumeTextItem(
          'ベースブランチと対象ブランチとの差分をClaudeが検出し、テストプランを組み立てadbコマンドなどを使用してClaudeが自律的に動作確認を行う。一時的なログコードの挿入、スクリーンショット、画面の録画を行うことでエビデンスを収集し動作確認後に該当PRにレポートを投稿する。Claudeの推論に任せる箇所と、シェルによって冪等性を担保する箇所とを分け、スキル発動のたびに冪等性が担保されず結果や出力形式がバラバラになる問題を解決。テスト可能な箇所とテスト不能な箇所とをClaude自身がシェルを使用して判別可能となっており、テストが実施できない場合は改善Issueを投稿する機能も用意しスケール可能としている。現状はADBコマンド等に依存しているためAndroid専用だが、idbやsimctlなどのコマンドを使用することでiOS版も作成可能。',
        ),
      ),
      TakumiSection(
        title: 'Ktorを用いたMockServerの構築',
        body: ResumeTextItem(
          'ClaudeなどのAIエージェントが使用することを前提としたシナリオ・Fixture切り替えをコマンドによって実行可能なMockServerを構築した。このMockServerを使用することで曜日・時間に関係なく任意のシナリオや条件でテストを実行できるようになり、曜日依存や一部前提を整えることが難しいテストを容易に実行可能としテスト効率が向上。単なるスタブではなくステートフルモックとして設計し、BEの送料・冷凍手数料計算ロジックをSTG実測値ベースで簡略化再現することで、商品追加・削除・数量変更に連動した金額再計算をBE依存なしで動作確認可能とした。エンドポイント追加時にフィクスチャ未実装やドキュメント未登録をコンパイル時・起動時・CI時の3段階で検出する型安全な設計とし、チームでの継続開発における品質を構造的に担保した。Claudeを使用することで高速に要件定義から実装・動作確認までを完遂。',
        ),
      ),
      TakumiSection(
        title: 'KMP対応の基盤整備',
        body: ResumeTextItem(
          '@ObjCName、@Throws アノテーションの付与漏れ、fun interface以外の実装違反を検出するシェルを作成し、GitHubActionsでPR作成時に毎回チェックするようにした。ObjCNameアノテーションを必須とすることでiOS側との連携時の名前マングリング問題を防止した。Throwsアノテーションを必須とすることでiOS側でExceptionをキャッチできずにクラッシュする箇所が混入する問題を防止した。単一責任原則をコードで強制しファイルによって記述がバラバラとなり種々の問題を引き起こす可能性を防止。',
          links: <ResumeLink>[
            ResumeLink(
              label: '@ObjCName',
              url:
                  'https://kotlinlang.org/docs/native-objc-interop.html#change-declaration-names',
            ),
            ResumeLink(
              label: '@Throws アノテーションの付与漏れ',
              url:
                  'https://github.com/DroidKaigi/conference-app-2024/issues/954',
            ),
          ],
        ),
      ),
      TakumiSection(
        title: 'copilot-instructions.md の整備',
        body: ResumeTextItem(
          'copilot-instructions.mdのベストプラクティクスに沿って内容が自動で修正されるClaudeのスキルを作成した。上記のSkillを使用しGitHub Copilotへの指示を整理・追加し、PRレビュー時のサジェスト品質を改善した。Copilotを使用しての修正とせずClaude Codeのスキルとしたのは、コンテキストスイッチの防止観点とCopilotで実際に修正を行った上でのUX検討より。',
          links: <ResumeLink>[
            ResumeLink(
              label: 'copilot-instructions.mdのベストプラクティクス',
              url:
                  'https://github.blog/ai-and-ml/unlocking-the-full-power-of-copilot-code-review-master-your-instructions-files/',
            ),
          ],
        ),
      ),
      TakumiSection(
        title: 'oss-licenses-plugin -> AboutLibraries移行',
        body: ResumeTextItem(
          'AboutLibrariesへ移行することでoss-licenses-pluginが抱えている問題を解決。AboutLibrariesはDroidKaigiでも使用されており実績があり、EdgeToEdge対応もスムーズに行えることから選定。',
          links: <ResumeLink>[
            ResumeLink(
              label: 'AboutLibraries',
              url: 'https://github.com/mikepenz/AboutLibraries',
            ),
          ],
        ),
      ),
      TakumiSection(
        title: 'SwiftExportの導入検討検証',
        body: ResumeTextItem(
          '技術調査からプロダクトへの導入可否の判定までを実施。現段階ではalpha版であり、suspend関数がサポートされていないなど基本的な機能が揃っていないことから導入は見送るという結論をレポートしチームへ貢献。',
        ),
      ),
      TakumiSection(
        title: 'Devinを運用可能とし実際にPRを並行で作成させどのように使えるかをチームに示す',
        body: ResumeTextItem(
          'DevinマシンのセットアップとDevinに対応させるのに相応しい内容のIssueを用意し、可能な限り並行で作業させ性能限界を調査。一度に20件のIssueを対応させPRの作成からマージまでを完遂できることを確認。Devinはインターン・ジュニアエンジニアレベルの作業を夜間に任せるのに適しているため、Claudeを使用してDevinが滞りなく作業可能な内容までブレークダウンしたIssueを作成。その際にClaudeからDevin用のタスク用文章を作成するための種々のClaudeのスキルも作成し対応。Devinが提供しているMCPではClaude経由でDevinへ直接指示を与えたりセッション状況の確認ができないので、Devinが提供しているREST APIをClaudeにスキル化させ、スキルを使用することでClaudeと連携し作業可能とする対応も実施。種々のスキルはチームへPRとして公開し、本格導入が決まった際にはそれを基にチームで使用可能にできるよう知見を共有。',
          links: <ResumeLink>[
            ResumeLink(
              label: 'Devin guidelines',
              url:
                  'https://docs.devin.ai/ja/essential-guidelines/when-to-use-devin',
            ),
            ResumeLink(
              label: 'Devin MCP',
              url: 'https://docs.devin.ai/ja/work-with-devin/devin-mcp',
            ),
            ResumeLink(
              label: 'Devin REST API',
              url: 'https://docs.devin.ai/ja/api-reference/overview',
            ),
          ],
        ),
      ),
      TakumiSection(
        title: '開発補助ツールの作成',
        body: ResumeTextItem(
          'Claude A/B連携スキル: claude -p オプションを使用し、要約・指示担当と重い処理担当を分離するワークフローを構築した。',
          links: <ResumeLink>[
            ResumeLink(
              label: 'claude -p オプション',
              url: 'https://code.claude.com/docs/ja/cli-reference',
            ),
          ],
        ),
      ),
      TakumiSection(
        title: 'HostService → UseCase移行, RxJava -> Coroutine移行',
        body: ResumeTextItem(
          '複数モジュールのHostServiceをUseCase層へ置き換えた。同様にRxJavaからCoroutineへ段階的に移行した。',
          links: <ResumeLink>[
            ResumeLink(
              label: '段階的に移行',
              url:
                  'https://kotlinlang.org/api/kotlinx.coroutines/kotlinx-coroutines-rx2/',
            ),
          ],
        ),
      ),
      TakumiSection(
        title: 'ADR策定と命名規則の統一',
        body: ResumeTextItem(
          'UseCaseの命名規則ADRを策定し、17件のUseCaseをADR準拠にリネームした。XXXServiceListener → OnXxxLoadedListener への命名統一を実施した。interface を fun interface に統一する方針をADRとして明文化した。ADRの作成 -> Claudeでスキル化 -> スキルでADRを参照するのでスキルさえ発動すればADRに準拠したコードが自動的に生成される という仕組みにすることでADRの形骸化を防止。',
        ),
      ),
    ],
    ingenuity: <ResumeTextItem>[
      ResumeTextItem('Claudeの活用によって得られた知見をSkill等の形にしてチームへ即座に還元。'),
      ResumeTextItem('追加より削除を重視し、技術的負債の返済を意識した。'),
      ResumeTextItem(
        'ルールではなく、CI/CDやCopilotレビューなどの仕組みを組み合わせ同じミスをチーム全員が繰り返さないようにする。',
      ),
      ResumeTextItem('ADRで設計判断を明文化し、暗黙知の形式知化を進めた。'),
      ResumeTextItem('将来の保守者が「なぜその設計か」を追えるようにした。'),
    ],
  ),
  Experience(
    id: 'newmo',
    employmentType: EmploymentType.contract,
    period: '2025.04 - 2025.06',
    duration: '3ヶ月',
    bizType: 'BtoC & BtoB',
    companyName: 'newmo株式会社',
    projectName: 'newmoタクシー車載タブレットアプリ&乗客用スマートフォンアプリ開発・保守',
    role: '乗客用アプリ・乗務員用アプリ両方の機能追加・保守',
    team: '10人以上',
    collaboration: 'Android/iOS/Web/BE',
    techStack: <String>[
      'Kotlin',
      'Jetpack Compose',
      'Android',
      'GraphQL(Federation)',
      'Kotlin Coroutine',
      'Figma',
      'GoogleMapsAPI',
      'Datadog',
      'Devin',
      'Linear',
      'Slack',
      'MagicPod',
    ],
    overview: <ResumeTextItem>[
      ResumeTextItem(
        '乗客が使用するアプリのストアは此方',
        links: <ResumeLink>[
          ResumeLink(
            label: '乗客用アプリストア',
            url:
                'https://apps.apple.com/us/app/newmo-%E3%83%8B%E3%83%A5%E3%83%BC%E3%83%A2-%E3%82%BF%E3%82%AF%E3%82%B7%E3%83%BC-%E3%83%A9%E3%82%A4%E3%83%89%E3%82%B7%E3%82%A7%E3%82%A2%E3%82%A2%E3%83%97%E3%83%AA/id6738711799?mt=8',
          ),
        ],
      ),
      ResumeTextItem('タクシーの乗務員が使用するタブレットのアプリはストアを使用して公開していない。'),
      ResumeTextItem('モノリポジトリのため、Android/iOS/Web/BE全てが単一のリポジトリにて開発されている。'),
      ResumeTextItem(
        '通信はGraphQLに統一されている。BFFパターンではなくFederationパターンが採用されている。そのため、サブグラフとスーパーグラフが存在する。',
        links: <ResumeLink>[
          ResumeLink(
            label: 'Federationパターン',
            url: 'https://graphql.org/learn/federation/',
          ),
        ],
      ),
      ResumeTextItem(
        '乗客・乗務員両方のアプリはGoogleMap部分などComposeに対応していない部分以外はComposeで画面が構成されている。',
      ),
    ],
    responsibility: <ResumeTextItem>[
      ResumeTextItem('乗客用アプリ・乗務員用アプリ両方の機能追加・保守を担当。'),
      ResumeTextItem('チーム人数は10人以上(担当が固定されていないので、人数は変動)。'),
      ResumeTextItem('リリースは一週間ごとに行われ、当番制で行うため自分も担当。'),
      ResumeTextItem('後半は乗務員用アプリの施策対応やMagicPodを使ったテストケースの追加がメイン。'),
    ],
    challenges: <ResumeTextItem>[
      ResumeTextItem(
        '乗客用アプリはiOS側より開発が遅れていたので、iOSのリリース完了後にAndroidを普段開発していない人もオンボーディングを受けた上でコードを書いている。そのため、Androidの経験の浅いメンバーによって書かれた部分の書き方が推奨の構成と異なる状態となっている。ローディング表示なども入っていないため、ロード中に「さん」など固定文字だけが一瞬見えるような状態となっている。',
      ),
      ResumeTextItem(
        'リリースプロセスの資料があるものの、暗黙知になっている部分が多く、資料を見るだけでは完結しない状態となっている。そのためか、特定の同じ人がずっとリリース作業を担当しており、その人が休めない状態となっていた。',
      ),
      ResumeTextItem(
        '乗務員用アプリの施策対応によって、一部効果音を端末の音量設定を0に設定していても必ず鳴るようにした。音が鳴って欲しくない場面(オフィスでの開発時やQA時)でも音が鳴るようになってしまった。',
      ),
      ResumeTextItem(
        'プロダクトの方針が大きく変わったことで、乗客用アプリの優先度が下がったためアプリのQAコストを削減し、乗務員用アプリへリソースを再配分する必要がある。',
      ),
    ],
    approach: <TakumiSection>[
      TakumiSection(
        title: '乗務員用アプリの構成に合わせたリファクタ',
        body: ResumeTextItem(
          '乗務員用アプリはAndroidの経験が豊富なメンバーによって記述されているため、そちらで使用されているUiStateBuilderを用いてリファクタを行った。',
          links: <ResumeLink>[
            ResumeLink(
              label: 'UiStateBuilder',
              url:
                  'https://github.com/DroidKaigi/conference-app-2023/blob/f255ed2f6f07f9f6f83bc3b15384b9bcf001d8e8/core/ui/src/commonMain/kotlin/io/github/droidkaigi/confsched2023/ui/UiStateBuilder.kt',
            ),
          ],
        ),
      ),
      TakumiSection(
        title: 'ローディング表示の導入',
        body: ResumeTextItem(
          'リファクタと同時にShimmerEffectを導入することで、ローディング表示を導入し固定文字がチラつく状態を解消した。',
          links: <ResumeLink>[
            ResumeLink(
              label: 'ShimmerEffect',
              url: 'https://github.com/valentinilk/compose-shimmer',
            ),
          ],
        ),
      ),
      TakumiSection(
        title: 'リリースプロセス整備',
        body: ResumeTextItem(
          '乗務員用アプリ・乗客用アプリのリリースプロセスの資料を実際にリリース作業を行なって出た不明点をもとに書き直し、リリース作業をしたことが無い人でも資料を見れば必要な手順が分かるようにすることで、単一障害点とならないようにした。SlackのWorkflow Builderを使用してリリース作業に役立つワークフローを追加した。',
        ),
      ),
      TakumiSection(
        title: '効果音のデバッグ設定',
        body: ResumeTextItem(
          'デバッグ設定を利用して、効果音が端末の設定音量に応じて鳴る機能を追加した。DroidKaigi2024にてCompositionLocalProviderを使用していたので、この機能もCompositionLocalProviderを使用してUiStateを介さずに実現した。',
          links: <ResumeLink>[
            ResumeLink(
              label: 'DroidKaigi2024',
              url: 'https://github.com/DroidKaigi/conference-app-2024/pull/880',
            ),
          ],
        ),
      ),
      TakumiSection(
        title: 'MagicPodによるリグレッションテスト自動化',
        body: ResumeTextItem('MagicPodを用いてリグレッションテストの自動化に着手した。'),
      ),
    ],
    ingenuity: <ResumeTextItem>[ResumeTextItem('DroidKaigiの知見を活用した。')],
  ),
  Experience(
    id: 'dwango',
    employmentType: EmploymentType.contract,
    period: '2024.10 - 2025.03',
    duration: '6ヶ月',
    bizType: 'BtoC',
    companyName: '株式会社ドワンゴ（KADOKAWAグループ）',
    projectName: 'Zen Studyアプリ開発・保守',
    role: 'R高対応を中心としたAndroidアプリ改修・技術調査・保守',
    techStack: <String>[
      'Kotlin',
      'Jetpack Compose',
      'Android',
      'RESTAPI',
      'Kotlin Coroutine',
      'RxJava',
      'Robolectric',
      'firebase',
      'OAuth2.0',
      'OIDC',
    ],
    overview: <ResumeTextItem>[
      ResumeTextItem(
        'ストアは此方',
        links: <ResumeLink>[
          ResumeLink(
            label: 'ストア',
            url:
                'https://play.google.com/store/apps/details?id=nico.ed.nnn.zane',
          ),
        ],
      ),
      ResumeTextItem('マルチモジュールだがDIは入っていない。'),
      ResumeTextItem('PresenterとInjectorと呼ばれるクラスによってDIが行われている。'),
      ResumeTextItem(
        'DIは入っていないがRoborazziは入っている',
        links: <ResumeLink>[
          ResumeLink(
            label: 'Roborazzi記事',
            url: 'https://qiita.com/hiesiea/items/237524b68d70ea1fecb6',
          ),
        ],
      ),
      ResumeTextItem('WebViewとNativeの混合構成。'),
    ],
    responsibility: <ResumeTextItem>[
      ResumeTextItem(
        'R高が開学するためそちらに対応するためのアプリの改修と技術調査を主に担当。',
        links: <ResumeLink>[
          ResumeLink(
            label: 'R高',
            url: 'https://nnn.ed.jp/high_school_feature/r_high_school/',
          ),
        ],
      ),
      ResumeTextItem('他にもCrashlyticsで挙がってくるバグの調査・対応も担当。'),
    ],
    challenges: <ResumeTextItem>[
      ResumeTextItem(
        'ログイン導線が変更になるためそれに対応するためにOAuth 2.0 / OIDCに準拠したログインフローを実装する必要がある。',
        links: <ResumeLink>[
          ResumeLink(
            label: 'OAuth 2.0',
            url: 'https://datatracker.ietf.org/doc/html/rfc6749',
          ),
          ResumeLink(
            label: 'OIDC',
            url: 'https://openid.net/developers/how-connect-works/',
          ),
        ],
      ),
      ResumeTextItem(
        'ただし標準的なOIDCのフローやPKCE対応とは異なる実装を求められるため公式ドキュメントで使用が推奨されているAppAuthを使用しない独自実装が必要。',
        links: <ResumeLink>[
          ResumeLink(
            label: 'PKCE',
            url: 'https://datatracker.ietf.org/doc/html/rfc7636',
          ),
          ResumeLink(
            label: '公式ドキュメント',
            url:
                'https://developers.google.com/identity/protocols/oauth2/native-app?hl=ja',
          ),
          ResumeLink(
            label: 'AppAuth',
            url: 'https://github.com/openid/AppAuth-Android',
          ),
        ],
      ),
      ResumeTextItem(
        'AndroidチームにOAuth2.0 / OIDCに知見の有るメンバーが1人も居ないため自分で調べて実装・懸念点の洗い出しを行う必要がある。',
      ),
      ResumeTextItem(
        'レビュー前までに他のメンバーにも知識を付けてもらうための勉強会等をレビューまでに定期的に行う必要がある。レビュー時に他のメンバーにもOAuth2.0 / OIDCの知見が無いとレビューが出来ずタスクが進行できないので理解してもらう事は必須。',
      ),
    ],
    approach: <TakumiSection>[
      TakumiSection(
        title: 'OAuth2.0 / OIDC / PKCE の継続調査と実装',
        body: ResumeTextItem(
          '実装フェーズが複数有るのでそれらに取り組みつつOAuth2.0 / OIDCやPKCEについての知識を深める。',
        ),
      ),
      TakumiSection(
        title: 'ログインフローのセキュリティ検証',
        body: ResumeTextItem('他のメンバーが策定しているフローにセキュリティリスクが存在しないかの検証。'),
      ),
    ],
    ingenuity: <ResumeTextItem>[
      ResumeTextItem(
        '付け焼き刃的に暗記しても意味が無いので毎日OAuth2.0 / OIDCやPKCEについて調べて実装に備えるようにした。',
      ),
      ResumeTextItem(
        'DroidKaigiで得た知見の共有。codeInsightSettings.xmlが設定されておらずCompose以外の不要なクラスがサジェストされていたのでサジェストされないようにした。',
        links: <ResumeLink>[
          ResumeLink(
            label: 'DroidKaigi PR',
            url: 'https://github.com/DroidKaigi/conference-app-2023/pull/589',
          ),
        ],
      ),
    ],
  ),
  Experience(
    id: 'giftmall',
    employmentType: EmploymentType.contract,
    period: '2024.05 - 2024.08',
    duration: '4ヶ月',
    bizType: 'BtoC',
    companyName: '株式会社ギフトモール（LUCHE GROUP）',
    projectName: 'Giftmallアプリ開発・保守',
    role: 'GiftmallAndroidアプリのABテスト対応・保守',
    team: '3人',
    techStack: <String>[
      'Kotlin',
      'Jetpack Compose',
      'Android',
      'RESTAPI',
      'Kotlin Coroutine',
      'RxJava',
      'MVVM',
      'Dagger Hilt',
      'MockK',
      'Kotest',
      'firebase',
    ],
    overview: <ResumeTextItem>[
      ResumeTextItem(
        'ストアは此方',
        links: <ResumeLink>[
          ResumeLink(
            label: 'ストア',
            url: 'https://play.google.com/store/apps/details?id=jp.co.giftmall',
          ),
        ],
      ),
      ResumeTextItem(
        'マルチモジュール構成を取っておりapp/feature/cross_domain/repository等から成る。',
      ),
      ResumeTextItem('WebViewとNativeの混合構成。'),
    ],
    responsibility: <ResumeTextItem>[
      ResumeTextItem('GiftmallAndroidアプリのABテスト対応・保守を主に実施。'),
      ResumeTextItem('チーム人数は3人。'),
    ],
    challenges: <ResumeTextItem>[
      ResumeTextItem(
        'プロパーのAndroidエンジニアが1人で手が足りておらずABテスト対応などが人数が多いiOS側と比べ対応が間に合っていない。',
      ),
      ResumeTextItem('ABテスト対応後のコードの消し忘れなどで使われなくなったコードが多数残ったままになっている。'),
    ],
    approach: <TakumiSection>[
      TakumiSection(
        title: 'Jetpack Composeで構成された画面のABテスト対応',
        body: ResumeTextItem('Jetpack Composeで構成された画面のABテスト対応を主に実施。'),
      ),
      TakumiSection(
        title: 'ボーイスカウト・ルールによる不要コード削除',
        body: ResumeTextItem(
          'ABテスト対応で触った箇所でどこからも参照されていないコードをボーイスカウト・ルールに則り削除。削除が必要な行数が多い場合はタスクを作成し別PRで対応することでレビューし辛い状態にならないように対応。',
        ),
      ),
      TakumiSection(
        title: '既存バグの修正',
        body: ResumeTextItem(
          'ABテスト対応時にキャッシュ(Singleton化されたFlowを持つ簡易キャッシュ)の既存バグを発見しそちらの修正も対応。Flowが<Set<E>>を保持していたのでkey-valueで扱えるMapに変更することで対応。',
        ),
      ),
    ],
    ingenuity: <ResumeTextItem>[
      ResumeTextItem(
        'DroidKaigi2023での貢献を通して得た知見を活用。ABテスト対応でハプティックフィードバックを導入する対応が有ったがDroidKaigiで同様の対応をしているPRを知っていたのでそちらを参照することで機能実装は数分で対応が完了。',
        links: <ResumeLink>[
          ResumeLink(
            label: '参考にしたPR',
            url: 'https://github.com/DroidKaigi/conference-app-2023/pull/1126',
          ),
        ],
      ),
    ],
  ),
];

const personalProjects = <PersonalProject>[
  PersonalProject(
    name: 'fictional-drug-and-disease-ref-flutter(メディマスタ)',
    kind: 'Flutter app',
    summary: '架空医薬品・疾患データを扱う医療リファレンスアプリの参考実装。',
    repoUrl:
        'https://github.com/Corvus400/fictional-drug-and-disease-ref-flutter',
    status: '公開中',
    tags: <String>['Flutter', 'Drift', 'Dio / Retrofit'],
    imageAssetPath: 'assets/images/readme/fddr_flutter_header.png',
  ),
  PersonalProject(
    name: 'fictional-drug-and-disease-ref-mock-server(メディマスタ)',
    kind: 'Ktor Mock Server',
    summary: '医薬品・疾患リファレンスアプリ用の Scenario-based Mock Server。',
    repoUrl:
        'https://github.com/Corvus400/fictional-drug-and-disease-ref-mock-server',
    status: '公開中',
    tags: <String>['Kotlin', 'Ktor 3.x', 'ktor-openapi-tools'],
    imageAssetPath: 'assets/images/readme/fddr_mock_server_header.png',
  ),
  PersonalProject(
    name: 'resume-flutter',
    kind: 'Flutter Web',
    summary: '職務経歴をFlutter Webで構造化表示するための実装リポジトリ。',
    repoUrl: 'https://github.com/Corvus400/resume-flutter',
    status: '公開中',
    tags: <String>['Flutter', 'Dart', 'go_router'],
    imageAssetPath: 'assets/readme/header.png',
  ),
];

const outsideActivityGroups = <OutsideActivityGroup>[
  OutsideActivityGroup(
    label: 'droidkaigi',
    title: 'DroidKaigi',
    count: '4年分',
    items: <OutsideActivity>[
      OutsideActivity(
        period: '2025.08 – 2025.09',
        title: 'DroidKaigi2025 コントリビュート',
        detail: '24日間コントリビュート · Zenn記事',
        links: <ResumeLink>[
          ResumeLink(
            label: 'Zenn',
            url: 'https://zenn.dev/todayama_r/articles/6a4f24033ba7be',
          ),
        ],
      ),
      OutsideActivity(
        period: '2024.08 – 2024.09',
        title: 'DroidKaigi2024 コントリビュート',
        detail: '31日間コントリビュート · Zenn記事 · Welcome Talk · 貢献順位',
        links: <ResumeLink>[
          ResumeLink(
            label: 'Zenn',
            url: 'https://zenn.dev/todayama_r/articles/55ddcb366cbc50',
          ),
          ResumeLink(
            label: 'Welcome Talk',
            url: 'https://x.com/Todayama_R/status/1834398835327861168',
          ),
          ResumeLink(
            label: '貢献順位',
            url: 'https://x.com/Todayama_R/status/1834398443361763519',
          ),
        ],
      ),
      OutsideActivity(
        period: '2023.08 – 2023.09',
        title: 'DroidKaigi2023 コントリビュート',
        detail: '30日間コントリビュート · Zenn記事 · Welcome Talk · 貢献順位',
        links: <ResumeLink>[
          ResumeLink(
            label: 'Zenn',
            url: 'https://zenn.dev/todayama_r/articles/404e358eaac1f1',
          ),
          ResumeLink(
            label: 'Welcome Talk',
            url: 'https://x.com/Todayama_R/status/1702496851340193816?s=20',
          ),
          ResumeLink(
            label: '貢献順位',
            url: 'https://twitter.com/Todayama_R/status/1702496604190847010',
          ),
        ],
      ),
      OutsideActivity(
        period: '2022.09 – 2022.10',
        title: 'DroidKaigi2022 コントリビュート',
        detail: '26日間でPRを38個作成 · Issue 16個消化 · Welcome Talk',
        links: <ResumeLink>[
          ResumeLink(
            label: 'PR',
            url:
                'https://github.com/DroidKaigi/conference-app-2022/pulls?q=is%3Apr+author%3ACorvus400+',
          ),
          ResumeLink(
            label: 'awesome',
            url:
                'https://github.com/DroidKaigi/conference-app-2022/pulls?q=is%3Apr+author%3ACorvus400+is%3Aclosed+label%3Aawesome',
          ),
          ResumeLink(
            label: 'Issue',
            url:
                'https://github.com/DroidKaigi/conference-app-2022/issues?q=is%3Aissue+assignee%3ACorvus400',
          ),
          ResumeLink(
            label: 'YouTube',
            url: 'https://www.youtube.com/watch?v=P8BZw_yCokc&t=5327s',
          ),
        ],
      ),
    ],
  ),
  OutsideActivityGroup(
    label: 'writing',
    title: '執筆',
    count: 'Zenn',
    items: <OutsideActivity>[
      OutsideActivity(
        period: '2025.06',
        title: 'Zenn: DroidKaigi contribution write-ups',
        detail: 'DroidKaigi コントリビュートの振り返り',
        links: <ResumeLink>[
          ResumeLink(
            label: 'DroidKaigi2025',
            url: 'https://zenn.dev/todayama_r/articles/6a4f24033ba7be',
          ),
          ResumeLink(
            label: 'DroidKaigi2024',
            url: 'https://zenn.dev/todayama_r/articles/55ddcb366cbc50',
          ),
          ResumeLink(
            label: 'DroidKaigi2023',
            url: 'https://zenn.dev/todayama_r/articles/404e358eaac1f1',
          ),
        ],
      ),
      OutsideActivity(
        period: '2024.12',
        title: 'Android Developers 翻訳動画',
        detail: '参画先のキャッチアップ時間で話題提供',
        links: <ResumeLink>[
          ResumeLink(label: 'Zenn', url: 'https://zenn.dev/todayama_r'),
        ],
      ),
    ],
  ),
  OutsideActivityGroup(
    label: 'recognition',
    title: '紹介・認知',
    count: 'Welcome Talk',
    items: <OutsideActivity>[
      OutsideActivity(
        period: '2022 – 現在',
        title: 'DroidKaigi community contribution',
        detail: 'Welcome Talk にて紹介',
        links: <ResumeLink>[
          ResumeLink(
            label: '2024 Welcome Talk',
            url: 'https://x.com/Todayama_R/status/1834398835327861168',
          ),
          ResumeLink(
            label: '2023 Welcome Talk',
            url: 'https://x.com/Todayama_R/status/1702496851340193816?s=20',
          ),
          ResumeLink(
            label: '2022 Welcome Talk',
            url: 'https://www.youtube.com/watch?v=P8BZw_yCokc&t=5327s',
          ),
        ],
      ),
      OutsideActivity(
        period: '2023 – 2024',
        title: 'Welcome Talk recognition',
        detail: '貢献順位に関する紹介',
        links: <ResumeLink>[
          ResumeLink(
            label: '2024 貢献順位',
            url: 'https://x.com/Todayama_R/status/1834398443361763519',
          ),
          ResumeLink(
            label: '2023 貢献順位',
            url: 'https://twitter.com/Todayama_R/status/1702496604190847010',
          ),
        ],
      ),
    ],
  ),
];
