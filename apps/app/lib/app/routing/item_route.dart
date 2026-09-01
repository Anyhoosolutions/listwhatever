part of 'routes.dart';

@immutable
class ItemRoute extends GoRouteData with $ItemRoute {
  const ItemRoute({required this.itemId});

  final String itemId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => ItemCubit(repository: context.read<ItemsRepository>())..load(itemId),
      child: ItemPage(itemId: itemId),
    );
  }
}
