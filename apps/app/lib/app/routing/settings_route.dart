part of 'routes.dart';

@immutable
class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage<void>(child: build(context, state));
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}
