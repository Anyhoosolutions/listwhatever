import 'package:flutter/material.dart';

/// Deploy-environment profile (staging vs prod).
///
/// `environments/prod/` means live Firebase backend — not "production flavor".
class FlavorProfile {
  const FlavorProfile({
    required this.name,
    required this.isStaging,
    required this.primaryColor,
    required this.firebaseProjectId,
  });

  final String name;
  final bool isStaging;
  final Color primaryColor;
  final String firebaseProjectId;
}
