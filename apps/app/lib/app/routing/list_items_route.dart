part of 'routes.dart';

@immutable
class ListItemsRoute extends GoRouteData with $ListItemsRoute {
  const ListItemsRoute({required this.listId});

  final String listId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ListItemsPage(
      listId: listId,
      hasLocations: ListItemsSampleData.hasLocations(listId),
    );
  }
}
