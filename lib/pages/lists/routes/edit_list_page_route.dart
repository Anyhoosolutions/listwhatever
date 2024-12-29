import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/pages/lists/pages/edit_list_page.dart';

@immutable
class EditListPageRoute extends GoRouteData {
  const EditListPageRoute({required this.id});
  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EditListPage(listId: id);
  }
}
