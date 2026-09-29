import 'package:flutter_test/flutter_test.dart';
import 'package:nexplay_mobile/main.dart';

void main() {
  testWidgets('NEXPLAY app boots to splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const NexPlayApp());
    expect(find.text('NEXPLAY'), findsWidgets);
    await tester.pump(const Duration(seconds: 1));
  });
}
