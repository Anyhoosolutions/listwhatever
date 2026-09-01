import 'package:flutter/material.dart';
import 'package:lowercase_app_name/app/main/environments/prod/flavors/flavor_profile.dart';

class FlavorProfiles {
  static const staging = FlavorProfile(
    name: 'staging',
    isStaging: true,
    primaryColor: Color(0xFFE65100),
    firebaseProjectId: 'lowercase_app_name-staging',
  );

  static const prod = FlavorProfile(
    name: 'prod',
    isStaging: false,
    primaryColor: Color(0xFF1565C0),
    firebaseProjectId: 'lowercase_app_name-prod',
  );

  static FlavorProfile forName(String name) {
    return switch (name) {
      'staging' => staging,
      'prod' => prod,
      _ => prod,
    };
  }

  /// Resolved from `--dart-define=APP_FLAVOR=staging` or Gradle `--flavor`.
  static String get activeFlavorName => const String.fromEnvironment('APP_FLAVOR', defaultValue: 'prod');

  static FlavorProfile get active => forName(activeFlavorName);
}
