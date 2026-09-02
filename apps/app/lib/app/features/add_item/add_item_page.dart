import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/app/features/add_item/add_item_form_fields.dart';
import 'package:listwhatever/app/features/add_item/add_item_view.dart';
import 'package:listwhatever/app/features/add_item/category_values_from_items.dart';
import 'package:listwhatever/app/features/add_item/cubit/list_with_items_cubit.dart';
import 'package:listwhatever/app/features/add_item/cubit/list_with_items_state.dart';
import 'package:listwhatever/app/features/add_item/location_search_sheet.dart';
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
  final _attributeIds = <int>[];
  final _initialCategoryKeys = <int, String>{};
  var _nextAttributeId = 0;
  var _didSeedCategories = false;

  @override
  void initState() {
    super.initState();
    context.read<ListWithItemsCubit>().load(widget.listId);
  }

  void _seedCategories(ListWithItems list) {
    if (_didSeedCategories) {
      return;
    }
    _didSeedCategories = true;
    final keys = categoryValuesFromItems(list.items).keys.toList()..sort();
    if (keys.isEmpty) {
      _attributeIds.add(0);
      _nextAttributeId = 1;
      return;
    }
    for (var i = 0; i < keys.length; i++) {
      _attributeIds.add(i);
      _initialCategoryKeys[i] = keys[i];
    }
    _nextAttributeId = keys.length;
  }

  void _addAttribute() {
    setState(() {
      _attributeIds.add(_nextAttributeId);
      _nextAttributeId += 1;
    });
  }

  void _removeAttribute(int id) {
    setState(() {
      _attributeIds.remove(id);
      _initialCategoryKeys.remove(id);
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
    _formKey.currentState?.fields[AddItemFormFields.location]?.didChange(result);
  }

  @override
  Widget build(BuildContext context) {
    final body = StateSwitcher<ListWithItemsCubit, ListWithItemsState, ListWithItems>(
      skeleton: const Text('Loading...'),
      emptyBuilder: (context, cubit) {
        return const Text('No data');
      },
      successBuilder: (context, data, cubit) {
        _seedCategories(data);
        return AddItemView(
          formKey: _formKey,
          list: data,
          attributeIds: _attributeIds,
          initialCategoryKeys: _initialCategoryKeys,
          onAddAttribute: _addAttribute,
          onRemoveAttribute: _removeAttribute,
          onSearchLocation: _searchLocation,
          onUseCurrentLocation: _useFakeCurrentLocation,
          onCreate: () async {
            final formState = _formKey.currentState;
            if (formState == null || !formState.saveAndValidate()) {
              return;
            }

            final values = formState.value;
            final navigator = GoRouter.of(context);

            final location = values[AddItemFormFields.location] as GeocodingResult?;
            final latlong = location == null
                ? <String, double>{}
                : {
                    'latitude': location.latitude,
                    'longitude': location.longitude,
                  };

            final item = ListItem(
              id: '',
              title: values[AddItemFormFields.name] as String? ?? '',
              notes: values[AddItemFormFields.description] as String? ?? '',
              address: location?.displayName,
              latlong: latlong,
              categoryValues: Map.fromEntries(
                _attributeIds
                    .map(
                      (id) => MapEntry(
                        (values[AddItemFormFields.attributeKey(id)] as String? ?? '').trim(),
                        stringValues(values[AddItemFormFields.attributeValue(id)]),
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
        );
      },
    );

    return body;
  }
}
