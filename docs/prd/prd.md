# Product Requirements Document (PRD)

### 1. Document Overview & Metadata

**Product / App Name:** ListWhatever (Working Title)  
**Document Version:** 1.0.0  
**Status:** Approved Draft  
**Target Release:** Q4 2026  
**Core Stack Reference:** `engine-standards/01` through `08`

---

### 2. Product Vision & Executive Summary

**Problem Statement:** Users frequently maintain fragmented lists of restaurants, movies, books, and places across multiple notes apps and messaging threads without structured, multi-tag filtering or location-aware query capabilities.

**Product Vision:** A unified dynamic list and filtering app enabling users to create custom schema-flexible lists with multi-select tags, numeric ranges, and live GPS distance filtering, complemented by single-item randomization and real-time list sharing.

**Target Audience & User Personas:**

* **Curators & Organized Socializers:** Users who maintain structured catalogs (e.g., top NYC restaurants, watchlist movies) and share them with friends.
* **Indecisive Decision Makers:** Users who want to quickly filter by exact criteria (e.g., "Good Wine", "Italian", "< 3 miles") and randomize a selection for dinner or movie night.

**Success Metrics & KPIs:**

* **Engine Adherence:** 100% compliance with `engine-standards/` monorepo, Cubit, and local-first architecture.
* **Performance:** Sub-100ms local filter and location-distance evaluation on dynamic lists.
* **Sync Reliability:** Background sync flush execution in $< 1.5$s upon reconnecting.

---

### 3. High-Level System Architecture & Package Scope

Following the **Melos monorepo structure**, the project is organized into modular packages:

* **Primary Application:** `apps/list_app`
* **Shared UI Components:** `packages/ui_components` (Atomic design elements, dynamic category widgets, `theme_tailor` tokens)
* **Data Models & Schemas:** `packages/core_models` (Freezed DTOs and dynamic list/item schemas shared between app and functions)
* **Navigation Routes:** `packages/navigation` (`GoRouter` configuration with `StatefulShellRoute.indexedStack`)
* **Sync & Local Storage:** `packages/sync_engine` (Offline-first architecture via Hive/Drift, `OutboundSyncQueue`, and LWW conflict resolution)
* **Cloud Functions:** `functions/` (Dart-based Cloud Functions using `firebase_functions` SDK)

---

### 4. Feature Breakdown & Requirements Matrix

| Feature ID | Feature Name | Priority | Target Layer | Core Specifications & Functionality |
| --- | --- | --- | --- | --- |
| **FEAT-01** | **Dynamic Schema Builder** | P0 | `apps/list_app` | Screen and models allowing users to create lists with custom fields (`multiSelectTags`, `singleSelect`, `boolean`, `numericRange`, `location`, `text`).  |
| **FEAT-02** | **Multi-Filter & Randomizer Engine** | P0 | `apps/list_app` | Real-time filtering on items using exact tags, ranges, and live GPS Haversine distance, with a single-click selection shuffle.  |
| **FEAT-03** | **Geocoding & Location Resolver** | P0 | `packages/sync_engine` | Address-to-coordinate lookup caching GeoPoint attributes locally alongside text addresses.  |
| **FEAT-04** | **Real-Time Sharing & List Forking** | P0 | `functions/` | Live Firestore list synchronization for collaborators and `onRequest`/`onCall` backend callable endpoints to fork/copy public lists.  |
| **FEAT-05** | **AI Metadata Extraction Bridge (Phase 2)** | P2 | `functions/` | Social share intent handler calling LLM APIs via Dart Cloud Functions to parse shared URLs (e.g., Instagram) into structured tags/coordinates.  |

---

### 5. Technical Constraints & Non-Functional Requirements

* **Platform Parity:** Support iOS, Android, and Web with responsive layout breakpoints: Mobile ($<600\text{px}$), Tablet ($600\text{px}–1024\text{px}$), and Desktop ($>1024\text{px}$).
* **Offline-First:** All list mutations write to local storage instantly and queue to `OutboundSyncQueue` before syncing to Cloud Firestore.
* **Security & Auth:** Firebase Auth (Google, Apple, Anonymous) with `Authorization: Bearer <token>` validation enforced on protected Cloud Functions.
