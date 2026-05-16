import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:resume_flutter/app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('navigates from hero to experience detail and back', (
    tester,
  ) async {
    await tester.pumpWidget(const ResumeFlutterApp());
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is RichText && widget.text.toPlainText().contains('経験と実装を'),
      ),
      findsOneWidget,
    );

    await tester.tap(find.text('職務経歴').first);
    await tester.pumpAndSettle();

    expect(find.text('最新 4 件 / 全 24 件'), findsOneWidget);

    await tester.tap(find.text('オイシックス・ラ・大地株式会社'));
    await tester.pumpAndSettle();

    expect(
      find.text('Oisix ECアプリ開発 / Androidアプリの機能開発・保守・技術基盤改善'),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const Key('experience-detail-back-link')));
    await tester.pumpAndSettle();

    expect(find.text('最新 4 件 / 全 24 件'), findsOneWidget);
    expect(find.text('newmo株式会社'), findsOneWidget);
  });
}
