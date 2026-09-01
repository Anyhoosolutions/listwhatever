# List Whatever

Copy this directory to bootstrap a new Flutter app using Anyhoo best practices.

## Quick start

```bash
cp -R templates/anyhoo_app_starter ~/git/my_new_app
cd ~/git/my_new_app
dart run ../../anyhoocentral/tool/rename_starter.dart \
  --package my_new_app \
  --bundle-id com.anyhoosolutions.mynewapp \
  --display-name "My New App"
flutter pub get
dart run build_runner build
./tool/install_git_hooks.sh
flutterfire configure --out=lib/shared/firebase/firebase_options.dart
flutterfire configure --project=listwhatever-staging --out=lib/shared/firebase/firebase_options_staging.dart
```

Register the project path in Anyhoo Central when ready.

## Layout

```
lib/app/main/           Entry quartet (main, main_fake, bootstrap, app)
lib/app/features/       Feature-first modules
lib/app/routing/        Typed go_router routes
lib/shared/             Shared widgets, theme, and helpers
lib/shared/theme/       [AppTheme] + tailor-generated [AppColors] (see app_colors.dart)
lib/sharedModels/         Models (Dart-only; TS-shared models go here too)
environments/prod/        Live Firebase backend config tree
environments/fake/        Fake/static repos for local dev
widgetbook/               Widgetbook UI catalog (separate package)
test/                     Unit, widget, component, and golden tests
patrol_test/              Patrol integration tests
```

**Note:** `environments/prod/` means **live backend** (Firebase), not “production deploy flavor”. Deploy flavor (`staging` vs `prod`) is selected via `--flavor` / `APP_FLAVOR`.

## Running

Use `.vscode/launch.json` for common configs, or:

```bash
# Fake data — no Firebase required
flutter run -t lib/app/main/main_fake.dart

# Production config (requires flutterfire configure)
flutter run -t lib/app/main/main.dart --flavor prod

# Staging — separate Firebase project, bundle ID suffix, orange theme, STAGING banner
flutter run -t lib/app/main/main.dart --flavor staging --dart-define=APP_FLAVOR=staging
```

## Git hooks

`tool/hooks/pre-commit` rejects commits with unformatted Dart (uses `analysis_options.yaml` formatter settings). Install once per clone:

```bash
./tool/install_git_hooks.sh
```

## Firebase staging

Staging uses a **separate Firebase project** with its own `lib/shared/firebase/firebase_options_staging.dart` (not just a different `projectId` in one file). `FirebaseOptionsResolver` picks the file from `APP_FLAVOR` / Gradle flavor.

## Emulator ports

`lib/shared/firebase/emulator_ports.dart` defines auth/firestore/storage ports (default `22601` / `22603` / `22606`). Change when multiple apps run emulators on one machine.

## Testing

Layout mirrors `lib/` under `test/` (see Anyhoo [testing guide](../../best_practices/testing/testing.md)).

```bash
# Unit + widget tests (default)
flutter test

# Component tests (fake repos, no UI — scope to test/component/)
dart test --tags component test/component/

# Golden tests
flutter test --tags golden
flutter test --tags golden --update-goldens   # after intentional UI changes

# Patrol (device/emulator — install patrol_cli first)
patrol test
```

| Path | Type |
|------|------|
| `test/app/features/items/cubit/` | Unit (cubit + fake repo) |
| `test/app/features/items/widgets/` | Widget |
| `test/component/features/items/` | Component (`@Tags(['component'])`) |
| `test/goldens/` | Golden (Alchemist + `test/flutter_test_config.dart`) |
| `patrol_test/` | Patrol smoke |

## Widgetbook

Separate package at `widgetbook/` for UI previews (mirrors `lib/app/features/`). See [widgetbook/README.md](widgetbook/README.md).

```bash
cd widgetbook && flutter pub get && dart run build_runner build
cd widgetbook && flutter run -d chrome --web-port=45678
```

Register `widgetbookDirectory: widgetbook` in Anyhoo Central when linking the project.

## Deploy flavors (Android)

Gradle `env` dimension: `prod` (`com.anyhoosolutions.listwhatever`) and `staging` (`com.anyhoosolutions.listwhatever.staging`).

Web hosting targets in `firebase.json`: `app` and `app-staging`.

## Adding an admin app

See [docs/add_admin_module.md](../../docs/add_admin_module.md) and apply `templates/fragments/admin_module/`.

## Four side-by-side mobile installs

See [docs/enable_four_mobile_variants.md](../../docs/enable_four_mobile_variants.md) when you need user+admin × staging+prod on one device.

## Placeholder tokens

| Token | Default |
|-------|---------|
| Package | `listwhatever` |
| Android Package Name | `com.anyhoosolutions.listwhatever` |
| iOS Bundle ID | `com.anyhoosolutions.listwhatever` |
| macOS Bundle ID | `com.anyhoosolutions.listwhatever` |
| Display name | `List Whatever` |
| Firebase project | `listwhatever` / `listwhatever-staging` |

## Health scoring

This layout matches the canonical entry structure checked by Anyhoo Central **Structure & QA** rules (`lib/app/main/` with full entry quartet + prod/fake configs).
