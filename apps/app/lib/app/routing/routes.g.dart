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
      path: '/settings',
      name: 'settings',
      factory: $SettingsRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/items/:itemId',
      name: 'item',
      factory: $ItemRoute._fromState,
    ),
    GoRouteData.$route(
      path: '/counter',
      name: 'counter',
      factory: $CounterRoute._fromState,
    ),
  ],
);

extension $AppShellRouteDataExtension on AppShellRouteData {
  static AppShellRouteData _fromState(GoRouterState state) => const AppShellRouteData();
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
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

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
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ItemRoute on GoRouteData {
  static ItemRoute _fromState(GoRouterState state) => ItemRoute(itemId: state.pathParameters['itemId']!);

  ItemRoute get _self => this as ItemRoute;

  @override
  String get location => GoRouteData.$location('/items/${Uri.encodeComponent(_self.itemId)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CounterRoute on GoRouteData {
  static CounterRoute _fromState(GoRouterState state) => const CounterRoute();

  @override
  String get location => GoRouteData.$location('/counter');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

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
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
