import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/app/features/counter/counter_page.dart';
import 'package:listwhatever/app/features/counter/cubit/counter_cubit.dart';
import 'package:listwhatever/app/features/home/home_page.dart';
import 'package:listwhatever/app/features/items/cubit/item_cubit.dart';
import 'package:listwhatever/app/features/items/item_page.dart';
import 'package:listwhatever/app/features/items/items_repository.dart';
import 'package:listwhatever/app/features/login/login_page.dart';
import 'package:listwhatever/app/features/settings/settings_page.dart';
import 'package:listwhatever/app/routing/app_shell.dart';

part 'home_route.dart';
part 'settings_route.dart';
part 'login_route.dart';
part 'item_route.dart';
part 'routes.g.dart';
part 'counter_route.dart';

@TypedShellRoute<AppShellRouteData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeRoute>(path: '/home', name: 'home'),
    TypedGoRoute<SettingsRoute>(path: '/settings', name: 'settings'),
    TypedGoRoute<ItemRoute>(path: '/items/:itemId', name: 'item'),
    TypedGoRoute<CounterRoute>(path: '/counter', name: 'counter'),
  ],
)
@immutable
class AppShellRouteData extends ShellRouteData {
  const AppShellRouteData();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return AppShell(child: navigator);
  }
}
