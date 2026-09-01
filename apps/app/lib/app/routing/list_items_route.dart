part of 'routes.dart';

@immutable
class ListItemsRoute extends GoRouteData with $ListItemsRoute {
  const ListItemsRoute({required this.listId});

  final String listId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => ListItemsCubit(
        repository: context.read<ListItemsRepository>(),
      )..load(listId),
      child: ListItemsPage(listId: listId),
    );
  }
}
