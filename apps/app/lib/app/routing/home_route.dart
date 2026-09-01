part of 'routes.dart';

@immutable
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage<void>(child: build(context, state));
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}
