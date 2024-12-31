import 'dart:math';

import 'package:flutter/material.dart';
import 'package:listwhatever/helpers/date_format_helper.dart';
import 'package:listwhatever/pages/list/models/list_item.dart';
import 'package:listwhatever/pages/lists/models/list_of_things.dart';

class ListItemTile extends StatelessWidget {
  const ListItemTile({
    required this.list,
    required this.item,
    required this.isLoading,
    super.key,
  });
  final ListItem item;
  final ListOfThings? list;
  final bool isLoading;
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
    final texts = <String>[];

    if (item.info != null && item.info!.isNotEmpty) {
      if (item.info!.length > 60) {
        texts.add('${item.info!.substring(0, min(item.info!.length, 55))}...');
      } else if (item.info!.length > 55) {
        texts.add(item.info!.substring(0, min(item.info!.length, 55)));
      } else {
        texts.add(item.info!);
      }
    }
    if (item.datetime != null) {
      if (list!.withTimes) {
        texts.add(
          DateFormatHelper.formatReadableDate(
            item.datetime!,
            DateFormatType.iso8601andTime,
          ),
        );
      } else {
        texts.add(
          DateFormatHelper.formatReadableDate(
            item.datetime!,
            DateFormatType.iso8601,
          ),
        );
      }
    }
    print('texts: $texts');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: texts.map(Text.new).toList(),
    );
  }
}
