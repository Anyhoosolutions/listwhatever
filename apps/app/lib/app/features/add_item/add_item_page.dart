import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/add_item/add_item_view.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key, required this.listId});

  final String listId;

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
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

  void _addAttribute() {
    setState(() {
      _attributes.add(
        AttributeFieldPair(
          keyController: TextEditingController(),
          valueController: TextEditingController(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AddItemView(
      nameController: _name,
      descriptionController: _description,
      latitudeController: _latitude,
      longitudeController: _longitude,
      attributes: _attributes,
      onAddAttribute: _addAttribute,
      onUseCurrentLocation: () {},
      onCreate: () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
