part of 'routes.dart';

@immutable
class AddItemRoute extends GoRouteData with $AddItemRoute {
  const AddItemRoute({required this.listId});

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
    return AddItemPage(listId: listId);
  }
}
