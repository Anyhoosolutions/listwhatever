part of 'routes.dart';

@immutable
class CounterRoute extends GoRouteData with $CounterRoute {
  const CounterRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage<void>(child: build(context, state));
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => CounterCubit()..load(),
      child: CounterPage(),
    );
  }
}
