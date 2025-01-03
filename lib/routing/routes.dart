import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/pages/auth/routes/login_page_route.dart';
import 'package:listwhatever/pages/filter/routes/filter_page_route.dart';
import 'package:listwhatever/pages/list/routes/add_list_item_page_route.dart';
import 'package:listwhatever/pages/list/routes/edit_list_item_page_route.dart';
import 'package:listwhatever/pages/list/routes/lists_page_route.dart';
import 'package:listwhatever/pages/list_item/routes/list_item_info_page_route.dart';
import 'package:listwhatever/pages/lists/pages/lists_page.dart';
import 'package:listwhatever/pages/lists/routes/add_list_page_route.dart';
import 'package:listwhatever/pages/lists/routes/edit_list_page_route.dart';
import 'package:listwhatever/pages/lists/routes/lists_page_route.dart';

part 'routes.g.dart';

@TypedGoRoute<MainPageRoute>(
  path: '/lists',
  routes: [
    TypedGoRoute<ListPageRoute>(
      path: 'lists/:id',
      name: 'items',
    ),
    TypedGoRoute<AddListItemPageRoute>(
      path: 'add',
      name: 'addListItem',
    ),
    TypedGoRoute<EditListPageRoute>(
      path: 'lists/:id/edit',
      name: 'editList',
    ),
    TypedGoRoute<AddListPageRoute>(
      path: 'lists/add',
      name: 'addList',
    ),
    TypedGoRoute<ListItemInfoPageRoute>(
      path: 'lists/:listId/items/:itemId',
      name: 'listiteminfo',
    ),
    TypedGoRoute<EditListItemPageRoute>(
      path: 'lists/:listId/items/:itemId/edit',
      name: 'editlistitem',
    ),

    TypedGoRoute<FilterPageRoute>(
      path: 'lists/:listId/filter',
      name: 'filter',
    ),
    // TypedGoRoute<UserProfilePageRoute>(
    //   path: 'user_profile',
    //   name: 'user_profile',
    // ),
    TypedGoRoute<LoginPageRoute>(
      path: 'login',
      name: 'login',
    ),
  ],
)
@immutable
class MainPageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ListsPage();
  }
}
