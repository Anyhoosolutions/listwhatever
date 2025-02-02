import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/custom/pages/listItems/filters/show_filter_cubit.dart';
import 'package:listwhatever/custom/pages/lists/categories_for_list/categories_for_list_bloc.dart';
import 'package:listwhatever/custom/pages/lists/page/list_type_cubit/list_type_cubit.dart';
import 'package:listwhatever/standard/firebase/firebaseStorageBloc/bloc/firebase_storage_bloc.dart';

import '/custom/currentLocationBloc/current_location_bloc.dart';
import '/custom/navigation/get_router_provider_information.dart';
import '/custom/navigation/routes.dart';
import '/custom/pages/listItems/filters/bloc/filter_bloc.dart';
import '/custom/pages/listItems/listItemsListView/list_items_sort_order_cubit.dart';
import '/custom/pages/listItems/listItemsPage/list_items_page_view_cubit.dart';
import '/custom/pages/listItems/list_item_crud_bloc/list_item_crud_bloc.dart';
import '/custom/pages/listItems/list_item_load_bloc/list_item_load_bloc.dart';
import '/custom/pages/listItems/list_items_load_bloc/list_items_load_bloc.dart';
import '/custom/pages/listItems/searchLocation/search_location_bloc.dart';
import '/custom/pages/listItems/service/list_items_service.dart';
import '/custom/pages/lists/list_crud_events/list_crud_bloc.dart';
import '/custom/pages/lists/list_load_events/list_load_bloc.dart';
import '/custom/pages/lists/lists_load_events/lists_bloc.dart';
import '/custom/pages/lists/lists_service.dart';
import '/custom/pages/lists/user_lists_service.dart';
import '/custom/pages/shareList/bloc/shared_list_bloc.dart';
import '/custom/pages/shareList/shared_lists_service.dart';
import '/custom/pages/subscribeList/bloc/subscribe_list_bloc.dart';
import '/standard/analytics/bloc/analytics_bloc.dart';
import '/standard/analyticsRepository/analytics_repository.dart';
import '/standard/app/bloc/app_bloc.dart';
import '/standard/app/widgets/authenticated_user_listener.dart';
import '/standard/app/widgets/to_onscreen_logs_listener.dart';
import '/standard/appUi/theme/app_theme.dart';
import '/standard/bloc/login_bloc.dart';
import '/standard/changeUserBloc/bloc/change_user_bloc_bloc.dart';
import '/standard/navigation/redirect_cubit.dart';
import '/standard/navigation/router.dart';
import '/standard/onScreenLog/on_screen_log_cubit.dart';
import '/standard/theme_selector/bloc/theme_mode_bloc.dart';
import '/standard/userRepository/models/user.dart';
import '/standard/userRepository/user_repository.dart';
import '/standard/userRepository/user_service.dart';

class App extends StatelessWidget {
  const App({
    required UserRepository userRepository,
    required AnalyticsRepository analyticsRepository,
    required User user,
    this.observers,
    super.key,
  })  : _userRepository = userRepository,
        _analyticsRepository = analyticsRepository,
        _user = user;

  final UserRepository _userRepository;
  final AnalyticsRepository _analyticsRepository;
  final User _user;
  final List<NavigatorObserver>? observers;

  @override
  Widget build(BuildContext context) {
    final initialUserId = _user.id.isEmpty ? null : _user.id;

    final sharedListsService = SharedListsService();
    final userListsService = UserListsService(userId: initialUserId);
    final userService = UserService(userId: initialUserId);
    final listsService = ListsService(userId: initialUserId);
    final listItemsService = ListItemsService(userId: initialUserId);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _analyticsRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppBloc(
              userRepository: _userRepository,
              user: _user,
              userService: userService,
            ),
            // ..add(const AppOpened()),
          ),
          BlocProvider<ChangeUserBloc>(
            create: (context) => ChangeUserBloc(
              services: [
                sharedListsService,
                userListsService,
                userService,
                listsService,
                listItemsService,
              ],
            ),
          ),
          BlocProvider(
            create: (_) => FirebaseStorageBloc(
              userListsService: userListsService,
            ),
          ),
          BlocProvider(create: (_) => ThemeModeBloc()),
          BlocProvider<ListTypeCubit>(create: (context) => ListTypeCubit()),
          BlocProvider<OnScreenLogsCubit>(
            create: (context) => OnScreenLogsCubit(),
          ),
          BlocProvider<SearchLocationBloc>(
            create: (context) => SearchLocationBloc(),
          ),
          BlocProvider<FilterBloc>(
            create: (context) => FilterBloc(),
          ),
          BlocProvider<SharedListBloc>(
            create: (context) => SharedListBloc(sharedListsService),
          ),
          BlocProvider<ListCrudBloc>(
            create: (context) => ListCrudBloc(userListsService, listsService),
          ),
          BlocProvider<ListLoadBloc>(
            create: (context) => ListLoadBloc(listsService),
          ),
          BlocProvider<CategoriesForListBloc>(
            create: (context) => CategoriesForListBloc(listsService),
          ),
          BlocProvider<ListsLoadBloc>(
            create: (context) => ListsLoadBloc(userListsService),
          ),
          BlocProvider<SubscribeListBloc>(
            create: (context) =>
                SubscribeListBloc(sharedListsService, listsService),
          ),
          BlocProvider<ListItemsLoadBloc>(
            create: (context) => ListItemsLoadBloc(listItemsService),
          ),
          BlocProvider<ListItemCrudBloc>(
            create: (context) => ListItemCrudBloc(listItemsService),
          ),
          BlocProvider<ListItemLoadBloc>(
            create: (context) => ListItemLoadBloc(listItemsService),
          ),
          BlocProvider<ListItemsPageViewCubit>(
            create: (context) => ListItemsPageViewCubit(),
          ),
          BlocProvider<ListItemsSortOrderCubit>(
            create: (context) => ListItemsSortOrderCubit(),
          ),
          BlocProvider<ShowFilterCubit>(
            create: (context) => ShowFilterCubit(),
          ),
          BlocProvider<RedirectCubit>(create: (context) => RedirectCubit()),
          BlocProvider<CurrentLocationCubit>(
            create: (context) => CurrentLocationCubit(),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => AnalyticsBloc(
              analyticsRepository: _analyticsRepository,
              userRepository: _userRepository,
            ),
            lazy: false,
          ),
        ],
        child: AuthenticatedUserListener(
          child: ToOnScreenLogsListener(
            child: Builder(
              builder: (context) {
                final router = getRouter(
                  context: context,
                  routes: $appRoutes,
                  routerProviderInformation: getRouterProviderInformation(),
                  observers: observers,
                );
                return AppView(router);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView(this.router, {super.key});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.light,
      theme: const AppTheme().themeData,
      darkTheme: const AppDarkTheme().themeData,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
