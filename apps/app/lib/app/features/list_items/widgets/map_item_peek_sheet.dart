import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/i18n/strings.g.dart';
import 'package:core_models/core_models.dart';
import 'package:listwhatever/shared/colorAndIcons/mapping.dart';

class MapItemPeekSheet extends StatelessWidget {
  const MapItemPeekSheet({
    super.key,
    required this.item,
    this.onDirections,
    this.onShare,
    this.onMore,
  });

  final ListItem item;
  final VoidCallback? onDirections;
  final VoidCallback? onShare;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final surface = context.surface;
    final accessLabel = t.listItemsPage.accessPrivate;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: surface.cardBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(DesignTokens.radiusXl)),
        boxShadow: AnyhooCardShell.level1Shadow,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          DesignTokens.marginMobile,
          DesignTokens.spacingSm,
          DesignTokens.marginMobile,
          DesignTokens.spacingMd,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: surface.outline,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const SizedBox(width: 36, height: 4),
              ),
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            Row(
              children: [
                AnyhooChip(
                  label: accessLabel.toUpperCase(),
                  variant: AnyhooChipVariant.primary,
                  shape: AnyhooChipShape.pill,
                ),
                const SizedBox(width: DesignTokens.spacingSm),
                Text(
                  '· ${item.categoryValues['distanceLabel']}',
                  style: AnyhooTypography.body(BodySize.medium).copyWith(
                    color: surface.secondaryText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AnyhooTypography.headline(HeadlineSize.small).copyWith(
                          color: surface.primaryText,
                        ),
                      ),
                      if (item.notes != null) ...[
                        const SizedBox(height: DesignTokens.spacingXs),
                        Text(
                          item.notes!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AnyhooTypography.body(BodySize.medium).copyWith(
                            color: surface.secondaryText,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: DesignTokens.spacingMd),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: ColorMapping.colorFor(item.iconBackground),
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  ),
                  child: SizedBox(
                    width: 72,
                    height: 72,
                    child: Icon(IconMapping.iconDataFor(item.icon), color: Colors.white, size: 32),
                  ),
                ),
              ],
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            Row(
              children: [
                Expanded(
                  child: AnyhooPrimaryButton(
                    label: t.listItemsPage.directions,
                    leadingIcon: Icons.turn_right,
                    onPressed: onDirections ?? () {},
                  ),
                ),
                const SizedBox(width: DesignTokens.spacingSm),
                AnyhooRoundButton(
                  icon: Icons.ios_share,
                  onPressed: onShare ?? () {},
                ),
                const SizedBox(width: DesignTokens.spacingSm),
                AnyhooRoundButton(
                  icon: Icons.more_horiz,
                  onPressed: onMore ?? () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
