import 'package:anyhoo_auth/anyhoo_auth.dart';
import 'package:anyhoo_core/models/arguments.dart';
import 'package:anyhoo_core/repositories/current_time_repository.dart';
import 'package:anyhoo_logging/anyhoo_logging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lowercase_app_name/app/di/bloc_providers_factory.dart';
import 'package:lowercase_app_name/app/features/items/items_repository.dart';
import 'package:lowercase_app_name/app/main/app_theme.dart';
import 'package:lowercase_app_name/app/main/environments/interfaces/app_repositories.dart';
import 'package:lowercase_app_name/app/main/environments/prod/flavors/flavor_profile.dart';
import 'package:lowercase_app_name/app/routing/create_app_router.dart';
// import 'package:lowercase_app_name/shared/widgets/staging_banner.dart';

import 'package:core_models/core_models.dart';
import 'package:lowercase_app_name/i18n/strings.g.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.authCubit,
    required this.arguments,
    required this.repositories,
    required this.flavorProfile,
    required this.loggingConfiguration,
    required this.loggingCubit,
  });

  final AnyhooAuthCubit<User> authCubit;
  final Arguments arguments;
  final AppRepositories repositories;
  final FlavorProfile flavorProfile;
  final LoggingConfiguration loggingConfiguration;
  final LoggingCubit loggingCubit;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter appRouter;

  @override
  void initState() {
    super.initState();
    appRouter = createAppRouterWithKit(authCubit: widget.authCubit);
  }

  @override
  Widget build(BuildContext context) {
    final materialApp = MaterialApp.router(
      title: widget.flavorProfile.isStaging ? 'My App (Staging)' : 'My App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      locale: TranslationProvider.of(context).flutterLocale, // use provider
      routerConfig: appRouter,
    );

    final app = MultiRepositoryProvider(
      providers: _getRepositoryProviders(),
      child: MultiBlocProvider(
        providers: BlocProvidersFactory.buildAppBlocProviders(
          authCubit: widget.authCubit,
          loggingCubit: widget.loggingCubit,
        ),
        child: materialApp,
      ),
    );
    return app;
  }

  List<RepositoryProvider<dynamic>> _getRepositoryProviders() {
    return [
      RepositoryProvider<AppRepositories>.value(value: widget.repositories),
      RepositoryProvider<Arguments>.value(value: widget.arguments),
      RepositoryProvider<ItemsRepository>(
        create: (_) => widget.repositories.itemsRepository,
      ),
      RepositoryProvider<CurrentTimeRepository>(
        create: (_) => widget.repositories.currentTimeRepository,
      ),
    ];
  }
}
