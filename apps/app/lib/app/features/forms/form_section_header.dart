import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';

class FormSectionHeader extends StatelessWidget {
  const FormSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final surface = context.surface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: AnyhooTypography.label(LabelSize.medium).copyWith(
            color: surface.secondaryText,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: DesignTokens.spacingXs),
          Text(
            subtitle!,
            style: AnyhooTypography.body(BodySize.medium).copyWith(
              color: surface.secondaryText,
            ),
          ),
        ],
      ],
    );
  }
}
