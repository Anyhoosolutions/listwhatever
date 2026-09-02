import 'package:anyhoo_auth/anyhoo_auth.dart';
import 'package:anyhoo_logging/anyhoo_logging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_models/core_models.dart';
import 'package:listwhatever/app/features/list_items/cubit/list_items_cubit.dart';
import 'package:listwhatever/app/features/list_items/repositories/list_items_repository.dart';
import 'package:listwhatever/app/features/lists/cubit/dynamic_lists_cubit.dart';
import 'package:listwhatever/app/features/lists/repositories/dynamic_lists_repository.dart';

abstract final class BlocProvidersFactory {
  /// App-wide cubits. Use [BlocProvider.create] and [BuildContext.read] for
  /// cubits that depend on repositories registered above in [MultiRepositoryProvider].
  ///
  /// Route-scoped cubits stay on their route (see [ItemRoute]).
  static List<BlocProvider<dynamic>> buildAppBlocProviders({
    required AnyhooAuthCubit<User> authCubit,
    required LoggingCubit loggingCubit,
  }) {
    return [
      BlocProvider<AnyhooAuthCubit<User>>.value(value: authCubit),
      BlocProvider<LoggingCubit>.value(value: loggingCubit),

      BlocProvider<DynamicListsCubit>(
        create: (context) => DynamicListsCubit(
          repository: context.read<DynamicListsRepository>(),
        )..load(),
      ),
      BlocProvider<ListItemsCubit>(
        create: (context) => ListItemsCubit(
          repository: context.read<ListItemsRepository>(),
        ),
      ),
    ];
  }
}
