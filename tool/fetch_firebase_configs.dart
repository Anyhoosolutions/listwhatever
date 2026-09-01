#!/usr/bin/env dart
// Fetch Firebase client configs for prod and/or staging into flavor paths.
//
// Usage (from repo root):
//   dart run tool/fetch_firebase_configs.dart
//   dart run tool/fetch_firebase_configs.dart prod
//   dart run tool/fetch_firebase_configs.dart staging
//   dart run tool/fetch_firebase_configs.dart all --cleanup-legacy
//
// See docs/firebase-run-config.md (Anyhoo Central).

import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  final options = _parseArgs(args);
  if (options.showHelp) {
    _printUsage();
    exit(0);
  }

  final paths = _RepoPaths.resolve();
  if (!paths.firebaserc.existsSync()) {
    stderr.writeln('Missing ${paths.firebaserc.path}');
    exit(1);
  }
  final flutterfire = _requireFlutterfire();

  final config = _FlavorEnv.fromFirebaserc(paths.firebaserc);

  for (final flavor in options.flavors) {
    await _configureFlavor(
      paths: paths,
      env: config,
      flavor: flavor,
      flutterfire: flutterfire,
    );
    if (flavor == _Flavor.staging) {
      _renameStagingDartClass(paths.appDir);
    }
  }

  if (options.cleanupLegacy) {
    _cleanupLegacy(paths.appDir);
  }

  stdout.writeln('''

Done. Flavor sources of truth are under:
  android/app/src/{prod,staging}/google-services.json
  ios/config/{prod,staging}/GoogleService-Info.plist
  macos/config/{prod,staging}/GoogleService-Info.plist
  lib/shared/firebase/firebase_options.dart
  lib/shared/firebase/firebase_options_staging.dart

Apple real-Firebase runs still need copy → Runner/ (see .vscode/tasks.json).''');
  if (!options.cleanupLegacy) {
    stdout.writeln(
      'Optional: re-run with --cleanup-legacy to remove root/emulator native duplicates.',
    );
  }
}

enum _Flavor { prod, staging }

class _CliOptions {
  _CliOptions({required this.flavors, required this.cleanupLegacy, required this.showHelp});

  final List<_Flavor> flavors;
  final bool cleanupLegacy;
  final bool showHelp;
}

_CliOptions _parseArgs(List<String> args) {
  var flavorArg = 'all';
  var cleanupLegacy = false;
  var showHelp = false;

  for (final arg in args) {
    switch (arg) {
      case 'all' || 'prod' || 'production' || 'staging':
        flavorArg = arg;
      case '--cleanup-legacy':
        cleanupLegacy = true;
      case '-h' || '--help':
        showHelp = true;
      default:
        stderr.writeln('Unknown argument: $arg');
        _printUsage();
        exit(1);
    }
  }

  final flavors = switch (flavorArg) {
    'prod' || 'production' => [_Flavor.prod],
    'staging' => [_Flavor.staging],
    _ => [_Flavor.prod, _Flavor.staging],
  };

  return _CliOptions(flavors: flavors, cleanupLegacy: cleanupLegacy, showHelp: showHelp);
}

void _printUsage() {
  stdout.writeln('''
Fetch Firebase client configs for prod and/or staging into flavor paths.

Usage (from repo root):
  dart run tool/fetch_firebase_configs.dart
  dart run tool/fetch_firebase_configs.dart prod
  dart run tool/fetch_firebase_configs.dart staging
  dart run tool/fetch_firebase_configs.dart all --cleanup-legacy

See docs/firebase-run-config.md (Anyhoo Central).''');
}

class _RepoPaths {
  _RepoPaths({required this.repoRoot, required this.appDir});

  final Directory repoRoot;
  final Directory appDir;

  File get firebaserc => File('${repoRoot.path}/.firebaserc');

  /// Prefer cwd (run from repo root); fall back to walking up from the script.
  static _RepoPaths resolve() {
    final repoRoot = _findRepoRoot() ?? _repoRootFromScript();
    final appDir = Directory('${repoRoot.path}/apps/app');
    if (!appDir.existsSync()) {
      stderr.writeln('Expected Flutter app at ${appDir.path}');
      exit(1);
    }
    return _RepoPaths(repoRoot: repoRoot, appDir: appDir);
  }

  static Directory? _findRepoRoot() {
    var dir = Directory.current;
    for (;;) {
      final firebaserc = File('${dir.path}/.firebaserc');
      final app = Directory('${dir.path}/apps/app');
      if (firebaserc.existsSync() && app.existsSync()) {
        return dir;
      }
      final parent = dir.parent;
      if (parent.path == dir.path) {
        return null;
      }
      dir = parent;
    }
  }

  static Directory _repoRootFromScript() {
    // `dart run` may point Platform.script at a kernel snapshot; parent.parent
    // is still usually `<repo>/tool` → `<repo>` when invoked as a source file.
    return File.fromUri(Platform.script).parent.parent;
  }
}

class _FlavorEnv {
  _FlavorEnv({
    required this.prodProject,
    required this.stagingProject,
    required this.prodAndroidPackage,
    required this.stagingAndroidPackage,
    required this.prodAppleBundleId,
    required this.stagingAppleBundleId,
    required this.platforms,
  });

  final String prodProject;
  final String stagingProject;
  final String prodAndroidPackage;
  final String stagingAndroidPackage;
  final String prodAppleBundleId;
  final String stagingAppleBundleId;
  final String platforms;

