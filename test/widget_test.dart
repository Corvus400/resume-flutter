import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:resume_flutter/app.dart';

void main() {
  testWidgets('shows the Phase 4 hero screen', (tester) async {
    await tester.pumpWidget(const ResumeFlutterApp());
    await tester.pumpAndSettle();

    expect(find.text('職務経歴を見る  →'), findsOneWidget);
    expect(find.textContaining('Android Mobile 8年'), findsOneWidget);
    expect(find.text('DroidKaigi マージPR'), findsOneWidget);
  });

  testWidgets('loads profile image asset', (tester) async {
    await tester.pumpWidget(const ResumeFlutterApp());
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsWidgets);
  });
}
