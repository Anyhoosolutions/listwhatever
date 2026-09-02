import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/shared/colorAndIcons/mapping.dart';

class ListIconOption {
  const ListIconOption({required this.icon});

  final IconData icon;
}

class ListIconPicker extends StatelessWidget {
  const ListIconPicker({
    super.key,
    required this.icons,
    required this.selected,
    required this.onSelected,
  });

  final List<ListItemIcon> icons;
  final ListItemIcon selected;
  final ValueChanged<ListItemIcon> onSelected;

  @override
  Widget build(BuildContext context) {
    final surface = context.surface;
    final accent = context.accent;

    return Wrap(
      spacing: DesignTokens.spacingSm,
      runSpacing: DesignTokens.spacingSm,
      children: [
        for (final option in icons)
          GestureDetector(
            onTap: () => onSelected(option),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: option == selected ? accent.primaryFixed : surface.containerHigh,
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
              child: SizedBox(
                width: 48,
                height: 48,
                child: Icon(
                  IconMapping.iconDataFor(option),
                  color: option == selected ? accent.onPrimaryFixed : surface.primaryText,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