  factory _FlavorEnv.fromFirebaserc(File firebaserc) {
    final projects =
        (jsonDecode(firebaserc.readAsStringSync()) as Map<String, dynamic>)['projects'] as Map<String, dynamic>?;
    if (projects == null) {
      stderr.writeln('No "projects" map in ${firebaserc.path}');
      exit(1);
    }

    String project(String alias) {
      final value = projects[alias];
      if (value is! String || value.isEmpty) {
        stderr.writeln("Alias '$alias' not found in ${firebaserc.path}");
        exit(1);
      }
      return value;
    }

    return _FlavorEnv(
      prodProject: Platform.environment['PROD_PROJECT'] ?? project('prod'),
      stagingProject: Platform.environment['STAGING_PROJECT'] ?? project('staging'),
      prodAndroidPackage: Platform.environment['PROD_ANDROID_PACKAGE'] ?? 'com.anyhoosolutions.myapp',
      stagingAndroidPackage: Platform.environment['STAGING_ANDROID_PACKAGE'] ?? 'com.anyhoosolutions.myapp.staging',
      prodAppleBundleId: Platform.environment['PROD_APPLE_BUNDLE_ID'] ?? 'com.anyhoosolutions.myapp',
      stagingAppleBundleId: Platform.environment['STAGING_APPLE_BUNDLE_ID'] ?? 'com.anyhoosolutions.myapp.staging',
      platforms: Platform.environment['PLATFORMS'] ?? 'android,ios,macos,web',
    );
  }
}

/// Returns absolute path to the `flutterfire` executable.
String _requireFlutterfire() {
  final result = Process.runSync('sh', ['-c', 'command -v flutterfire']);
  final path = result.stdout.toString().trim();
  if (result.exitCode != 0 || path.isEmpty) {
    stderr.writeln('''flutterfire not found. Install with:
  dart pub global activate flutterfire_cli
and ensure ~/.pub-cache/bin is on PATH.''');
    exit(1);
  }
  return path;
}

Future<void> _configureFlavor({
  required _RepoPaths paths,
  required _FlavorEnv env,
  required _Flavor flavor,
  required String flutterfire,
}) async {
  final isProd = flavor == _Flavor.prod;
  // Android / config dirs use prod|staging; Apple Xcode configs use production|staging.
  final name = isProd ? 'prod' : 'staging';
  final appleFlavor = isProd ? 'production' : 'staging';
  final project = isProd ? env.prodProject : env.stagingProject;
  final androidPackage = isProd ? env.prodAndroidPackage : env.stagingAndroidPackage;
  final appleBundle = isProd ? env.prodAppleBundleId : env.stagingAppleBundleId;
  final dartOut = isProd
      ? 'lib/shared/firebase/firebase_options.dart'
      : 'lib/shared/firebase/firebase_options_staging.dart';
  final androidOut = 'android/app/src/$name/google-services.json';
  final iosOut = 'ios/config/$name/GoogleService-Info.plist';
  final macosOut = 'macos/config/$name/GoogleService-Info.plist';
  // Skips FlutterFire's "Build configuration vs Target" prompt. Matches schemes
  // in ios/macos Runner (Debug-production / Debug-staging, etc.).
  final appleBuildConfig = 'Debug-$appleFlavor';

  stdout.writeln('\n==> Configuring $name (project=$project)');
  stdout.writeln('    (flutterfire output streams below; first network call can take a bit)\n');

  for (final relative in [androidOut, iosOut, macosOut, dartOut]) {
    File('${paths.appDir.path}/$relative').parent.createSync(recursive: true);
  }

  // Inherit stdio so progress/prompts are visible. Process.runSync buffers
  // everything until exit, which looks like a hang.
  final process = await Process.start(
    flutterfire,
    [
      'configure',
      '--project=$project',
      '--yes',
      '--platforms=${env.platforms}',
      '--android-package-name=$androidPackage',
      '--ios-bundle-id=$appleBundle',
      '--macos-bundle-id=$appleBundle',
      '--ios-build-config=$appleBuildConfig',
      '--macos-build-config=$appleBuildConfig',
      '--out=$dartOut',
      '--android-out=$androidOut',
      '--ios-out=$iosOut',
      '--macos-out=$macosOut',
      '--overwrite-firebase-options',
    ],
    workingDirectory: paths.appDir.path,
    mode: ProcessStartMode.inheritStdio,
  );
  final exitCode = await process.exitCode;
  if (exitCode != 0) {
    stderr.writeln('flutterfire configure failed for $name (exit $exitCode)');
    exit(exitCode);
  }
}

void _renameStagingDartClass(Directory appDir) {
  final file = File('${appDir.path}/lib/shared/firebase/firebase_options_staging.dart');
  if (!file.existsSync()) {
    stderr.writeln('Expected staging options at ${file.path}');
    exit(1);
  }

  final text = file.readAsStringSync();
  if (text.contains('class StagingFirebaseOptions')) {
    stdout.writeln('Staging Dart class already named StagingFirebaseOptions');
    return;
  }
  if (!text.contains('class DefaultFirebaseOptions')) {
    stderr.writeln('Could not find DefaultFirebaseOptions in ${file.path}');
    exit(1);
  }

  file.writeAsStringSync(text.replaceAll('DefaultFirebaseOptions', 'StagingFirebaseOptions'));
  stdout.writeln('Renamed DefaultFirebaseOptions → StagingFirebaseOptions in ${file.path}');
}

void _cleanupLegacy(Directory appDir) {
  final legacy = [
    'android/app/google-services.json',
    'android/app/google-services.emulator.json',
    'ios/Runner/GoogleService-Info.emulator.plist',
    'macos/Runner/GoogleService-Info.emulator.plist',
  ];

  var removed = false;
  for (final relative in legacy) {
    final file = File('${appDir.path}/$relative');
    if (file.existsSync()) {
      file.deleteSync();
      stdout.writeln('Removed legacy ${file.path}');
      removed = true;
    }
  }
  if (!removed) {
    stdout.writeln('No legacy emulator/root config files to remove');
  }
}
