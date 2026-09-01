# Macro System Requirements Specification (SRS): AnyhooCentral Developer Console

# 1\. Document Overview & Scope

* **Application Name:** Display_name_to_replace
* **Document Version:** 1.0.0  
* **Target Platforms:** Web (Desktop & Mobile Web), Mobile (iOS & Android).  
* **Scope:** This document defines the technical baseline and architectural requirements for an integrated development hub designed to unify project management, local emulation, cross-platform compilation, and deployment tracking.

# 2\. Global Technology Stack Specifications

The implementation must adhere to the following non-negotiable architectural baseline:

| Layer / Concern | Selected Technology / Pattern | Engine Standard Reference |
| ----- | ----- | ----- |
| **Monorepo / Workspace** | Melos | \[07\_Monorepo\_Melos\_Guide\] |
| **Frontend Framework** | Flutter (Mobile & Web) | \[05\_Web\_Responsive\_Layout\_Rules\] |
| **State Management** | Bloc / Cubit (with HydratedCubit) | \[01\_Cubit\_Architecture\] |
| **UI State Rendering** | StateSwitcher & LoadableState | \[01\_Cubit\_Architecture\] |
| **Code Generation** | `freezed` (States & Models) | \[01\_Cubit\_Architecture\] |
| **Routing & Navigation** | GoRouter | \[03\_Navigation\_Patterns\] |
| **Dependency Injection** | RepositoryProvider / BlocProvider | \[01\_Cubit\_Architecture\] |
| **UI Component Library** | Shared UI Package \+ ThemeExtension | \[02\_UI\_Package\_Theme\_Guide\] |
| **Backend / Cloud** | Firebase (Firestore, Auth, Storage) | \[04\_Dart\_Cloud\_Functions\_Firebase\] |
| **Backend Logic** | Dart Cloud Functions | \[04\_Dart\_Cloud\_Functions\_Firebase\] |
| **Data Persistence** | Firestore with local offline caching | \[06\_Offline\_First\_Sync\_Strategy\] |
| **Diagnostics** | Sentry \+ Firebase Crashlytics | \[08\_Testing\_Practices\_And\_Emulators\] |

# 3\. Architectural & Core System Requirements

## 3.1 Monorepo & Package Structure

Source code must reside in a unified monorepo managed via **Melos**.

* **apps/lowercase_app_name:** The primary developer console application.  
* **packages/core\_models:** Pure Dart domain models and shared DTOs used by both the app and Cloud Functions.  
* **functions:** Firebase functions written in Dart.

## 3.2 Frontend & State Architecture

* **Cubit & Freezed:** All feature states must be immutable and implement the `LoadableState<T>` interface to interface with the `StateSwitcher` UI component.  
* **State Persistence:** Use **HydratedCubit** for non-sensitive persistent client state like theme preferences or active dashboard tab selections.  
* **Navigation:** Managed exclusively via **GoRouter** with typed static constants for paths. `StatefulShellRoute.indexedStack` must be used for persistent tab views (e.g., Dashboard vs. Deployments).  
* **Responsive Layouts:** UI must utilize `LayoutBuilder` and `MediaQuery` to adapt across Mobile (\<600px), Tablet (600-1024px), and Desktop (\>1024px).

## 3.3 Backend & Cloud Infrastructure

* **Dart Cloud Functions:** Serverless logic must be written using the official `firebase_functions` Dart SDK to share domain models between client and server.  
* **Pipeline Orchestration:** Deployment logic must follow a modular runner architecture where commands take input data, perform actions, and pass **PipelineArtifacts** forward via streams.  
* **Sync Strategy:** Implement a **Local-First Single Source of Truth**. The UI observes local storage streams; a background Sync Engine handles Firestore propagation using **Last-Write-Wins (LWW)** conflict resolution.

# 4\. Non-Functional & Operational Requirements

## 4.1 Authentication & Security

* **Auth Providers:** Mandatory support for Firebase Google Sign-In, Apple Sign-In, and a configurable Anonymous/Guest mode for local-only emulation.  
* **Header Enforcing:** All protected Dart Cloud Function endpoints must extract and validate the `Authorization: Bearer <token>` header, returning 401 for invalid tokens.

## 4.2 Testing & Quality Assurance

The project must adhere to a **4-Tier Testing Methodology**:

* **Tier 1:** 100% coverage on core models and calculation logic (Pure Dart).  
* **Tier 2:** `bloc_test` suites verifying state transitions for all feature Cubits.  
* **Tier 3:** Golden visual tests for both Light and Dark modes to prevent layout regression.  
* **Tier 4:** **Patrol** tests for end-to-end user journeys and native platform interactions.

## 4.3 Local Emulation

Development and integration testing must run against the **Firebase Emulator Suite** (Auth: 9099, Firestore: 8080, Functions: 5001). Production keys are strictly prohibited in local builds.
