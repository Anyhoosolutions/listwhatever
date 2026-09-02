import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';

class ListMapPlaceholder extends StatelessWidget {
  const ListMapPlaceholder({
    super.key,
    required this.items,
    required this.selected,
    this.onItemSelected,
  });

  final List<ListItem> items;
  final ListItem selected;
  final ValueChanged<ListItem>? onItemSelected;

  @override
  Widget build(BuildContext context) {
    final surface = context.surface;
    final accent = context.accent;

    return ColoredBox(
      color: surface.containerHighest,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _MapSketchPainter(lineColor: surface.outline.withValues(alpha: 0.45)),
                ),
              ),
              for (final item in items)
                Positioned(
                  left: 10, // constraints.maxWidth * item.mapX - 12,
                  top: 100, //constraints.maxHeight * item.mapY - 24,
                  child: GestureDetector(
                    onTap: onItemSelected == null ? null : () => onItemSelected!(item),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: item.id == selected.id ? 32 : 24,
                          color: item.id == selected.id ? accent.primaryFixed : surface.secondaryText,
                        ),
                        if (item.id == selected.id)
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: surface.cardBackground,
                              borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: DesignTokens.spacingXs,
                                vertical: 2,
                              ),
                              child: Text(
                                item.title.toUpperCase(),
                                style: AnyhooTypography.label(LabelSize.medium).copyWith(
                                  color: surface.primaryText,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _MapSketchPainter extends CustomPainter {
  const _MapSketchPainter({required this.lineColor});

  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path()
      ..moveTo(size.width * 0.1, size.height * 0.7)
      ..quadraticBezierTo(size.width * 0.35, size.height * 0.2, size.width * 0.6, size.height * 0.55)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.75, size.width * 0.9, size.height * 0.4);

    canvas.drawPath(path, paint);
    canvas.drawLine(
      Offset(size.width * 0.15, size.height * 0.25),
      Offset(size.width * 0.85, size.height * 0.8),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.05, size.height * 0.45),
      Offset(size.width * 0.95, size.height * 0.35),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _MapSketchPainter oldDelegate) => oldDelegate.lineColor != lineColor;
}
