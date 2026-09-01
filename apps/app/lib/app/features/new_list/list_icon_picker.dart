import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';

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

  final List<ListIconOption> icons;
  final IconData selected;
  final ValueChanged<IconData> onSelected;

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
            onTap: () => onSelected(option.icon),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: option.icon == selected ? accent.primaryFixed : surface.containerHigh,
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
              child: SizedBox(
                width: 48,
                height: 48,
                child: Icon(
                  option.icon,
                  color: option.icon == selected ? accent.onPrimaryFixed : surface.primaryText,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
