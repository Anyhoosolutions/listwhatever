part of 'routes.dart';

@TypedGoRoute<LoginRoute>(path: '/login', name: 'login')
@immutable
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage<void>(child: build(context, state));
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }
}
