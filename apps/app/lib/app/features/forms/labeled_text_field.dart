import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  const LabeledTextField({
    super.key,
    required this.hint,
    this.label,
    this.controller,
    this.onChanged,
    this.maxLines = 1,
  });

  final String? label;
  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
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
          child: TextField(
            controller: controller,
            onChanged: onChanged,
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
              contentPadding: const EdgeInsets.all(DesignTokens.spacingMd),
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}
