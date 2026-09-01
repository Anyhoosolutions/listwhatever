import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lowercase_app_name/app/features/items/item_view.dart';

import 'package:core_models/core_models.dart';

void main() {
  const sampleItem = Item(
    id: '1',
    title: 'Sample item',
    description: 'Loaded from FakeItemsRepository.',
  );

  Widget wrap(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(width: 400, height: 600, child: child),
        ),
      ),
    );
  }

  testWidgets('shows item title and description', (tester) async {
    await tester.pumpWidget(
      wrap(ItemView(item: sampleItem, onRefresh: () async {})),
    );

    expect(find.text('Sample item'), findsOneWidget);
    expect(find.text('Loaded from FakeItemsRepository.'), findsOneWidget);
  });

  testWidgets('refresh button triggers callback', (tester) async {
    var refreshed = false;
    await tester.pumpWidget(
      wrap(
        ItemView(
          item: sampleItem,
          onRefresh: () async {
            refreshed = true;
          },
        ),
      ),
    );

    await tester.tap(find.text('Refresh'));
    await tester.pump();
    expect(refreshed, isTrue);
  });
}
