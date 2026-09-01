import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';

class LocationMapPreview extends StatelessWidget {
  const LocationMapPreview({
    super.key,
    required this.tapToSetLabel,
    this.onTap,
  });

  final String tapToSetLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final surface = context.surface;
    final accent = context.accent;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        child: SizedBox(
          height: 140,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ColoredBox(
                color: surface.containerHighest,
                child: CustomPaint(
                  painter: _MapSketchPainter(lineColor: surface.outline.withValues(alpha: 0.45)),
                ),
              ),
              Align(
                alignment: const Alignment(0, -0.1),
                child: Icon(Icons.location_on, color: accent.primaryFixed, size: 32),
              ),
              Positioned(
                right: DesignTokens.spacingSm,
                bottom: DesignTokens.spacingSm,
                child: AnyhooChip(
                  label: tapToSetLabel,
                  variant: AnyhooChipVariant.primary,
                  shape: AnyhooChipShape.pill,
                  onTap: onTap,
                ),
              ),
            ],
          ),
        ),
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
      ..moveTo(size.width * 0.05, size.height * 0.65)
      ..quadraticBezierTo(size.width * 0.35, size.height * 0.15, size.width * 0.7, size.height * 0.55)
      ..quadraticBezierTo(size.width * 0.85, size.height * 0.75, size.width * 0.95, size.height * 0.35);

    canvas.drawPath(path, paint);
    canvas.drawLine(
      Offset(size.width * 0.1, size.height * 0.3),
      Offset(size.width * 0.9, size.height * 0.8),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _MapSketchPainter oldDelegate) => oldDelegate.lineColor != lineColor;
}
