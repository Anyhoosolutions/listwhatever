import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/home/list_preview.dart';

class HomeFeaturedCard extends StatelessWidget {
  const HomeFeaturedCard({
    super.key,
    required this.featured,
    this.onTap,
  });

  final FeaturedListPreview featured;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnyhooMediaCard(
        title: featured.title,
        image: _MapPlaceholder(badgeLabel: featured.badgeLabel),
        child: Text(featured.subtitle),
      ),
    );
  }
}

class _MapPlaceholder extends StatelessWidget {
  const _MapPlaceholder({required this.badgeLabel});

  final String badgeLabel;

  @override
  Widget build(BuildContext context) {
    final surface = context.surface;
    final accent = context.accent;

    return Stack(
      fit: StackFit.expand,
      children: [
        ColoredBox(
          color: surface.containerHighest,
          child: CustomPaint(
            painter: _MapSketchPainter(
              lineColor: surface.outline.withValues(alpha: 0.45),
            ),
          ),
        ),
        const Align(
          alignment: Alignment(-0.35, -0.1),
          child: Icon(Icons.location_on, color: Color(0xFFEF4444), size: 28),
        ),
        const Align(
          alignment: Alignment(0.25, 0.15),
          child: Icon(Icons.location_on, color: Color(0xFF3B82F6), size: 28),
        ),
        const Align(
          alignment: Alignment(0.05, -0.35),
          child: Icon(Icons.location_on, color: Color(0xFFF59E0B), size: 28),
        ),
        Positioned(
          top: DesignTokens.spacingSm,
          left: DesignTokens.spacingSm,
          child: AnyhooChip(
            label: badgeLabel,
            variant: AnyhooChipVariant.primary,
            shape: AnyhooChipShape.pill,
          ),
        ),
        Positioned(
          top: DesignTokens.spacingSm,
          right: DesignTokens.spacingSm,
          child: Icon(Icons.layers_outlined, color: accent.primaryFixed, size: 20),
        ),
      ],
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
  }

  @override
  bool shouldRepaint(covariant _MapSketchPainter oldDelegate) => oldDelegate.lineColor != lineColor;
}
