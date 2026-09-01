import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/list_items/cubit/list_items_cubit.dart';
import 'package:listwhatever/app/features/list_items/cubit/list_items_state.dart';
import 'package:listwhatever/app/features/list_items/list_item_preview.dart';
import 'package:listwhatever/app/features/list_items/list_items_skeleton.dart';
import 'package:listwhatever/app/features/list_items/list_items_view.dart';
import 'package:listwhatever/app/features/list_items/list_map_view.dart';
import 'package:listwhatever/shared/cubit_helpers/state_switcher.dart';

class ListItemsPage extends StatelessWidget {
  const ListItemsPage({
    super.key,
    required this.listId,
    this.initialMode = ListItemsViewMode.list,
  });

  final String listId;
  final ListItemsViewMode initialMode;

  @override
  Widget build(BuildContext context) {
    return StateSwitcher<ListItemsCubit, ListItemsState, List<ListItem>>(
      skeleton: const ListItemsSkeleton(),
      successBuilder: (context, items, cubit) {
        return _ListItemsBody(
          items: items.map(ListItemPreview.fromListItem).toList(),
          hasLocations: items.any((item) => item.langlong != null),
          initialMode: initialMode,
        );
      },
    );
  }
}

class _ListItemsBody extends StatefulWidget {
  const _ListItemsBody({
    required this.items,
    required this.hasLocations,
    required this.initialMode,
  });

  final List<ListItemPreview> items;
  final bool hasLocations;
  final ListItemsViewMode initialMode;

  @override
  State<_ListItemsBody> createState() => _ListItemsBodyState();
}

class _ListItemsBodyState extends State<_ListItemsBody> {
  late ListItemsViewMode _mode;
  ListItemPreview? _selected;
  String _query = '';

  List<ListItemPreview> get _filtered {
    if (_query.isEmpty) {
      return widget.items;
    }
    final q = _query.toLowerCase();
    return widget.items.where((item) {
      return item.title.toLowerCase().contains(q) || item.location.toLowerCase().contains(q);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _mode = widget.initialMode;
    _selected = widget.items.isEmpty ? null : widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selected;
    if (_mode == ListItemsViewMode.map && widget.hasLocations && selected != null) {
      return ListMapView(
        items: widget.items,
        selected: selected,
        onModeChanged: (mode) => setState(() => _mode = mode),
        onItemSelected: (item) => setState(() => _selected = item),
      );
    }

    return ListItemsView(
      items: _filtered,
      mode: ListItemsViewMode.list,
      hasLocations: widget.hasLocations,
      onModeChanged: (mode) => setState(() => _mode = mode),
      onSearchChanged: (value) => setState(() => _query = value),
      onItemTap: (item) {
        setState(() {
          _selected = item;
          if (widget.hasLocations) {
            _mode = ListItemsViewMode.map;
          }
        });
      },
    );
  }
}
