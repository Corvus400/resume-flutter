// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Resume Flutter';

  @override
  String get homeHeading => 'Flutter Web ポートフォリオ';

  @override
  String get homeSummary =>
      '職務経歴を Flutter native widget で構造化表示するための初期スキャフォールドです。';

  @override
  String get designPending => 'Claude Design 仕様投入待ち';
}
