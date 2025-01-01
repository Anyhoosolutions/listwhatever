import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/pages/list/pages/edit_list_item_page.dart';

@immutable
class EditListItemPageRoute extends GoRouteData {
  const EditListItemPageRoute({required this.listId, required this.itemId});
  final String listId;
  final String itemId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EditListItemPage(listId: listId, itemId: itemId);
  }
}
