import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/forms/labeled_text_field.dart';

class CategoryAttributeRow extends StatelessWidget {
  const CategoryAttributeRow({
    super.key,
    required this.keyController,
    required this.valueController,
    required this.keyHint,
    required this.valueHint,
  });

  final TextEditingController keyController;
  final TextEditingController valueController;
  final String keyHint;
  final String valueHint;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: LabeledTextField(
            hint: keyHint,
            controller: keyController,
          ),
        ),
        SizedBox(width: DesignTokens.spacingSm),
        Expanded(
          child: LabeledTextField(
            hint: valueHint,
            controller: valueController,
          ),
        ),
        // TODO: Delete button
      ],
    );
  }
}
