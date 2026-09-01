import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/i18n/strings.g.dart';
import 'package:flutter/services.dart';
import 'package:listwhatever/shared/keys.dart';
import 'package:listwhatever/shared/widgets/staging_banner.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    final path = GoRouterState.of(context).uri.path;
    final selectedIndex = switch (path) {
      _ when path.startsWith('counter') => 1,
      _ when path.startsWith('settings') => 2,
      _ => 0,
    };
    final isHome = path == '/' || path == '/home';
    final isListItems = RegExp(r'^/lists/[^/]+$').hasMatch(path);
    final showBackButton = (path != '/' && path != '/home' && path != '/counter' && path != '/settings');
    final showFab = isHome || isListItems;

    return Scaffold(
      appBar: AnyhooTopBar(
        topBarTitle: isHome ? t.homePage.header : '${t.appName}${(appFlavor == 'production') ? '' : ' (${t.staging})'}',
        onLogoutClick: () {
          // context.read<AnyhooAuthCubit<User>>().logout();
        },
        onSettingsTap: () => context.go('/settings'),
        onProfileTap: () => context.go('/settings'),
        showBackButton: showBackButton,
        onBackTap: () {
          context.pop();
        },
      ),
      floatingActionButton: showFab
          ? FloatingActionButton(
              onPressed: () {
                if (isHome) {
                  context.push('/new-list');
                  return;
                }
                final listId = GoRouterState.of(context).uri.pathSegments.elementAtOrNull(1);
                if (listId != null) {
                  context.push('/lists/$listId/new-item');
                }
              },
              backgroundColor: context.accent.primaryFixed,
              foregroundColor: context.accent.onPrimaryFixed,
              child: const Icon(Icons.add),
            )
          : null,
      body: (appFlavor == 'staging') ? StagingBanner(child: child) : child,
      bottomNavigationBar: AnyhooBottomBar(
        selectedIndex: selectedIndex,
        destinations: [
          AnyhooBottomBarButton(
            key: keys.bottomBarKeys.bottomBarButton(0),
            icon: Icons.home,
            label: t.mainPage.homeTab,
            onTap: () => context.go('/home'),
          ),
          AnyhooBottomBarButton(
            key: keys.bottomBarKeys.bottomBarButton(1),
            icon: Icons.add_circle_outline_rounded,
            label: t.mainPage.counterTab,
            onTap: () => context.go('/counter'),
          ),
          AnyhooBottomBarButton(
            key: keys.bottomBarKeys.bottomBarButton(2),
            icon: Icons.settings,
            label: t.mainPage.settingsTab,
            onTap: () => context.go('/settings'),
          ),
        ],
      ),
    );
  }
}
