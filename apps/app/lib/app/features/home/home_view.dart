import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/home/home_featured_card.dart';
import 'package:listwhatever/app/features/home/home_list_card.dart';
import 'package:listwhatever/app/features/home/list_preview.dart';
import 'package:listwhatever/i18n/strings.g.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
    required this.lists,
    required this.featured,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.onSearchChanged,
    required this.onSettingsTap,
    required this.onProfileTap,
    this.onListTap,
    this.onFeaturedTap,
  });

  final List<ListPreview> lists;
  final FeaturedListPreview featured;
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSettingsTap;
  final VoidCallback onProfileTap;
  final ValueChanged<ListPreview>? onListTap;
  final VoidCallback? onFeaturedTap;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final surface = context.surface;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        DesignTokens.marginMobile,
        DesignTokens.spacingMd,
        DesignTokens.marginMobile,
        DesignTokens.spacingXl,
      ),
      children: [
        Row(
          children: [
            AnyhooRoundButton(onPressed: onProfileTap, icon: Icons.person_outline),
            const Spacer(),
            AnyhooRoundButton(onPressed: onSettingsTap, icon: Icons.settings_outlined),
          ],
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        t.homePage.header.headline(size: HeadlineSize.large),
        const SizedBox(height: DesignTokens.spacingMd),
        AnyhooSearchField(
          hint: t.homePage.searchHint,
          onChanged: onSearchChanged,
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final category in categories) ...[
                AnyhooFilterChip(
                  label: category,
                  selected: category == selectedCategory,
                  onSelected: (_) => onCategorySelected(category),
                ),
                const SizedBox(width: DesignTokens.spacingSm),
              ],
            ],
          ),
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: lists.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: DesignTokens.spacingMd,
            crossAxisSpacing: DesignTokens.spacingMd,
            childAspectRatio: 1.05,
          ),
          itemBuilder: (context, index) {
            final list = lists[index];
            return HomeListCard(
              list: list,
              onTap: onListTap == null ? null : () => onListTap!(list),
            );
          },
        ),
        if (lists.isEmpty) ...[
          const SizedBox(height: DesignTokens.spacingLg),
          t.homePage.empty.headline(size: HeadlineSize.small, color: surface.secondaryText),
        ],
        const SizedBox(height: DesignTokens.spacingMd),
        HomeFeaturedCard(
          featured: featured,
          onTap: onFeaturedTap,
        ),
      ],
    );
  }
}
