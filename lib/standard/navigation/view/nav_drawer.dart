import 'package:flutter/material.dart';

import '/standard/appUi/colors/app_colors.dart';
import '/standard/appUi/spacing/app_spacing.dart';
import '/standard/appUi/widgets/app_logo.dart';
import '/standard/navigation/widgets/nav_drawer_sections.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  static const _contentPadding = AppSpacing.lg;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(AppSpacing.lg),
        bottomRight: Radius.circular(AppSpacing.lg),
      ),
      child: Drawer(
        backgroundColor: AppColors.darkBackground,
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.only(
            top: kToolbarHeight,
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            bottom: AppSpacing.xlg,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: _contentPadding + AppSpacing.xxs,
                horizontal: _contentPadding,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppLogo.light(),
              ),
            ),
            const _NavDrawerDivider(),
            const NavDrawerSections(),
          ],
        ),
      ),
    );
  }
}

class _NavDrawerDivider extends StatelessWidget {
  const _NavDrawerDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(color: AppColors.outlineOnDark);
  }
}
