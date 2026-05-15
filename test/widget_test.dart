import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:resume_flutter/app.dart';

void main() {
  testWidgets('shows the Phase 2 scaffold screen', (tester) async {
    await tester.pumpWidget(const ResumeFlutterApp());
    await tester.pumpAndSettle();

    expect(find.text('Flutter Web ポートフォリオ'), findsOneWidget);
    expect(find.text('Claude Design 仕様投入待ち'), findsOneWidget);
  });

  testWidgets('loads the Insights image asset', (tester) async {
    await tester.pumpWidget(const ResumeFlutterApp());
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsOneWidget);
  });
}
