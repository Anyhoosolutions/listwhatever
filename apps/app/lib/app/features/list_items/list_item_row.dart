import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/i18n/strings.g.dart';

class ListItemRow extends StatelessWidget {
  const ListItemRow({
    super.key,
    required this.item,
    this.onTap,
  });

  final ListItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final surface = context.surface;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingSm),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: colorFor(item.iconBackground),
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
              child: SizedBox(
                width: 64,
                height: 64,
                child: Icon(iconDataFor(item.icon), color: Colors.white, size: 28),
              ),
            ),
            const SizedBox(width: DesignTokens.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AnyhooTypography.label(LabelSize.large).copyWith(
                      color: surface.primaryText,
                    ),
                  ),

                  const SizedBox(height: DesignTokens.spacingXs),
                  Row(
                    children: [
                      Icon(Icons.star, size: 14, color: context.accent.headline),
                      const SizedBox(width: DesignTokens.spacingXs),
                      Flexible(
                        child: Text(
                          t.listItemsPage.ratingLine(
                            rating: item.categoryValues['rating']?.toStringAsFixed(1) ?? '',
                            location: '', // item.address,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AnyhooTypography.body(BodySize.medium).copyWith(
                            color: surface.secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: surface.outline, size: 24),
          ],
        ),
      ),
    );
  }
}

IconData iconDataFor(ListItemIcon? icon) {
  return switch (icon) {
    ListItemIcon.movie => Icons.movie_outlined,
    ListItemIcon.restaurant => Icons.restaurant_outlined,
    ListItemIcon.hotel => Icons.hotel_outlined,
    ListItemIcon.flight => Icons.flight_outlined,
    ListItemIcon.car => Icons.directions_car_outlined,
    ListItemIcon.train => Icons.train_outlined,
    ListItemIcon.bus => Icons.directions_bus_outlined,
    ListItemIcon.flag => Icons.flag_outlined,
    ListItemIcon.park => Icons.park_outlined,
    ListItemIcon.golfCourse => Icons.golf_course_outlined,
    ListItemIcon.eco => Icons.eco_outlined,
    ListItemIcon.waves => Icons.waves_outlined,
    null => Icons.place_outlined,
  };
}

Color colorFor(ListItemIconBackground? background) {
  return switch (background) {
    ListItemIconBackground.red => const Color(0xFFEF4444),
    ListItemIconBackground.green => const Color(0xFF166534),
    ListItemIconBackground.blue => const Color(0xFF1D4ED8),
    ListItemIconBackground.yellow => const Color(0xFFF59E0B),
    ListItemIconBackground.purple => const Color(0xFF4338CA),
    null => const Color(0xFF64748B),
  };
}
