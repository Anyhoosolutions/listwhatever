import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:great_circle_distance_calculator/great_circle_distance_calculator.dart';
import 'package:latlong2/latlong.dart';
import 'package:listwhatever/form/form_axis_direction.dart';
import 'package:listwhatever/form/form_generator.dart';
import 'package:listwhatever/form/form_input_field_info.dart';
import 'package:listwhatever/form/form_input_section.dart';
import 'package:listwhatever/helpers/constants.dart';
import 'package:listwhatever/helpers/current_location_cubit.dart';
import 'package:listwhatever/pages/filter/bloc/filters_bloc.dart';
import 'package:listwhatever/pages/filter/bloc/filters_event.dart';
import 'package:listwhatever/pages/filter/bloc/filters_state.dart';
import 'package:listwhatever/pages/list/bloc/list_bloc.dart';
import 'package:listwhatever/pages/list/bloc/list_event.dart';
import 'package:listwhatever/pages/list/bloc/list_state.dart';
import 'package:listwhatever/pages/list/helpers/categories_helper.dart';
import 'package:listwhatever/pages/list/models/filters.dart';
import 'package:listwhatever/pages/list/models/list_item.dart';
import 'package:listwhatever/pages/lists/models/list_of_things.dart';

const String className = 'ListTiles';

enum SectionName {
  basic._('Basic information'),
  categories._('Categories'),
  submit._('Submit');

  const SectionName._(this.value);

  final String value;
}

enum FieldId {
  name._('name'),
  date._('date'),
  distance._('distance'),
  categoryvalue._('categoryvalue'),
  cancel._('cancel'),
  submit._('submit');

  const FieldId._(this.value);

  final String value;
}

final filterFormKey = GlobalKey<FormBuilderState>();

