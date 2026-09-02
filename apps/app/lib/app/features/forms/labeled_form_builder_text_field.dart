import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LabeledFormBuilderTextField extends StatelessWidget {
  const LabeledFormBuilderTextField({
    super.key,
    required this.name,
    required this.hint,
    this.label,
    this.initialValue,
    this.validator,
    this.maxLines = 1,
  });

  final String name;
  final String? label;
  final String hint;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final surface = context.surface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AnyhooTypography.label(LabelSize.medium).copyWith(
              color: surface.secondaryText,
            ),
          ),
          const SizedBox(height: DesignTokens.spacingSm),
        ],
        DecoratedBox(
          decoration: BoxDecoration(
            color: surface.containerHigh,
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            border: Border.all(color: surface.cardBorder.withValues(alpha: 0.4)),
          ),
          child: FormBuilderTextField(
            name: name,
            initialValue: initialValue,
            validator: validator,
            maxLines: maxLines,
            style: AnyhooTypography.body(BodySize.large).copyWith(
              color: surface.primaryText,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AnyhooTypography.body(BodySize.large).copyWith(
                color: surface.secondaryText,
              ),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              errorMaxLines: 2,
              contentPadding: const EdgeInsets.all(DesignTokens.spacingMd),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}
