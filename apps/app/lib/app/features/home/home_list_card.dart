import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/list_items/list_item_row.dart';
import 'package:listwhatever/i18n/strings.g.dart';

class HomeListCard extends StatelessWidget {
  const HomeListCard({
    super.key,
    required this.list,
    this.onTap,
  });

  final DynamicList list;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final surface = context.surface;

    return GestureDetector(
      onTap: onTap,
      child: AnyhooCardShell(
        padding: const EdgeInsets.all(DesignTokens.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorFor(list.iconBackground),
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(DesignTokens.spacingSm),
                    child: Icon(iconDataFor(list.icon), color: Colors.white, size: 20),
                  ),
                ),
                const SizedBox(width: DesignTokens.spacingSm),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: AnyhooChip(
                      label: t.homePage.itemCount(n: list.itemCount),
                      leadingIcon: list.hasLocations ? Icons.location_on_outlined : null,
                      variant: AnyhooChipVariant.surface,
                      shape: AnyhooChipShape.pill,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              list.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.inter.copyWith(
                fontSize: 20,
                height: 28 / 20,
                fontWeight: FontWeight.w600,
                color: surface.primaryText,
              ),
            ),
            const SizedBox(height: DesignTokens.spacingXs),
            Text(
              list.updatedAt.toIso8601String(),
              style: AppFonts.inter.copyWith(
                fontSize: 12,
                height: 16 / 12,
                fontWeight: FontWeight.w400,
                color: surface.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
