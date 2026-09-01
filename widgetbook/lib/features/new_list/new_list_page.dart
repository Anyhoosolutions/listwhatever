import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/new_list/new_list_view.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/helpers/starter_widgetbook_host.dart';
import 'package:core_models/core_models.dart';

@widgetbook.UseCase(name: 'New List', type: NewListView, path: 'features/new_list')
Widget newListViewUseCase(BuildContext context) {
  return starterViewHost(
    const _NewListPreview(),
    appBar: const AnyhooTopBar(topBarTitle: 'New List', showBackButton: true),
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

class _NewListPreview extends StatefulWidget {
  const _NewListPreview();

  @override
  State<_NewListPreview> createState() => _NewListPreviewState();
}

class _NewListPreviewState extends State<_NewListPreview> {
  late final TextEditingController _name;
  ListItemIcon _icon = ListItemIcon.movie;
  ListItemIconBackground _color = ListItemIconBackground.blue;
  bool _enableMapView = true;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NewListView(
      nameController: _name,
      icons: ListItemIcon.values,
      selectedIcon: _icon,
      onIconSelected: (icon) => setState(() => _icon = icon),
      colors: ListItemIconBackground.values,
      selectedColor: _color,
      onColorSelected: (color) => setState(() => _color = color),
      enableMapView: _enableMapView,
      onEnableMapViewChanged: (value) => setState(() => _enableMapView = value),
      onShareWithFriends: () {},
      onCreate: () {},
    );
  }
}
