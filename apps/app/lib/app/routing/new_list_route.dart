part of 'routes.dart';

@immutable
class NewListRoute extends GoRouteData with $NewListRoute {
  const NewListRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return slideTransitionPage(
      context: context,
      state: state,
      child: build(context, state),
    );
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NewListPage();
  }
}
