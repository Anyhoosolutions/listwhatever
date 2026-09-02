import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/forms/labeled_form_builder_text_field.dart';

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: LabeledFormBuilderTextField(
            name: keyFieldName,
            hint: keyHint,
          ),
        ),
        const SizedBox(width: DesignTokens.spacingSm),
        Expanded(
          child: LabeledFormBuilderTextField(
            name: valueFieldName,
            hint: valueHint,
          ),
        ),
        // TODO: Delete button
      ],
    );
  }
}
