part of 'routes.dart';

@immutable
class NewListRoute extends GoRouteData with $NewListRoute {
  const NewListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NewListPage();
  }
}
