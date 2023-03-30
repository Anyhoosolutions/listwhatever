import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:listanything/app/pages/list_items/list_items_page.dart';

@immutable
class ListItemsPageRoute extends GoRouteData {
  const ListItemsPageRoute({required this.shareCode});

  final String shareCode;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ListItemsPage(shareCode: shareCode);
  }
}
