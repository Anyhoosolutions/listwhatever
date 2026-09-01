import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/list_items/list_item_preview.dart';
import 'package:listwhatever/app/features/list_items/list_items_view.dart';
import 'package:listwhatever/app/features/list_items/list_map_view.dart';

class ListItemsPage extends StatefulWidget {
  const ListItemsPage({
    super.key,
    required this.listId,
    this.hasLocations = true,
    this.initialMode = ListItemsViewMode.list,
  });

  final String listId;
  final bool hasLocations;
  final ListItemsViewMode initialMode;

  @override
  State<ListItemsPage> createState() => _ListItemsPageState();
}

class _ListItemsPageState extends State<ListItemsPage> {
  late ListItemsViewMode _mode;
  late ListItemPreview _selected;
  String _query = '';

  List<ListItemPreview> get _allItems => ListItemsSampleData.forListId(widget.listId);

  List<ListItemPreview> get _filtered {
    if (_query.isEmpty) {
      return _allItems;
    }
    final q = _query.toLowerCase();
    return _allItems.where((item) {
      return item.title.toLowerCase().contains(q) || item.location.toLowerCase().contains(q);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _mode = widget.initialMode;
    _selected = _allItems.first;
  }

  @override
  Widget build(BuildContext context) {
    if (_mode == ListItemsViewMode.map && widget.hasLocations) {
      return ListMapView(
        items: _allItems,
        selected: _selected,
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