class FilterView extends HookWidget {
  const FilterView({required this.listId, required this.showSubmitButton, super.key});
  final String listId;
  final bool showSubmitButton;

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        BlocProvider.of<ListBloc>(context).add(GetList(listId));
        return null;
      },
      [],
    );

    final listState = context.watch<ListBloc>().state;
    final list = getList(listState);
    final listItems = getListItems(listState);
    final isLoading = getLoading(listState);
    final currentLocation = context.watch<CurrentLocationCubit>().state;
    final filtersState = context.watch<FiltersBloc>().state;
    final filters = getFilters(filtersState);

    if (isLoading) {
      return const CircularProgressIndicator();
    }

    var fields = <FormInputFieldInfo>[];
    if (!isLoading) {
      if (listItems.isEmpty) {
        return noItemsView();
      }

      fields = getFields(
        context: context,
        isLoading: isLoading,
        listItems: listItems,
        list: list!,
        currentPosition: currentLocation,
        filters: filters,
      );
    }

    final sections = getSections(isLoading: isLoading);

    final formGenerator = FormGenerator(
      formKey: filterFormKey,
      sections: sections,
      fields: fields,
      isLoading: isLoading,
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: formGenerator,
      ),
    );
  }

  List<FormInputFieldInfo> getFields({
    required BuildContext context,
    required bool isLoading,
    required List<ListItem> listItems,
    required ListOfThings list,
    required LatLng? currentPosition,
    Filters? filters,
  }) {
    final dateF = dateField(isLoading: isLoading, listItems: listItems, filters: filters);
    final distanceF =
        distanceField(isLoading: isLoading, listItems: listItems, currentPosition: currentPosition, filters: filters);

    final fields = [
      itemNameInputField(isLoading: isLoading, filters: filters),
      if (dateF != null && list.withDates) dateF,
      if (distanceF != null && list.withMap) distanceF,
      ...categoriesFields(filters, CategoriesHelper().getCategories(listItems)),
      resetButton(isLoading: isLoading),
      if (showSubmitButton) submitButton(context: context, isLoading: isLoading, list: list),
    ];
    print('fields: ${fields.length}');
    print('fields: ${fields.map((f) => f.sectionName)}');

    return fields;
  }

  List<FormInputSection> getSections({required bool isLoading}) {
    return [
      FormInputSection(
        name: SectionName.basic.value,
        direction: FormAxisDirection.vertical,
        showBorder: false,
      ),
      FormInputSection(
        name: SectionName.categories.value,
        direction: FormAxisDirection.vertical,
        showBorder: false,
      ),
      FormInputSection(
        name: SectionName.submit.value,
        direction: FormAxisDirection.horizontal,
        showBorder: false,
      ),
    ];
  }

  ListOfThings? getList(ListState listState) {
    if (listState is ListLoaded) {
      return listState.list;
    } else {
      return null;
    }
  }

  bool getLoading(ListState listState) {
    if (listState is ListLoaded) {
      return false;
    } else {
      return true;
    }
  }

  List<ListItem> getListItems(ListState listState) {
    if (listState is ListLoaded) {
      return listState.listItems;
    } else {
      return [];
    }
  }

  FormInputFieldInfo itemNameInputField({required bool isLoading, Filters? filters}) {
    return FormInputFieldInfo.textArea(
      id: FieldId.name.value,
      label: 'Item name',
      currentValue: filters?.itemName ?? '',
      validators: [],
      sectionName: SectionName.basic.value,
      isLoading: isLoading,
    );
  }

  FormInputFieldInfo? dateField({required List<ListItem> listItems, required bool isLoading, Filters? filters}) {
    final minDate = listItems.map((i) => i.datetime ?? Constants.maxDate).reduce((a, b) => a.isBefore(b) ? a : b);
    final maxDate = listItems.map((i) => i.datetime ?? Constants.minDate).reduce((a, b) => a.isAfter(b) ? a : b);

    if (minDate == Constants.maxDate && maxDate == Constants.minDate) {
      return null;
    } else {
      final minV = (minDate.millisecondsSinceEpoch / 1000).floor().toDouble();
      final maxV = (maxDate.millisecondsSinceEpoch / 1000).ceil().toDouble();
      return FormInputFieldInfo.slider(
        id: FieldId.date.value,
        label: 'Date',
        currentValues: (minV, maxV),
        isLoading: isLoading,
        sectionName: SectionName.basic.value,
        range: (minV, maxV),
        type: SliderType.date,
        rangeSlider: true,
        validators: [],
      );
    }
  }

  FormInputFieldInfo? distanceField({
    required List<ListItem> listItems,
    required bool isLoading,
    required LatLng? currentPosition,
    Filters? filters,
  }) {
    if (currentPosition == null) {
      return null;
    }
    final maxDistance = listItems.map((i) => getDistance(currentPosition, i.latLong)).reduce((a, b) => a > b ? a : b);

    if (maxDistance == Constants.maxDistance) {
      return null;
    } else {
      final lowerValue = (filters?.distance?.$1 ?? 0) / 1000;
      final upperValue = min((filters?.distance?.$2 ?? maxDistance * 1000) / 1000, maxDistance);
      final value = (lowerValue, upperValue);
      return FormInputFieldInfo.slider(
        id: FieldId.distance.value,
        label: 'Distance',
        currentValues: value,
        isLoading: isLoading,
        sectionName: SectionName.basic.value,
        range: (0, maxDistance),
        unitName: 'km',
        rangeSlider: true,
        validators: [],
      );
    }
  }

  double getDistance(LatLng currentPosition, LatLng? latLong) {
    final gcd = GreatCircleDistance.fromDegrees(
      latitude1: latLong!.latitude,
      longitude1: latLong.longitude,
      latitude2: currentPosition.latitude,
      longitude2: currentPosition.longitude,
    );
    return (gcd.haversineDistance() / 1000).ceil().toDouble();
  }

  List<FormInputFieldInfo> categoriesFields(
    Filters? filters,
    Map<String, Set<String>> categories,
  ) {
    final chipsFields = categories.entries.map((e) => getCategoryField(filters, e.key, e.value)).toList();

    return chipsFields;
  }

  FormInputFieldInfo getCategoryField(Filters? filters, String categoryName, Set<String> values) {
    final selectedValues = filters?.regularCategoryFilters?[categoryName] ?? values;
    return getCategoriesChipsField(categoryName, values, selectedValues);

    // final type = widget.list.filterTypes[categoryName];
    // return switch (type) {
    //   FilterType.regular => getCategoriesChipsField(categoryName, values),
    //   FilterType.numericRange =>
    //     getCategoriesNumericSliderField(categoryName, values),
    //   FilterType.dateRange =>
    //     getCategoriesDateSliderField(categoryName, values),
    //   FilterType.timeOfDayRange =>
    //     getCategoriesTimeOfDaySliderField(categoryName, values),
    //   null => getCategoriesChipsField(categoryName, values),
    // };
  }

  FormInputFieldInfo getCategoriesChipsField(
    String categoryName,
    Set<String> values,
    Set<String> selectedValues,
  ) {
    print('              values: $values');
    return FormInputFieldInfo.chips(
      id: getCategoryFieldKey(categoryName),
      label: categoryName,
      currentValue: selectedValues,
      values: values.where((e) => e.trim().isNotEmpty),
      validators: [],
      sectionName: SectionName.categories.value,
      isLoading: false,
    );
  }

  String getCategoryFieldKey(String category) {
    return '${FieldId.categoryvalue.name}-$category';
  }

  FormInputFieldInfo resetButton({required bool isLoading}) {
    return FormInputFieldInfo.cancelButton(
      id: FieldId.cancel.value,
      label: 'Reset',
      sectionName: SectionName.submit.value,
      cancel: () {},
      isLoading: isLoading,
    );
  }

  FormInputFieldInfo submitButton({
    required BuildContext context,
    required bool isLoading,
    required ListOfThings list,
  }) {
    return FormInputFieldInfo.submitButton(
      id: FieldId.submit.value,
      label: 'Submit',
      sectionName: SectionName.submit.value,
      isLoading: isLoading,
      save: (values) {
        save(context: context, values: values, list: list);
      },
    );
  }

  void save({required BuildContext context, required Map<String, dynamic>? values, required ListOfThings list}) {
    print('values: $values');
    final distance = values![FieldId.distance.value] != null ? values[FieldId.distance.value] as (int, int) : null;

    final filters = Filters().copyWith(
      itemName: values[FieldId.name.value] as String,
      distance: distance != null ? (distance.$1 * 1000, distance.$2 * 1000) : null,
      regularCategoryFilters: getRegularCategoryFilters(list, values),
      // dateCategoryFilters: getDateCategoryFilters(values),
      // timeOfDayCategoryFilters: getTimeOfDayCategoryFilters(values),
      // numericCategoryFilters: getNumericCategoryFilters(values),
    );
    context.read<FiltersBloc>().add(UpdateFilters(filters));
    GoRouter.of(context).pop();
  }

  Map<String, Set<String>> getRegularCategoryFilters(
    ListOfThings list,
    Map<String, dynamic> values,
  ) {
    final categoryConvertedValues = getConvertedCategories(
      list,
      values,
      FilterType.regular,
      (x) => x as List<String>,
    );

    final categoryFilters = CategoriesHelper.getAllCategoriesAndValuesForListOfCategories(
      categoryConvertedValues,
    );
    return categoryFilters;
  }

  List<MapEntry<String, T>> getConvertedCategories<T>(
    ListOfThings list,
    Map<String, dynamic> values,
    FilterType filterType,
    T Function(dynamic) converter,
  ) {
    final categoryValues = values.entries
        .where((entry) => entry.key.startsWith(FieldId.categoryvalue.name))
        .map((e) => (e.key.split('-')[1], e.value))
        .where(
          (e) =>
              list.filterTypes[e.$1] == filterType ||
              (filterType == FilterType.regular) && list.filterTypes[e.$1] == null,
        )
        .toList();

    final categoryConvertedValues = categoryValues
        .map(
          (entry) => MapEntry(entry.$1, converter(entry.$2)),
        )
        .toList();
    return categoryConvertedValues;
  }

  Filters? getFilters(FiltersState filtersState) {
    if (filtersState is FiltersLoaded) {
      return filtersState.filters;
    }
    return null;
  }

  Widget noItemsView() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No items found'),
          ],
        ),
      ],
    );
  }
}
