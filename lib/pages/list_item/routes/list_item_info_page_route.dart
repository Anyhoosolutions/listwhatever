import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/pages/list_item/pages/list_item_info_page.dart';

@immutable
class ListItemInfoPageRoute extends GoRouteData {
  const ListItemInfoPageRoute({required this.listId, required this.itemId});
  final String listId;
  final String itemId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // if (id == 'add') {
    //   return const AddListPage();
    // }
    return ListItemInfoPage(listId: listId, itemId: itemId);
  }
}
