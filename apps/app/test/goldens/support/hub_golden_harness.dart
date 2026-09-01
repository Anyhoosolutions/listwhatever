import 'package:anyhoo_core/repositories/current_time_repository.dart';
import 'package:anyhoo_logging/anyhoo_logging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:screenshot_kit/screenshot_kit.dart';
import 'package:listwhatever/app/di/bloc_providers_factory.dart';
import 'package:listwhatever/app/main/app_theme.dart';
import 'package:listwhatever/app/main/environments/fake/mock_auth_cubit.dart';
import 'package:listwhatever/app/routing/app_shell.dart';
import 'package:listwhatever/i18n/strings.g.dart';

final kGoldenFixedNow = DateTime.utc(2026, 4, 19, 12);

/// Plain [MaterialApp] + fake hub DI. Use for goldens that do not need [HubShell].
Widget buildHubGoldenHarness({
  required Widget child,
  DateTime? now,
  ThemeMode? themeMode,
  List<RepositoryProvider<dynamic>> extraRepositoryProviders = const [],
  List<BlocProvider<dynamic>> extraBlocProviders = const [],
}) {
  final fixedNow = now ?? kGoldenFixedNow;
  return _goldenMaterialApp(
    themeMode: themeMode,
    home: providersWrapper(
      fixedNow: fixedNow,
      extraRepositoryProviders: extraRepositoryProviders,
      extraBlocProviders: extraBlocProviders,
      child: child,
    ),
  );
}

/// Same fake DI as [buildHubGoldenHarness], but wraps [shellPage] in [HubShell]
/// behind a [GoRouter] so goldens match the running hub layout.
///
/// - [extraRepositoryProviders] are merged into hub DI (visible to [shellPage]).
/// - [extraBlocProviders] are mounted around [shellPage] (under hub auth/DI),
///   so `create` callbacks can `context.read`.
Widget buildHubGoldenHarnessWithShell({
  required Widget shellPage,
  DateTime? now,
  ThemeMode? themeMode,
  String initialLocation = '/home',
  List<RepositoryProvider<dynamic>> extraRepositoryProviders = const [],
  List<BlocProvider<dynamic>> extraBlocProviders = const [],
}) {
  final fixedNow = now ?? kGoldenFixedNow;

  return _HubShellGoldenHost(
    fixedNow: fixedNow,
    themeMode: themeMode,
    initialLocation: initialLocation,
    shellPage: shellPage,
    extraRepositoryProviders: extraRepositoryProviders,
    extraBlocProviders: extraBlocProviders,
  );
}

Widget providersWrapper({
  required DateTime fixedNow,
  List<RepositoryProvider<dynamic>> extraRepositoryProviders = const [],
  List<BlocProvider<dynamic>> extraBlocProviders = const [],
  required Widget child,
}) {
  return MultiRepositoryProvider(
    providers: [
      RepositoryProvider<CurrentTimeRepository>(
        create: (_) => CurrentTimeRepository(fixedNow),
      ),
      ...extraRepositoryProviders,
    ],
    child: MultiBlocProvider(
      providers: [
        ...BlocProvidersFactory.buildAppBlocProviders(
          authCubit: MockAuthCubit(),
          loggingCubit: LoggingCubit(),
        ),
        ...extraBlocProviders,
      ],
      child: TranslationProvider(
        child: SafeArea(child: child),
      ),
    ),
  );
}

Widget _goldenMaterialApp({
  Widget? home,
  RouterConfig<Object>? routerConfig,
  TransitionBuilder? builder,
  ThemeMode? themeMode,
}) {
  final screenshotConfig = ScreenshotSurfaceConfig.fromEnvironment();
  final resolvedThemeMode = themeMode ?? screenshotConfig.themeMode;

  if (routerConfig != null) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: resolvedThemeMode,
      routerConfig: routerConfig,
      builder: builder,
    );
  }
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    themeMode: resolvedThemeMode,
    home: home,
  );
}

class _HubShellGoldenHost extends StatefulWidget {
  const _HubShellGoldenHost({
    required this.fixedNow,
    required this.initialLocation,
    required this.shellPage,
    this.themeMode,
    this.extraRepositoryProviders = const [],
    this.extraBlocProviders = const [],
  });

  final DateTime fixedNow;
  final ThemeMode? themeMode;
  final String initialLocation;
  final Widget shellPage;
  final List<RepositoryProvider<dynamic>> extraRepositoryProviders;
  final List<BlocProvider<dynamic>> extraBlocProviders;

  @override
  State<_HubShellGoldenHost> createState() => _HubShellGoldenHostState();
}

class _HubShellGoldenHostState extends State<_HubShellGoldenHost> {
  late final GoRouter _router;

  Widget get _page {
    if (widget.extraBlocProviders.isEmpty) {
      return widget.shellPage;
    }
    return MultiBlocProvider(
      providers: widget.extraBlocProviders,
      child: widget.shellPage,
    );
  }

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: widget.initialLocation,
      routes: [
        ShellRoute(
          builder: (context, state, child) => AppShell(child: child),
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => _page,
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _goldenMaterialApp(
      themeMode: widget.themeMode,
      routerConfig: _router,
      builder: (context, child) => providersWrapper(
        fixedNow: widget.fixedNow,
        extraRepositoryProviders: widget.extraRepositoryProviders,
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
