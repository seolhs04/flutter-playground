import 'package:flutter/material.dart';
import 'package:flutter_app/apps/AppforTest/screens/todo_screen.dart';
import 'package:flutter_app/apps/AppforTest/widgets/my_widget.dart';
import 'package:flutter_app/apps/AppforTest/widgets/scroll_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyWidget has title and message', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: MyWidget(title: 'T', message: 'M'),
    ));

    final titleFinder = find.text('T');
    final messageFinder = find.text('M');

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });

  testWidgets('test scrolling', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
          home: ScrollWidget(
        items: List<String>.generate(10000, (index) => 'Item $index'),
      )),
    );

    final listFinder = find.byType(Scrollable);
    final itemFinder = find.byKey(const ValueKey('item_50'));

    await tester.scrollUntilVisible(itemFinder, 500, scrollable: listFinder);

    expect(itemFinder, findsOneWidget);
  });

  testWidgets('투두리스트 생성, 삭제 테스트', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: TodoScreen()));

    await tester.enterText(find.byType(TextField), 'hi');
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    expect(find.text('hi'), findsOneWidget);

    await tester.drag(find.byType(Dismissible), const Offset(500, 0));
    await tester.pumpAndSettle();
    expect(find.text('hi'), findsNothing);
  });
}
