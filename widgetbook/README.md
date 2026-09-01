# Widgetbook

Separate Flutter package for previewing UI in isolation. Layout mirrors `lib/app/features/` under `widgetbook/lib/features/`.

## Setup

From the app root (after `flutter pub get` on the main app):

```bash
cd widgetbook
flutter pub get
dart run build_runner build
```

Re-run `build_runner` whenever you add or move `@UseCase` / `@App` annotations.

## Run

```bash
cd widgetbook
flutter run -d chrome --web-port=45678
# or
flutter run -d macos
```

VS Code: use **Widgetbook (chrome)** or **Widgetbook (macos)** from the root `.vscode/launch.json`.

## Adding use cases

- **Views** (stateless, data passed in): wrap with [starterViewHost](lib/helpers/starter_widgetbook_host.dart).
- **Pages** (router + repos): wrap with [StarterRouterPreview](lib/helpers/starter_widgetbook_host.dart).

Register the project in Anyhoo Central with `widgetbookDirectory: widgetbook` so the hub can launch it.
