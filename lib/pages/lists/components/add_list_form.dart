// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:listwhatever/form/form_axis_direction.dart';
import 'package:listwhatever/form/form_generator.dart';
import 'package:listwhatever/form/form_input_field_info.dart';
import 'package:listwhatever/form/form_input_section.dart';
import 'package:listwhatever/pages/lists/models/list_of_things.dart';

const String className = 'ListTiles';

enum SectionName {
  basic._('Basic information'),
  options._('Options'),
  shared._('Share information'),
  categoryFilterSettings._('Category filter settings'),
  submit._('Submit');

  const SectionName._(this.value);

  final String value;
}

enum FieldId {
  name._('name'),
  listType._('listType'),
  listTypeImage._('listTypeImage'),
  withMap._('withMap'),
  withDates._('withDates'),
  withTimes._('withTimes'),
  categoryFilter._('categoryFilter'),
  cancel._('cancel'),
  submit._('submit');

  const FieldId._(this.value);

  final String value;
}

final addListFormKey = GlobalKey<FormBuilderState>();

class AddListForm extends StatelessWidget {
  const AddListForm({
    required this.list,
    required this.isLoading,
    required this.save,
    required this.userId,
    super.key,
  });
  final ListOfThings? list;
  final bool isLoading;
  final void Function(
    BuildContext context,
    ListOfThings? list,
    Map<String, dynamic> values,
    String userId,
  ) save;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    final fields = [
      nameField(isLoading: isLoading),
      // imagePickerField(list),
      mapCheckboxField(isLoading: isLoading),
      dateCheckboxField(isLoading: isLoading),
      timeCheckboxField(isLoading: isLoading),
      // ...categoryFilterSettings(list, listItems),
      cancelButton(isLoading: isLoading),
      submitButton(context, list, isLoading: isLoading),
    ];

    final sections = [
      FormInputSection(
        name: SectionName.basic.value,
        direction: FormAxisDirection.vertical,
        showBorder: !isLoading,
      ),
      FormInputSection(
        name: SectionName.options.value,
        direction: FormAxisDirection.vertical,
        showBorder: !isLoading,
      ),
      FormInputSection(
        name: SectionName.categoryFilterSettings.value,
        direction: FormAxisDirection.vertical,
        showBorder: !isLoading,
      ),
      FormInputSection(
        name: SectionName.submit.value,
        direction: FormAxisDirection.horizontal,
        showBorder: false,
      ),
    ];

    final formGenerator = FormGenerator(
      formKey: addListFormKey,
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

  FormInputFieldInfo nameField({bool isLoading = false}) {
    return FormInputFieldInfo.textArea(
      id: FieldId.name.value,
      label: 'Name',
      currentValue: list?.name ?? '',
      isLoading: isLoading,
      validators: [
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(70),
      ],
      sectionName: SectionName.basic.value,
    );
  }

  FormInputFieldInfo dateCheckboxField({bool isLoading = false}) {
    return FormInputFieldInfo.checkbox(
      id: FieldId.withDates.value,
      label: 'Use dates',
      currentValue: list?.withDates ?? false,
      validators: [
        FormBuilderValidators.required(),
      ],
      sectionName: SectionName.options.value,
      isLoading: isLoading,
    );
  }

  FormInputFieldInfo timeCheckboxField({bool isLoading = false}) {
    return FormInputFieldInfo.checkbox(
      id: FieldId.withTimes.value,
      label: 'Use time',
      currentValue: list?.withTimes ?? false,
      validators: [
        FormBuilderValidators.required(),
      ],
      sectionName: SectionName.options.value,
      isLoading: isLoading,
    );
  }

  FormInputFieldInfo mapCheckboxField({bool isLoading = false}) {
    return FormInputFieldInfo.checkbox(
      id: FieldId.withMap.value,
      label: 'Use map',
      currentValue: list?.withMap ?? false,
      validators: [
        FormBuilderValidators.required(),
      ],
      sectionName: SectionName.options.value,
      isLoading: isLoading,
    );
  }

  FormInputFieldInfo cancelButton({required bool isLoading}) {
    return FormInputFieldInfo.cancelButton(
      id: FieldId.cancel.value,
      label: 'Cancel',
      sectionName: SectionName.submit.value,
      cancel: () {
        print('cancelled');
      },
      isLoading: isLoading,
    );
  }

  FormInputFieldInfo submitButton(
    BuildContext context,
    ListOfThings? list, {
    required bool isLoading,
  }) {
    return FormInputFieldInfo.submitButton(
      id: FieldId.submit.value,
      label: 'Submit',
      sectionName: SectionName.submit.value,
      save: (Map<String, dynamic>? values) {
        if (values == null) {
          return;
        }
        save(context, list, values, userId!);
      },
      isLoading: isLoading,
    );
  }
}
