import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';

class ThemeColorSwatchPicker extends StatelessWidget {
  const ThemeColorSwatchPicker({
    super.key,
    required this.colors,
    required this.selected,
    required this.onSelected,
  });

  final List<Color> colors;
  final Color selected;
  final ValueChanged<Color> onSelected;

  @override
  Widget build(BuildContext context) {
    final surface = context.surface;

    return Wrap(
      spacing: DesignTokens.spacingMd,
      runSpacing: DesignTokens.spacingMd,
      children: [
        for (final color in colors)
          GestureDetector(
            onTap: () => onSelected(color),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: color == selected ? surface.primaryText : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  child: const SizedBox(width: 28, height: 28),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
