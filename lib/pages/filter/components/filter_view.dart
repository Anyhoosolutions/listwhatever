import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:latlong2/latlong.dart';
import 'package:listwhatever/form/form_axis_direction.dart';
import 'package:listwhatever/form/form_generator.dart';
import 'package:listwhatever/form/form_input_field_info.dart';
import 'package:listwhatever/form/form_input_section.dart';
import 'package:listwhatever/helpers/constants.dart';
import 'package:listwhatever/helpers/current_location_cubit.dart';
import 'package:listwhatever/pages/list/bloc/list_bloc.dart';
import 'package:listwhatever/pages/list/bloc/list_event.dart';
import 'package:listwhatever/pages/list/bloc/list_state.dart';
import 'package:listwhatever/pages/list/models/list_item.dart';
import 'package:listwhatever/pages/lists/models/list_of_things.dart';

const String className = 'ListTiles';

enum SectionName {
  basic._('Basic information'),
  categoryFilterSettings._('Category filter settings');

  const SectionName._(this.value);

  final String value;
}

enum FieldId {
  date._('date'),
  distance._('distance'),

  submit._('submit');

  const FieldId._(this.value);

  final String value;
}

final filterFormKey = GlobalKey<FormBuilderState>();

class FilterView extends HookWidget {
  const FilterView({required this.listId, super.key});
  final String listId;

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

    if (isLoading) {
      return const CircularProgressIndicator();
    }

    final fields = isLoading
        ? <FormInputFieldInfo>[]
        : getFields(
            isLoading: isLoading,
            listItems: listItems,
            list: list!,
            currentPosition: currentLocation,
          );

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
    required bool isLoading,
    required List<ListItem> listItems,
    required ListOfThings list,
    required LatLng? currentPosition,
  }) {
    final dateF = dateField(isLoading: isLoading, listItems: listItems);
    final distanceF = distanceField(isLoading: isLoading, listItems: listItems, currentPosition: currentPosition);
    return [
      if (dateF != null && list.withDates) dateF,
      if (distanceF != null && list.withMap) distanceF,
    ];
  }

  List<FormInputSection> getSections({required bool isLoading}) {
    return [
      FormInputSection(
        name: SectionName.basic.value,
        direction: FormAxisDirection.vertical,
        showBorder: !isLoading,
      ),
      FormInputSection(
        name: SectionName.categoryFilterSettings.value,
        direction: FormAxisDirection.vertical,
        showBorder: !isLoading,
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

  FormInputFieldInfo? dateField({required List<ListItem> listItems, required bool isLoading}) {
    final minDate = listItems.map((i) => i.datetime ?? Constants.maxDate).reduce((a, b) => a.isBefore(b) ? a : b);
    final maxDate = listItems.map((i) => i.datetime ?? Constants.minDate).reduce((a, b) => a.isAfter(b) ? a : b);

    if (minDate == Constants.maxDate && maxDate == Constants.minDate) {
      return null;
    } else {
      return FormInputFieldInfo.slider(
        id: FieldId.date.value,
        label: 'Date',
        currentValues: (minDate.millisecondsSinceEpoch / 1000, maxDate.millisecondsSinceEpoch / 1000),
        isLoading: isLoading,
        sectionName: SectionName.basic.value,
        range: (minDate.millisecondsSinceEpoch / 1000, maxDate.millisecondsSinceEpoch / 1000),
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
  }) {
    if (currentPosition == null) {
      return null;
    }
    final maxDistance = listItems.map((i) => getDistance(currentPosition, i.latLong)).reduce((a, b) => a > b ? a : b);

    if (maxDistance == Constants.maxDistance) {
      return null;
    } else {
      return FormInputFieldInfo.slider(
        id: FieldId.distance.value,
        label: 'Distance',
        currentValues: (0, maxDistance),
        isLoading: isLoading,
        sectionName: SectionName.basic.value,
        range: (0, maxDistance),
        rangeSlider: true,
        validators: [],
      );
    }
  }

  double getDistance(LatLng currentPosition, LatLng? latLong) {
    return 100; // TODO: Implement
  }
}
