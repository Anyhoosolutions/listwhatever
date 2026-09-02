import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:anyhoo_form_builder_widgets/anyhoo_form_builder_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CategoryAttributeRow extends StatelessWidget {
  const CategoryAttributeRow({
    super.key,
    required this.keyFieldName,
    required this.valueFieldName,
    required this.keyHint,
    required this.valueHint,
    required this.categoryKeys,
    required this.valuesFor,
    required this.onCategoryCreated,
    required this.onValueCreated,
    this.initialKey,
  });

  final String keyFieldName;
  final String valueFieldName;
  final String keyHint;
  final String valueHint;
  final List<String> categoryKeys;
  final List<String> Function(String key) valuesFor;
  final ValueChanged<String> onCategoryCreated;
  final void Function(String key, String value) onValueCreated;
  final String? initialKey;

  @override
  Widget build(BuildContext context) {
    final keyOptions = [
      for (final key in categoryKeys) AnyhooDropdownOption(value: key, label: key),
    ];

    return FormBuilderField<String>(
      name: keyFieldName,
      initialValue: initialKey,
      validator: (value) => value == null ? 'Required' : null,
      builder: (keyField) {
        final selectedKey = keyField.value;
        final valueOptions = [
          for (final value in selectedKey == null ? const <String>[] : valuesFor(selectedKey))
            AnyhooDropdownOption(value: value, label: value),
        ];

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnyhooDropdown<String>.single(
              options: keyOptions,
              value: selectedKey,
              hint: keyHint,
              maxWidth: 130,
              onChanged: (value) {
                if (value == keyField.value) {
                  return;
                }
                keyField.didChange(value);
                FormBuilder.of(context)?.fields[valueFieldName]?.didChange(<String>[]);
              },
              onCreate: (name) {
                onCategoryCreated(name);
                return name;
              },
            ),
            const SizedBox(width: DesignTokens.spacingSm),
            Expanded(
              child: AnyhooFormBuilderDropdown<String>.multi(
                name: valueFieldName,
                options: valueOptions,
                hint: valueHint,
                initialValue: const [],
                enabled: selectedKey != null,
                onCreate: selectedKey == null
                    ? null
                    : (name) {
                        onValueCreated(selectedKey, name);
                        return name;
                      },
              ),
            ),
          ],
        );
      },
    );
  }
}
