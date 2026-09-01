import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/list_items/list_item_preview.dart';
import 'package:listwhatever/i18n/strings.g.dart';

class ListItemRow extends StatelessWidget {
  const ListItemRow({
    super.key,
    required this.item,
    this.onTap,
  });

  final ListItemPreview item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final surface = context.surface;
    final accessLabel = switch (item.access) {
      ListItemAccess.public => t.listItemsPage.accessPublic,
      ListItemAccess.private => t.listItemsPage.accessPrivate,
    };

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingSm),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: item.iconBackground,
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
              child: SizedBox(
                width: 64,
                height: 64,
                child: Icon(item.icon, color: Colors.white, size: 28),
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
                  const SizedBox(height: 2),
                  Text(
                    t.listItemsPage.metaLine(access: accessLabel.toUpperCase(), par: item.par),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AnyhooTypography.label(LabelSize.medium).copyWith(
                      color: surface.secondaryText,
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
                            rating: item.rating.toStringAsFixed(1),
                            location: item.location,
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
