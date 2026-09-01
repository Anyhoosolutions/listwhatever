import 'package:anyhoo_auth/cubit/anyhoo_auth_cubit.dart';
import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lowercase_app_name/i18n/strings.g.dart';
import 'package:lowercase_app_name/shared/keys.dart';
import 'package:flutter/services.dart';
import 'package:lowercase_app_name/shared/widgets/staging_banner.dart';

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
    final showBackButton = (path != '/' && path != '/home' && path != '/counter' && path != '/settings');

    return Scaffold(
      appBar: AnyhooTopBar(
        topBarText: '${t.appName}${(appFlavor == 'production') ? '' : ' (${t.staging})'}',
        onLogoutClick: () {
          context.read<AnyhooAuthCubit<User>>().logout();
        },
        showBackButton: showBackButton,
        onBackTap: () {
          context.pop();
        },
      ),
      body: (appFlavor == 'staging') ? StagingBanner(child: child) : child,
      bottomNavigationBar: AnyhooBottomBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (context, index) {
          switch (index) {
            case 0:
              context.go('/home');
            case 1:
              context.go('/counter');
            case 2:
              context.go('/settings');
          }
        },
        destinations: [
          NavigationDestination(
            key: keys.bottomBarKeys.bottomBarButton(0),
            icon: Icon(Icons.home),
            label: t.mainPage.homeTab,
          ),
          NavigationDestination(
            key: keys.bottomBarKeys.bottomBarButton(1),
            icon: Icon(Icons.add_circle_outline_rounded),
            label: t.mainPage.counterTab,
          ),
          NavigationDestination(
            key: keys.bottomBarKeys.bottomBarButton(2),
            icon: Icon(Icons.settings),
            label: t.mainPage.settingsTab,
          ),
        ],
      ),
    );
  }
}
