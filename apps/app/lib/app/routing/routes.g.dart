// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$appShellRouteData, $loginRoute];

RouteBase get $appShellRouteData => ShellRouteData.$route(
  factory: $AppShellRouteDataExtension._fromState,
  routes: [
    GoRouteData.$route(
      path: '/home',
      name: 'home',
      factory: $HomeRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/new-list',
      name: 'newList',
      factory: $NewListRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/lists/:listId',
      name: 'listItems',
      factory: $ListItemsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/lists/:listId/new-item',
      name: 'addItem',
      factory: $AddItemRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/settings',
      name: 'settings',
      factory: $SettingsRoute._fromState,
    ),
  ],
);

extension $AppShellRouteDataExtension on AppShellRouteData {
  static AppShellRouteData _fromState(GoRouterState state) =>
      const AppShellRouteData();
}

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/home');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $NewListRoute on GoRouteData {
  static NewListRoute _fromState(GoRouterState state) => const NewListRoute();

  @override
  String get location => GoRouteData.$location('/new-list');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ListItemsRoute on GoRouteData {
  static ListItemsRoute _fromState(GoRouterState state) =>
      ListItemsRoute(listId: state.pathParameters['listId']!);

  ListItemsRoute get _self => this as ListItemsRoute;

  @override
  String get location =>
      GoRouteData.$location('/lists/${Uri.encodeComponent(_self.listId)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AddItemRoute on GoRouteData {
  static AddItemRoute _fromState(GoRouterState state) =>
      AddItemRoute(listId: state.pathParameters['listId']!);

  AddItemRoute get _self => this as AddItemRoute;

  @override
  String get location => GoRouteData.$location(
    '/lists/${Uri.encodeComponent(_self.listId)}/new-item',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
  path: '/login',
  name: 'login',
  factory: $LoginRoute._fromState,
);

mixin $LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  @override
  String get location => GoRouteData.$location('/login');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
