import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/pages/list/pages/delete_list_page.dart';

@immutable
class DeleteListPageRoute extends GoRouteData {
  const DeleteListPageRoute({required this.id});
  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DeleteListPage(listId: id);
  }
}
