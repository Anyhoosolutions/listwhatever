import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/app/features/add_item/add_item_view.dart';
import 'package:listwhatever/app/features/add_item/cubit/list_with_items_cubit.dart';
import 'package:listwhatever/app/features/add_item/cubit/list_with_items_state.dart';
import 'package:listwhatever/app/features/add_item/location_search_sheet.dart';
import 'package:listwhatever/app/features/geocoding/coordinate_format.dart';
import 'package:listwhatever/app/features/geocoding/geocoding_result.dart';
import 'package:listwhatever/app/features/list_items/cubit/list_items_cubit.dart';
import 'package:listwhatever/shared/cubit_helpers/state_switcher.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key, required this.listId});

  final String listId;

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _attributeIds = <int>[0];
  var _nextAttributeId = 1;

  @override
  void initState() {
    super.initState();
    context.read<ListWithItemsCubit>().load(widget.listId);
  }

  void _addAttribute() {
    setState(() {
      _attributeIds.add(_nextAttributeId);
      _nextAttributeId += 1;
    });
  }

  Future<void> _searchLocation() async {
    final result = await LocationSearchSheet.show(context);
    if (result == null || !mounted) {
      return;
    }
    _applyLocation(result);
  }

  void _useFakeCurrentLocation() {
    _applyLocation(
      const GeocodingResult(
        displayName: 'Los Angeles, CA, USA',
        latitude: 34.0522,
        longitude: -118.2437,
      ),
    );
  }

  void _applyLocation(GeocodingResult result) {
    final fields = _formKey.currentState?.fields;
    fields?[AddItemFormFields.latitude]?.didChange(formatLatitude(result.latitude));
    fields?[AddItemFormFields.longitude]?.didChange(formatLongitude(result.longitude));
  }

  @override
  Widget build(BuildContext context) {
    final body = StateSwitcher<ListWithItemsCubit, ListWithItemsState, ListWithItems>(
      skeleton: const Text('Loading...'),
      emptyBuilder: (context, cubit) {
        return const Text('No data');
      },
      successBuilder: (context, data, cubit) => AddItemView(
        formKey: _formKey,
        list: data,
        attributeIds: _attributeIds,
        onAddAttribute: _addAttribute,
        onSearchLocation: _searchLocation,
        onUseCurrentLocation: _useFakeCurrentLocation,
        onCreate: () async {
          final formState = _formKey.currentState;
          if (formState == null || !formState.saveAndValidate()) {
            return;
          }

          final values = formState.value;
          final navigator = GoRouter.of(context);

          final latlong = data.hasLocations
              ? {
                  'latitude': _parseLatitude(values[AddItemFormFields.latitude] as String? ?? ''),
                  'longitude': _parseLongitude(values[AddItemFormFields.longitude] as String? ?? ''),
                }
              : <String, double>{};

          final item = ListItem(
            id: '',
            title: values[AddItemFormFields.name] as String? ?? '',
            notes: values[AddItemFormFields.description] as String? ?? '',
            latlong: latlong,
            categoryValues: Map.fromEntries(
              _attributeIds
                  .map(
                    (id) => MapEntry(
                      (values[AddItemFormFields.attributeKey(id)] as String? ?? '').trim(),
                      (values[AddItemFormFields.attributeValue(id)] as String? ?? '').trim(),
                    ),
                  )
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
