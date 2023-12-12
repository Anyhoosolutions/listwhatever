import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:listanything/custom/firestore/listItems/list_item.dart';
import 'package:listanything/custom/firestore/listItems/list_items.dart';
import 'package:listanything/custom/firestore/listItems/list_or_list_item_not_loaded_handler.dart';
import 'package:listanything/custom/firestore/lists/lists.dart';
import 'package:listanything/custom/pages/listItems/filters/filter_bloc.dart';
import 'package:listanything/custom/pages/listItems/filters/filters.dart';
import 'package:listanything/custom/pages/listItems/list_items.dart';
import 'package:listanything/standard/widgets/border_with_header.dart';

import 'date_filter.dart';
import 'filter_event.dart';
import 'filter_state.dart';

class SelectedChipsCubit extends Cubit<Set<String>> {
  SelectedChipsCubit() : super({});
  void update(Set<String> selected) => emit(selected);
}

const distanceFieldName = 'distance';
const metersInMile = 1608;

const distanceMin = 0.0;
const distanceMax = 50.0;

class FilterView extends StatefulWidget {
  const FilterView({required this.listId, super.key});
  final String listId;

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  double distanceValue = distanceMax;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    BlocProvider.of<ListBloc>(context).add(LoadList(widget.listId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listState = context.watch<ListBloc>().state;
    final listItemsState = context.watch<ListItemsBloc>().state;

    final filtersState = context.watch<FilterBloc>().state;

    final filtersNotLoadedView = handleFiltersNotLoaded(filtersState);
    if (filtersNotLoadedView != null) {
      return filtersNotLoadedView;
    }
    final filters = (filtersState as FiltersUpdated).filters;
    // logger.d('this filters: $filters');

    final listStateView = ListOrListItemNotLoadedHandler.handleListAndListItemsState(listState, listItemsState);
    if (listStateView != null) {
      return listStateView;
    }

    final list = (listState as ListLoaded).list!;
    final listItems = (listItemsState as ListItemsLoaded).listItems;

    final initialValues = {
      ...filters.categoryFilters,
      startDateFieldName: filters.startDate,
      endDateFieldName: filters.endDate,
    };
    return getFormBuilderWrapper(list, listItems, initialValues);
  }

  Widget getFormBuilderWrapper(ListOfThings list, List<ListItem> listItems, Map<String, dynamic> initialValue) {
    final selectedChips = context.watch<SelectedChipsCubit>().state;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormBuilder(
              key: _formKey,
              onChanged: () {
                _formKey.currentState!.save();
              },
              autovalidateMode: AutovalidateMode.disabled,
              skipDisabled: true,
              initialValue: initialValue,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 16),
                  if (list.withDates) DateFilter(formKey: _formKey),
                  if (list.withMap) ...[
                    const SizedBox(height: 16),
                    getDistanceFilter(), //widget.firestoreUser?.settings),
                  ],
                  const SizedBox(height: 16),
                  ...getCategoriesSections(getCategories(listItems), selectedChips),
                  const SizedBox(height: 16),
                  cancelAndSubmitButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, Set<String>> getCategories(List<ListItem> items) {
    final categories = <String, Set<String>>{};

    for (final item in items) {
      for (final category in item.categories.entries) {
        final categoryName = category.key.trim();
        if (!categories.containsKey(categoryName)) {
          categories[categoryName] = {};
        }
        categories[categoryName]!.addAll(category.value.map((e) => e.trim()));
      }
    }
    return categories;
  }

  bool isSelected(String categoryName, String c, Set<String> selectedChips) {
    return selectedChips.contains('$categoryName-$c');
  }

  Widget getDistanceFilter() {
    return BorderWithHeader(
      title: 'Distance ', //(${settings?.distanceUnit.name})',
      child: FormBuilderField(
        name: distanceFieldName,
        key: const Key(distanceFieldName),
        builder: (FormFieldState<dynamic> field) {
          return FlutterSlider(
            values: [distanceValue],
            max: distanceMax,
            min: distanceMin,
            handler: FlutterSliderHandler(
              decoration: const BoxDecoration(),
              child: const Icon(
                Icons.circle,
                // color: mainColor,
                size: 31,
              ),
            ),
            tooltip: FlutterSliderTooltip(
              format: (s) => s == '$distanceMax' ? '∞' : s,
            ),
            trackBar: FlutterSliderTrackBar(
              inactiveTrackBar: BoxDecoration(
                color: Colors.black12,
                border: Border.all(width: 3), //, color: shadedMainColor),
              ),
              activeTrackBar: const BoxDecoration(), //color: mainColor),
            ),
            onDragCompleted: (handlerIndex, lowerValue, upperValue) {
              setState(() {
                distanceValue = lowerValue as double;
                field.didChange(distanceValue);
              });
            },
          );
        },
      ),
    );
  }

  List<Widget> getCategoriesSections(Map<String, Set<String>> categories, Set<String> selectedChips) {
    return categories.entries.expand((e) {
      final categoryName = e.key;
      final categoryValues = e.value;

      return [
        FormBuilderFilterChip<String>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: categoryName,
          ),
          name: categoryName,
          onChanged: (List<String>? selected) {
            final chips = selected?.map((s) => '$categoryName-$s').toSet();
            context.read<SelectedChipsCubit>().update(chips ?? <String>{});
          },
          selectedColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).primaryColor.withAlpha(100),
          options: categoryValues.map(
            (c) {
              final iconText = isSelected(categoryName, c, selectedChips) ? '' : c[0];
              return FormBuilderChipOption<String>(
                value: c,
                avatar: CircleAvatar(
                  // backgroundColor: mainColor,
                  child: Text(iconText),
                ),
              );
            },
          ).toList(),
        ),
        const SizedBox(
          height: 16,
        ),
      ];
    }).toList();
  }

  Widget cancelAndSubmitButtons() {
    return Row(
      children: <Widget>[
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              _formKey.currentState?.reset();
            },
            child: const Text(
              'Reset',
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.saveAndValidate() ?? false) {
                updateFilters(
                    // widget.firestoreUser?.settings,
                    );
              }
            },
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  void updateFilters() {
    final fields = _formKey.currentState?.fields;

    final categoryFilters = <String, List<String>>{};
    DateTime? startDate;
    DateTime? endDate;
    double? maxDistance;

    for (final field in fields!.entries) {
      if (field.key == startDateFieldName) {
        startDate = field.value.value as DateTime?;
      } else if (field.key == endDateFieldName) {
        endDate = field.value.value as DateTime?;
        } else if (field.key == distanceFieldName) {
          final d = (field.value.value ?? distanceMax) as double;
          maxDistance = convertDistanceToMeters(/*settings,*/ d);
      } else {
        final values = field.value.value as List<String>?;
        if (values != null && values.isNotEmpty) {
          categoryFilters[field.key] = values;
        }
      }
    }
    final filters = Filters(
      categoryFilters: categoryFilters,
      startDate: startDate,
      endDate: endDate,
      distance: maxDistance,
    );
    BlocProvider.of<FilterBloc>(context).add(UpdateFilters(filters));
    GoRouter.of(context).pop();
  }

  double convertDistanceToMeters(/*Settings? settings,*/ double d) {
    return d * metersInMile;
    // return (settings!.distanceUnit == DistanceUnitType.miles)
    //     ? d * metersInMile
    //     : d * 1000;
  }
}