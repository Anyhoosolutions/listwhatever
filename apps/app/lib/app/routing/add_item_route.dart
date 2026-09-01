part of 'routes.dart';

@immutable
class AddItemRoute extends GoRouteData with $AddItemRoute {
  const AddItemRoute({required this.listId});

  final String listId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AddItemPage(listId: listId);
  }
}
