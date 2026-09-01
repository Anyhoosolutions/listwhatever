import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/list_items/list_items_view.dart';
import 'package:listwhatever/app/features/list_items/list_map_placeholder.dart';
import 'package:listwhatever/app/features/list_items/map_item_peek_sheet.dart';
import 'package:listwhatever/i18n/strings.g.dart';

class ListMapView extends StatelessWidget {
  const ListMapView({
    super.key,
    required this.items,
    required this.selected,
    required this.onModeChanged,
    required this.onItemSelected,
  });

  final List<ListItem> items;
  final ListItem selected;
  final ValueChanged<ListItemsViewMode> onModeChanged;
  final ValueChanged<ListItem> onItemSelected;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Stack(
      children: [
        Positioned.fill(
          child: ListMapPlaceholder(
            items: items,
            selected: selected,
            onItemSelected: onItemSelected,
          ),
        ),
        Positioned(
          top: DesignTokens.spacingMd,
          left: DesignTokens.marginMobile,
          right: DesignTokens.marginMobile,
          child: AnyhooSegmentedControl<ListItemsViewMode>(
            selected: ListItemsViewMode.map,
            onChanged: onModeChanged,
            segments: [
              AnyhooSegment(label: t.listItemsPage.listTab, value: ListItemsViewMode.list),
              AnyhooSegment(label: t.listItemsPage.mapTab, value: ListItemsViewMode.map),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: MapItemPeekSheet(item: selected),
        ),
      ],
    );
  }
}
