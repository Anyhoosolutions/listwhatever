import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/app/features/add_item/add_item_view.dart';
import 'package:listwhatever/app/features/add_item/cubit/list_with_items_cubit.dart';
import 'package:listwhatever/app/features/add_item/cubit/list_with_items_state.dart';
import 'package:listwhatever/app/features/list_items/cubit/list_items_cubit.dart';
import 'package:listwhatever/shared/cubit_helpers/state_switcher.dart';

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
    ]);
    (context.read<ListWithItemsCubit>()).load(widget.listId);
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
    final body = StateSwitcher<ListWithItemsCubit, ListWithItemsState, ListWithItems>(
      skeleton: const Text('Loading...'),
      emptyBuilder: (context, cubit) {
        return const Text('No data');
      },
      successBuilder: (context, data, cubit) => AddItemView(
        list: data,
        nameController: _name,
        descriptionController: _description,
        latitudeController: _latitude,
        longitudeController: _longitude,
        attributes: _attributes,
        onAddAttribute: _addAttribute,
        onUseCurrentLocation: () {},
        onCreate: () async {
          final navigator = GoRouter.of(context);

          final lat = _parseLatitude(_latitude.text);
          final lon = _parseLongitude(_longitude.text);

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
      ),
    );

    return body;
  }

  double _parseLatitude(String latitude) {
    final match = RegExp(r'([0-9.]+)° (N|S)').firstMatch(latitude);
    if (match == null) {
      throw Exception('Invalid latitude: $latitude');
    }
    final value = match.group(1);
    final direction = match.group(2);
    if (direction == 'S') {
      return -double.parse(value!);
    }
    return double.parse(value!);
  }

  double _parseLongitude(String longitude) {
    final match = RegExp(r'([0-9.]+)° (E|W)').firstMatch(longitude);
    if (match == null) {
      throw Exception('Invalid longitude: $longitude');
    }
    final value = match.group(1);
    final direction = match.group(2);
    if (direction == 'W') {
      return -double.parse(value!);
    }
    return double.parse(value!);
  }
}
