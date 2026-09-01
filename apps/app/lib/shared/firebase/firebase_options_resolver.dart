import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:logging/logging.dart';
import 'package:lowercase_app_name/shared/firebase/firebase_options.dart';
import 'package:lowercase_app_name/shared/firebase/firebase_options_staging.dart';

/// Resolves [FirebaseOptions] for the active deploy flavor.
///
/// Production options live in [DefaultFirebaseOptions] (FlutterFire output).
/// Staging still uses placeholder/emulator options until you run
/// `flutterfire configure` against the staging project and update
/// [StagingFirebaseOptions].
///
final _log = Logger('FirebaseOptionsResolver');

abstract final class FirebaseOptionsResolver {
  static FirebaseOptions forFlavor(String flavorName) {
    _log.info('Resolving Firebase options for flavor: $flavorName');
    return switch (flavorName) {
      'staging' => StagingFirebaseOptions.currentPlatform,
      _ => DefaultFirebaseOptions.currentPlatform,
    };
  }
}
