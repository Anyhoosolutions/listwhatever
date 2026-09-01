import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/list_items/list_item_preview.dart';
import 'package:listwhatever/app/features/list_items/list_items_view.dart';
import 'package:listwhatever/app/features/list_items/list_map_view.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/helpers/starter_widgetbook_host.dart';

Widget _listItemsChrome(Widget view, {required String title}) {
  return starterViewHost(
    view,
    themeMode: ThemeMode.dark,
    appBar: AnyhooTopBar(topBarTitle: title),
    floatingActionButton: Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () {},
        backgroundColor: context.accent.primaryFixed,
        foregroundColor: context.accent.onPrimaryFixed,
        child: const Icon(Icons.add),
      ),
    ),
    bottomNavigationBar: AnyhooBottomBar(
      selectedIndex: 0,
      destinations: [
        AnyhooBottomBarButton(icon: Icons.home, label: 'Home', onTap: () {}),
        AnyhooBottomBarButton(icon: Icons.add_circle_outline_rounded, label: 'Counter', onTap: () {}),
        AnyhooBottomBarButton(icon: Icons.settings, label: 'Settings', onTap: () {}),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'List', type: ListItemsView, path: 'features/list_items')
Widget listItemsViewUseCase(BuildContext context) {
  return _listItemsChrome(
    const _ListItemsPreview(),
    title: 'Golf Courses',
  );
}

@widgetbook.UseCase(name: 'Map', type: ListMapView, path: 'features/list_items')
Widget listMapViewUseCase(BuildContext context) {
  return _listItemsChrome(
    const _ListMapPreview(),
    title: 'Golf Courses',
  );
}

class _ListItemsPreview extends StatefulWidget {
  const _ListItemsPreview();

  @override
  State<_ListItemsPreview> createState() => _ListItemsPreviewState();
}

class _ListItemsPreviewState extends State<_ListItemsPreview> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final items = ListItemsSampleData.golfCourses.where((item) {
      if (_query.isEmpty) {
        return true;
      }
      final q = _query.toLowerCase();
      return item.title.toLowerCase().contains(q) || item.location.toLowerCase().contains(q);
    }).toList();

    return ListItemsView(
      items: items,
      mode: ListItemsViewMode.list,
      hasLocations: true,
      onModeChanged: (_) {},
      onSearchChanged: (value) => setState(() => _query = value),
    );
  }
}

class _ListMapPreview extends StatefulWidget {
  const _ListMapPreview();

  @override
  State<_ListMapPreview> createState() => _ListMapPreviewState();
}

class _ListMapPreviewState extends State<_ListMapPreview> {
  ListItemPreview _selected = ListItemsSampleData.golfCourses.first;

  @override
  Widget build(BuildContext context) {
    return ListMapView(
      items: ListItemsSampleData.golfCourses,
      selected: _selected,
      onModeChanged: (_) {},
      onItemSelected: (item) => setState(() => _selected = item),
    );
  }
}
