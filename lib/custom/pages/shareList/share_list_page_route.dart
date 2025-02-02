import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/custom/pages/shareList/share_list_page.dart';

@immutable
class ShareListPageRoute extends GoRouteData {
  const ShareListPageRoute(this.actualListId);
  final String actualListId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ShareListPage(actualListId: actualListId);
  }
}
