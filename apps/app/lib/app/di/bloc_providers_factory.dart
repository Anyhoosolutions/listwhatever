import 'package:anyhoo_auth/anyhoo_auth.dart';
import 'package:anyhoo_logging/anyhoo_logging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_models/core_models.dart';

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
      // Example — add shared cubits here:
      // BlocProvider<SomeAppCubit>(
      //   create: (context) => SomeAppCubit(
      //     itemsRepository: context.read<ItemsRepository>(),
      //     currentTimeRepository: context.read<CurrentTimeRepository>(),
      //   ),
      // ),
    ];
  }
}
