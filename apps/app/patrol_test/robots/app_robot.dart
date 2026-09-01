import 'package:anyhoo_auth/cubit/anyhoo_auth_cubit.dart';
import 'package:anyhoo_core/models/arguments.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:lowercase_app_name/app/main/app.dart';
import 'package:lowercase_app_name/app/main/bootstrap.dart';
import 'package:lowercase_app_name/app/main/environments/fake/fake_repositories.dart';
import 'package:lowercase_app_name/app/main/environments/fake/mock_auth_cubit.dart';
import 'package:lowercase_app_name/app/main/environments/interfaces/app_repositories.dart';
import 'package:lowercase_app_name/app/main/environments/prod/flavors/flavor_profiles.dart';
import 'package:lowercase_app_name/app/main/environments/prod/production_config.dart';
import 'package:lowercase_app_name/shared/keys.dart';
import 'package:core_models/core_models.dart';

class AppRobot {
  const AppRobot(this.$);
  final PatrolIntegrationTester $;

  /// Mirrors [bootstrap] for fake repos; uses [ProductionConfig] + emulator auth for DB tests.
  Future<void> runApp(PatrolIntegrationTester $, {required bool useDb}) async {
    final savedErrorWidgetBuilder = ErrorWidget.builder;
    AppRepositories repositories = FakeRepositories();
    AnyhooAuthCubit<User> authCubit = MockAuthCubit();
    var arguments = const Arguments();

    if (useDb) {
      final config = ProductionConfig();
      arguments = const Arguments(useFirebaseEmulator: true);
      await config.initializeInfrastructure(arguments);
      ErrorWidget.builder = savedErrorWidgetBuilder;
      repositories = await config.repositories();
      authCubit = await config.getAuthCubit();
      await _signInPatrolEmulatorUser();
    }

    final flavorProfile = FlavorProfiles.active;
    final (loggingCubit, loggingConfiguration) = await setupLogging();

    // LocaleSettings.setLocale(AppLocale.en);
    await $.pumpWidget(
      // TranslationProvider(
      //   child:
      App(
        authCubit: authCubit,
        arguments: arguments,
        repositories: repositories,
        flavorProfile: flavorProfile,
        loggingConfiguration: loggingConfiguration,
        loggingCubit: loggingCubit,
      ),
      // ),
    );
    await _pumpUntilSettled($);
    ErrorWidget.builder = savedErrorWidgetBuilder;
  }

  /// Firebase Auth emulator: anonymous sign-in so [AnyhooAuthCubit] has a user before navigation.
  Future<void> _signInPatrolEmulatorUser() async {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      return;
    }
    await auth.signInAnonymously();
  }

  /// [pumpAndSettle] can hang with Firestore/auth streams on web; cap wait time.
  Future<void> _pumpUntilSettled(PatrolIntegrationTester $) async {
    await $.tester.pumpAndSettle(
      const Duration(milliseconds: 100),
      EnginePhase.sendSemanticsUpdate,
      const Duration(seconds: 10),
    );
  }

  Future<void> pressShellBack(PatrolIntegrationTester $) async {
    await $(keys.topBar.backButton).tap();
    await _pumpUntilSettled($);
  }

  Future<void> verifyText(String text) async {
    await $(text).waitUntilVisible();
  }

  Future<void> clickBottomBarButton(int index) async {
    await $(keys.bottomBarKeys.bottomBarButton(index)).tap();
    await _pumpUntilSettled($);
  }
}
