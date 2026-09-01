import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/add_item/add_item_view.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/helpers/starter_widgetbook_host.dart';

Widget _formChrome(Widget view, {required String title}) {
  return starterViewHost(
    view,
    themeMode: ThemeMode.dark,
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
  late final TextEditingController _name;
  late final TextEditingController _description;
  late final TextEditingController _latitude;
  late final TextEditingController _longitude;
  final _attributes = <AttributeFieldPair>[];

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _description = TextEditingController();
    _latitude = TextEditingController(text: '34.0522° N');
    _longitude = TextEditingController(text: '118.2437° W');
    _attributes.addAll([
      AttributeFieldPair(
        keyController: TextEditingController(),
        valueController: TextEditingController(),
      ),
      AttributeFieldPair(
        keyController: TextEditingController(text: 'Status'),
        valueController: TextEditingController(text: 'In Progress'),
      ),
    ]);
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _latitude.dispose();
    _longitude.dispose();
    for (final attribute in _attributes) {
      attribute.keyController.dispose();
      attribute.valueController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AddItemView(
      nameController: _name,
      descriptionController: _description,
      latitudeController: _latitude,
      longitudeController: _longitude,
      attributes: _attributes,
      onAddAttribute: () {
        setState(() {
          _attributes.add(
            AttributeFieldPair(
              keyController: TextEditingController(),
              valueController: TextEditingController(),
            ),
          );
        });
      },
      onUseCurrentLocation: () {},
      onCreate: () {},
    );
  }
}
