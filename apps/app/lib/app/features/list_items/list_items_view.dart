import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/list_items/list_item_row.dart';
import 'package:listwhatever/i18n/strings.g.dart';

enum ListItemsViewMode { list, map }

class ListItemsView extends StatelessWidget {
  const ListItemsView({
    super.key,
    required this.items,
    required this.mode,
    required this.hasLocations,
    required this.onModeChanged,
    required this.onSearchChanged,
    this.onItemTap,
  });

  final List<ListItem> items;
  final ListItemsViewMode mode;
  final bool hasLocations;
  final ValueChanged<ListItemsViewMode> onModeChanged;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<ListItem>? onItemTap;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final surface = context.surface;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        DesignTokens.marginMobile,
        DesignTokens.spacingMd,
        DesignTokens.marginMobile,
        DesignTokens.spacingXl,
      ),
      children: [
        if (hasLocations) ...[
          AnyhooSegmentedControl<ListItemsViewMode>(
            selected: mode,
            onChanged: onModeChanged,
            segments: [
              AnyhooSegment(label: t.listItemsPage.listTab, value: ListItemsViewMode.list),
              AnyhooSegment(label: t.listItemsPage.mapTab, value: ListItemsViewMode.map),
            ],
          ),
          const SizedBox(height: DesignTokens.spacingMd),
        ],
        AnyhooSearchField(
          hint: t.listItemsPage.searchHint,
          onChanged: onSearchChanged,
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        if (items.isEmpty)
          t.listItemsPage.empty.headline(size: HeadlineSize.small, color: surface.secondaryText)
        else
          for (final item in items)
            ListItemRow(
              item: item,
              onTap: onItemTap == null ? null : () => onItemTap!(item),
            ),
      ],
    );
  }
}
