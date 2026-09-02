import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:anyhoo_form_builder_widgets/anyhoo_form_builder_widgets.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/forms/labeled_form_builder_text_field.dart';

// import 'package:anyhoo_form_builder/anyhoo_form_builder.dart';

class CategoryAttributeRow extends StatelessWidget {
  const CategoryAttributeRow({
    super.key,
    required this.keyFieldName,
    required this.valueFieldName,
    required this.keyHint,
    required this.valueHint,
  });

  final String keyFieldName;
  final String valueFieldName;
  final String keyHint;
  final String valueHint;

  @override
  Widget build(BuildContext context) {
    final types = [
      AnyhooDropdownOption(value: 'elevated', label: 'Size'),
      AnyhooDropdownOption(value: 'filled', label: 'Cost'),
      AnyhooDropdownOption(value: 'text', label: 'Time'),
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnyhooFormBuilderDropdown<String>.single(
          name: keyFieldName,
          options: types,
          initialValue: 'elevated',
          validator: (value) => value == null ? 'Required' : null,
          maxWidth: 130, // TODO: Calculate
        ),
        const SizedBox(width: DesignTokens.spacingSm),
        Expanded(
          child: AnyhooFormBuilderDropdown<String>.multi(
            name: valueFieldName,
            options: types,
            initialValue: const [],
            onCreate: (name) {
              // setState(() {
              //   _tags = [..._tags, AnyhooDropdownOption(value: name, label: name)];
              // });
              return name;
            },
          ),
        ),
        // TODO: Delete button
      ],
    );
  }
}
