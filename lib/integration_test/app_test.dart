import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_app/apps/AppforTest/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end to end test', () {
    testWidgets('tap on floating action button', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text('0'), findsOneWidget);

      final Finder fab = find.byTooltip('Increment');

      await tester.tap(fab);

      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
    });
  });
}
