import 'package:anyhoo_core/arguments_parser.dart';
import 'package:anyhoo_logging/anyhoo_logging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:listwhatever/app/main/app.dart';
import 'package:listwhatever/app/main/environment_config.dart';
import 'package:listwhatever/i18n/strings.g.dart';

Future<void> bootstrap(EnvironmentConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocaleSettings.useDeviceLocale();
  // await LocaleSettings.setLocale(AppLocale.sv);

  final arguments = await ArgumentsParser.getArguments();

  await config.initializeInfrastructure(arguments);

  final (loggingCubit, loggingConfiguration) = await setupLogging();
  final repositories = await config.repositories();
  final authCubit = await config.getAuthCubit();

  runApp(
    TranslationProvider(
      child: App(
        authCubit: authCubit,
        arguments: arguments,
        repositories: repositories,
        flavorProfile: config.flavorProfile,
        loggingConfiguration: loggingConfiguration,
        loggingCubit: loggingCubit,
      ),
    ),
  );
}

Future<(LoggingCubit, LoggingConfiguration)> setupLogging() async {
  final loggingCubit = LoggingCubit(maxLogs: 10);
  final loggingConfiguration = LoggingConfiguration(
    logLevel: kDebugMode ? Level.ALL : Level.WARNING,
    loggersAtInfo: const [],
    loggersAtWarning: const [
      'GoRouterWrapper',
      'AnyhooAuthCubit',
      'AnyhooRouteRedirector',
      // 'FirebaseInitializer',
      'Arguments',
    ],
    loggersAtSevere: const [],
    loggingCubit: loggingCubit,
  );

  return (loggingCubit, loggingConfiguration);
}
