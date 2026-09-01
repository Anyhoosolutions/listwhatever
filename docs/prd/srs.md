
# System Requirements Specification (SRS)

### 1. Document Overview & Scope

**Application Name:** Dynamic List & Randomizer App  
**Document Version:** 1.0.0  
**Target Platforms:** Web (Desktop & Mobile Web), Mobile (iOS & Android).  
**Scope:** Defines technical specifications, data models, Cubit state management structures, and offline-first data synchronization patterns.  

---

### 2. Global Technology Stack Specifications

| Layer / Concern | Selected Technology / Pattern | Engine Standard Reference |
| --- | --- | --- |
| **Monorepo / Workspace** | Melos | `engine-standards/07_Monorepo_Melos_Guide`<br> |
| **Frontend Framework** | Flutter (Mobile & Web) | `engine-standards/05_Web_Responsive_Layout_Rules`<br> |
| **State Management** | Bloc / Cubit (with `HydratedCubit`) | `engine-standards/01_Cubit_Architecture`<br> |
| **UI State Rendering** | `StateSwitcher` & `LoadableState` | `engine-standards/01_Cubit_Architecture`<br> |
| **Code Generation** | `freezed` (States & Models) | `engine-standards/01_Cubit_Architecture`<br> |
| **Routing & Navigation** | `GoRouter` | `engine-standards/03_Navigation_Patterns`<br> |
| **Dependency Injection** | `RepositoryProvider` / `BlocProvider` | `engine-standards/01_Cubit_Architecture`<br> |
| **UI Component Library** | Shared UI Package + `theme_tailor` | `engine-standards/02_UI_Package_Theme_Guide`<br> |
| **Backend / Cloud** | Firebase (Firestore, Auth, Cloud Storage) | `engine-standards/04_Dart_Cloud_Functions_Firebase`<br> |
| **Backend Logic** | Dart Cloud Functions (`firebase_functions`) | `engine-standards/04_Dart_Cloud_Functions_Firebase`<br> |
| **Data Persistence** | Local-First Hive/Drift + Firestore LWW Sync | `engine-standards/06_Offline_First_Sync_Strategy`<br> |
| **Diagnostics** | Sentry + Firebase Crashlytics | `engine-standards/08_Testing_Practices_And_Emulators`<br> |

---

### 3. Architectural & Core System Requirements

#### 3.1 Domain Models & Dynamic Schema Strategy (`packages/core_models`)

All models are immutable `freezed` classes shared across Flutter apps and Dart Cloud Functions.

**Dynamic List Schema (`DynamicList`):**

```dart
@freezed
class DynamicList with _$DynamicList {
  const factory DynamicList({
    required String id,
    required String ownerId,
    required String title,
    required String description,
    required String visibility, // 'private' | 'shared' | 'public'
    @Default([]) List<String> collaboratorIds,
    @Default([]) List<CategoryDef> categories,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DynamicList;

  factory DynamicList.fromJson(Map<String, dynamic> json) =>
      _$DynamicListFromJson(json);
}

```

**Category Definition Schema (`CategoryDef`):**

```dart
@freezed
class CategoryDef with _$CategoryDef {
  const factory CategoryDef({
    required String key,
    required String displayName,
    required String valueType, // 'multiSelectTags' | 'singleSelect' | 'boolean' | 'numericRange' | 'location' | 'text'
    @Default([]) List<String> availableOptions,
  }) = _CategoryDef;

  factory CategoryDef.fromJson(Map<String, dynamic> json) =>
      _$CategoryDefFromJson(json);
}

```

**List Item Schema (`ListItem`):**

```dart
@freezed
class ListItem with _$ListItem {
  const factory ListItem({
    required String id,
    required String listId,
    required String title,
    required String notes,
    required Map<String, dynamic> categoryValues, // Keys match CategoryDef.key
    String? address,
    double? latitude,
    double? longitude,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ListItem;

  factory ListItem.fromJson(Map<String, dynamic> json) =>
      _$ListItemFromJson(json);
}

```

#### 3.2 State Management (`ListFilterCubit`)

Features use immutable `LoadableState<T>` emitted by Cubits:

```dart
@freezed
class ListFilterState with _$ListFilterState implements LoadableState<List<ListItem>> {
  const factory ListFilterState({
    List<ListItem>? data,
    String? errorMessage,
    @Default(false) bool isLoading,
    @Default(false) bool isSyncing,
    @Default({}) Map<String, dynamic> activeFilters,
    double? maxDistanceMiles,
    ListItem? randomizedSelection,
  }) = _ListFilterState;
}

```

---

### 4. Feature State Matrix: List Detail & Filter View

| Cubit State | Trigger / Condition | Mobile View ($<600\text{px}$) | Desktop View ($>1024\text{px}$) | Primary User Action | Offline Behavior |
| --- | --- | --- | --- | --- | --- |
| **Initial** | Navigate to `/list/:id` | Single-column item card feed with bottom filter sheet modal.  | Left filter sidebar, right dynamic item grid with search bar.  | Observe items; tap "Filter".  | Render from local cache stream immediately.  |
| **Loading** | Fetching list items / applying filter | Top linear loading bar over cached local list.  | Centered grid shimmer placeholder animation.  | System interactions blocked.  | Serve local cache without spinner.  |
| **Loaded** | Filter / Search executed | Responsive cards showing matching tags & distance badges.  | Multi-column item table with inline tag pill indicators.  | Tap "Randomize Selection" floating button.  | Filters apply locally via memory/SQLite.  |
| **Randomized** | Shuffle action triggered | Full-screen item highlight modal with action buttons.  | Centered popover highlighting randomized item details.  | Tap "Accept Choice" or "Shuffle Again".  | Fully operational offline.  |
| **Failure** | Synchronization or geocoding error | SnackBar notification: "Geocoding failed; using raw address".  | Inline alert banner above content view.  | Tap "Retry" button.  | Operations logged; retry queued in `OutboundSyncQueue`.  |

---

### 5. Offline-First Synchronization & Data Pipeline

Data flows through a strictly unidirectional offline-first execution sequence:

$$\text{UI Layer} \xleftarrow{\text{Read Streams}} \text{Local Cache DB} \xleftarrow{\text{Apply Sync}} \text{Sync Engine} \xleftarrow{\text{Network Push}} \text{Cloud Firestore}$$

$$\text{UI Layer} \xrightarrow{\text{Write}} \text{Local Repository} \xrightarrow{\text{Enqueue}} \text{Outbound Sync Queue} \xrightarrow{\text{Flush}} \text{Sync Engine}$$

* **Local Write:** Mutations write directly to local storage (Hive/Drift) and append payloads to `OutboundSyncQueue` tagged with idempotency keys.


* **Conflict Resolution:** Remote updates apply Last-Write-Wins (LWW) utilizing `FieldValue.serverTimestamp()`. Local pending entities lock incoming remote overrides until local sync flushes successfully.



---

### 6. Non-Functional & Operational Requirements

* **Authentication & Header Validation:** Protected Cloud Functions require valid Firebase Auth credentials passed via `Authorization: Bearer <token>` HTTP headers.
* **Testing Standards:** Adheres to a 4-Tier Testing Methodology:
* **Tier 1:** Pure Dart unit testing for Haversine formulas and filter matching logic (100% coverage target).
* **Tier 2:** `bloc_test` for `ListFilterCubit` and schema validation state transitions.
* **Tier 3:** `Golden Toolkit` visual snapshot regression tests in Light/Dark themes.
* **Tier 4:** `Patrol` end-to-end integration tests for list creation and sharing flows.