part of 'routes.dart';

@immutable
class ListItemsRoute extends GoRouteData with $ListItemsRoute {
  const ListItemsRoute({required this.listId});

  final String listId;

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
    return BlocProvider(
      create: (context) => ListItemsCubit(
        repository: context.read<ListItemsRepository>(),
      )..load(listId),
      child: ListItemsPage(listId: listId),
    );
  }
}
