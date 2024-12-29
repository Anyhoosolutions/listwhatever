import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/pages/list/pages/list_page.dart';
import 'package:listwhatever/pages/lists/pages/add_list_page.dart';

@immutable
class ListPageRoute extends GoRouteData {
  const ListPageRoute({required this.id});
  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    if (id == 'add') {
      return const AddListPage();
    }
    return ListPage(listId: id);
  }
}
