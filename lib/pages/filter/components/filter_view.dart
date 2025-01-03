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
import 'package:listwhatever/pages/list/models/filters.dart';
import 'package:listwhatever/pages/list/models/list_item.dart';
import 'package:listwhatever/pages/lists/models/list_of_things.dart';

const String className = 'ListTiles';

enum SectionName {
  basic._('Basic information'),
  submit._('Submit');

  const SectionName._(this.value);

  final String value;
}

enum FieldId {
  name._('name'),
  date._('date'),
  distance._('distance'),
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
      resetButton(isLoading: isLoading),
      if (showSubmitButton) submitButton(context: context, isLoading: isLoading),
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
    print('filters: $filters');
    if (currentPosition == null) {
      return null;
    }
    final maxDistance = listItems.map((i) => getDistance(currentPosition, i.latLong)).reduce((a, b) => a > b ? a : b);

    if (maxDistance == Constants.maxDistance) {
      return null;
    } else {
      final value = (
        (filters?.distance?.$1 ?? 0) / 1000,
        min((filters?.distance?.$2 ?? maxDistance * 1000) / 1000, maxDistance),
      );
      print('value: $value');
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

  FormInputFieldInfo resetButton({required bool isLoading}) {
    return FormInputFieldInfo.cancelButton(
      id: FieldId.cancel.value,
      label: 'Reset',
      sectionName: SectionName.submit.value,
      cancel: () {},
      isLoading: isLoading,
    );
  }

  FormInputFieldInfo submitButton({required BuildContext context, required bool isLoading}) {
    return FormInputFieldInfo.submitButton(
      id: FieldId.submit.value,
      label: 'Submit',
      sectionName: SectionName.submit.value,
      isLoading: isLoading,
      save: (values) {
        save(context: context, values: values);
      },
    );
  }

  void save({required BuildContext context, required Map<String, dynamic>? values}) {
    print('values: $values');
    final distance = values![FieldId.distance.value] as (int, int);
    print('distance: $distance');

    final filters = Filters().copyWith(
      itemName: values[FieldId.name.value] as String,
      distance: (distance.$1 * 1000, distance.$2 * 1000),
    );
    context.read<FiltersBloc>().add(UpdateFilters(filters));
    GoRouter.of(context).pop();
  }

  Filters? getFilters(FiltersState filtersState) {
    if (filtersState is FiltersLoaded) {
      return filtersState.filters;
    }
    return null;
  }
}
