import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/app/features/add_item/add_item_view.dart';
import 'package:listwhatever/app/features/list_items/cubit/list_items_cubit.dart';

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
      onCreate: () async {
        final navigator = GoRouter.of(context);

        final lat = double.parse(_latitude.text.replaceAll('° N', '').replaceAll('° S', '').replaceAll('°', ''));
        final lon = double.parse(_longitude.text.replaceAll('° E', '').replaceAll('° W', '').replaceAll('°', ''));

        final item = ListItem(
          id: '',
          title: _name.text,
          notes: _description.text,
          latlong: {'latitude': lat, 'longitude': lon},
          categoryValues: Map.fromEntries(
            _attributes
                .map((e) => MapEntry(e.keyController.text.trim(), e.valueController.text.trim()))
                .where((e) => e.key.isNotEmpty && e.value.isNotEmpty),
          ),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          icon: ListItemIcon.movie,
          iconBackground: ListItemIconBackground.blue,
        );

        await context.read<ListItemsCubit>().create(widget.listId, item);
        if (navigator.canPop()) {
          navigator.pop();
        }
      },
    );
  }
}
