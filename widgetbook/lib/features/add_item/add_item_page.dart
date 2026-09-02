import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:listwhatever/app/features/add_item/add_item_view.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/helpers/starter_widgetbook_host.dart';

Widget _formChrome(Widget view, {required String title}) {
  return starterViewHost(
    view,
    appBar: AnyhooTopBar(topBarTitle: title, showBackButton: true, onBackTap: () {}),
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

@widgetbook.UseCase(name: 'Add Item', type: AddItemView, path: 'features/add_item')
Widget addItemViewUseCase(BuildContext context) {
  return _formChrome(
    const _AddItemPreview(),
    title: 'Add New Item',
  );
}

class _AddItemPreview extends StatefulWidget {
  const _AddItemPreview();

  @override
  State<_AddItemPreview> createState() => _AddItemPreviewState();
}

class _AddItemPreviewState extends State<_AddItemPreview> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _attributeIds = <int>[0, 1];

  @override
  Widget build(BuildContext context) {
    return AddItemView(
      formKey: _formKey,
      list: ListWithItems(
        id: '1',
        ownerId: '1',
        title: 'Test List',
        description: 'Test Description',
        visibility: 'private',
        collaboratorIds: [],
        items: [],
        hasLocations: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        icon: null,
        iconBackground: null,
      ),
      attributeIds: _attributeIds,
      onAddAttribute: () {
        setState(() {
          _attributeIds.add(_attributeIds.length);
        });
      },
      onSearchLocation: () {},
      onUseCurrentLocation: () {},
      onCreate: () {},
    );
  }
}
