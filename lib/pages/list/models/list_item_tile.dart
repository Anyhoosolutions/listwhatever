import 'dart:math';

import 'package:flutter/material.dart';
import 'package:listwhatever/pages/list/models/list_item.dart';

class ListItemTile extends StatelessWidget {
  const ListItemTile({required this.item, super.key});
  final ListItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // TODO: Break out and support shimmer
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(item.name),
          subtitle: getSubtitle(item),
        ),
      ),
    );
  }

  Widget getSubtitle(ListItem item) {
    if (item.info == null) {
      return const Text('');
    }
    return Text(item.info!.substring(0, min(item.info!.length, 60)));
  }
}
