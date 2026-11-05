// This is a basic Flutter widget test.

import 'package:flutter_test/flutter_test.dart';
import 'package:travel_guide_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TravelGuideApp());
    expect(find.byType(TravelGuideApp), findsOneWidget);
  });
}
