import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/items/item_view.dart';

import 'package:core_models/core_models.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/helpers/starter_widgetbook_host.dart';

@widgetbook.UseCase(name: 'Loaded', type: ItemView, path: 'features/items')
Widget itemViewLoadedUseCase(BuildContext context) {
  return starterViewHost(
    ItemView(
      item: const Item(
        id: '1',
        title: 'Sample item',
        description: 'Widgetbook preview with mock data — no cubit or router.',
      ),
      onRefresh: () async {},
    ),
  );
}
