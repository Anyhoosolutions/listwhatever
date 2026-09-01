import 'package:flutter/material.dart';

import 'package:core_models/core_models.dart';
import 'package:listwhatever/i18n/strings.g.dart';

class ItemView extends StatelessWidget {
  const ItemView({
    super.key,
    required this.item,
    required this.onRefresh,
  });

  final Item item;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(item.title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(
          item.description,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: onRefresh,
          child: Text(t.itemPage.refreshButton),
        ),
      ],
    );
  }
}
