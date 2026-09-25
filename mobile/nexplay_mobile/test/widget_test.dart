import 'package:flutter_test/flutter_test.dart';
import 'package:nexplay_mobile/main.dart';

void main() {
  testWidgets('NEXPLAY App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const NexPlayApp());
    expect(find.text('NEXPLAY'), findsOneWidget);
  });
}
