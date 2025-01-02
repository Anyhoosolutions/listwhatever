import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/pages/filter/pages/filter_page.dart';

@immutable
class FilterPageRoute extends GoRouteData {
  const FilterPageRoute({required this.listId});
  final String listId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FilterPage(
      listId: listId,
    );
  }
}
