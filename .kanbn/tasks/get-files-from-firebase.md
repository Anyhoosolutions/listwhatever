---
created: 2026-08-10T01:01:01.111Z
---

# Get files from firebase

Prerequisites: `firebase login`, FlutterFire CLI (`dart pub global activate flutterfire_cli`), prod/staging apps registered in Firebase, and project aliases in repo-root `.firebaserc`.

See also: `docs/firebase-run-config.md` (in Anyhoo Central).

From repo root:

```sh
# Both flavors
dart run tool/fetch_firebase_configs.dart

# Or one at a time
dart run tool/fetch_firebase_configs.dart prod
dart run tool/fetch_firebase_configs.dart staging

# Optional: remove root/emulator duplicate natives after flavor files exist
dart run tool/fetch_firebase_configs.dart all --cleanup-legacy
```

Writes (under `apps/app/`):

- `android/app/src/{prod,staging}/google-services.json`
- `ios/config/{prod,staging}/GoogleService-Info.plist`
- `macos/config/{prod,staging}/GoogleService-Info.plist`
- `lib/shared/firebase/firebase_options.dart`
- `lib/shared/firebase/firebase_options_staging.dart` (class renamed to `StagingFirebaseOptions`)

Override project IDs / package names via env if needed: `PROD_PROJECT`, `STAGING_PROJECT`, `PROD_ANDROID_PACKAGE`, `STAGING_ANDROID_PACKAGE`, `PROD_APPLE_BUNDLE_ID`, `STAGING_APPLE_BUNDLE_ID`.
