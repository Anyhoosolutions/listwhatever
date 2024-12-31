import 'dart:math';

import 'package:flutter/material.dart';
import 'package:listwhatever/helpers/date_format_helper.dart';
import 'package:listwhatever/pages/list/models/list_item.dart';
import 'package:listwhatever/pages/list_item/routes/list_item_info_page_route.dart';
import 'package:listwhatever/pages/lists/models/list_of_things.dart';
import 'package:listwhatever/routing/routes.dart';

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
      // TODO: support shimmer
      padding: const EdgeInsets.only(top: 16),
      child: GestureDetector(
        onTap: () => ListItemInfoPageRoute(listId: list!.id!, itemId: item.id!).push<void>(context),
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
      ),
    );
  }

  Widget getSubtitle(ListItem item) {
    final texts = <String>[];

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
    if (item.info != null && item.info!.isNotEmpty) {
      if (item.info!.length > 60) {
        texts.add('${item.info!.substring(0, min(item.info!.length, 55))}...');
      } else if (item.info!.length > 55) {
        texts.add(item.info!.substring(0, min(item.info!.length, 55)));
      } else {
        texts.add(item.info!);
      }
    }
    print('texts: $texts');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: texts.map(Text.new).toList(),
    );
  }
}
