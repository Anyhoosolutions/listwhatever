import 'dart:async';

import 'package:anyhoo_auth/anyhoo_auth.dart';
import 'package:anyhoo_core/widgets/error_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/app/routing/routes.dart';

import 'package:core_models/core_models.dart';

/// Creates a [GoRouter].
///
/// Uses [GoRouter] directly instead of [AnyhooRouter] to avoid the ShellRoute
/// type cast issue in [AnyhooRouteRedirector.getAllPaths] when the route tree
/// includes [TypedShellRoute] (see `lib/hub/routing/hub_router.dart`).
GoRouter createAppRouterWithKit({
  required AnyhooAuthCubit<User> authCubit,
}) {
  return GoRouter(
    initialLocation: '/home',
    refreshListenable: _AuthRefreshNotifier(authCubit),
    redirect: (context, state) {
      final user = authCubit.state.user;
      final path = state.uri.path;
      final normalized = _normalizePath(path);

      if (normalized == _normalizePath('/login') && user != null) {
        return '/home';
      }

      if (user == null) {
        if (_unauthenticatedBypass(normalized, state.uri)) {
          return null;
        }
        return '/login';
      }

      return null;
    },
    routes: $appRoutes,
    errorBuilder: (context, state) => Scaffold(
      body: ErrorPage(errorMessage: 'Error: ${state.error}'),
    ),
  );
}

String _normalizePath(String path) {
  var normalized = path.toLowerCase();
  if (normalized.endsWith('/') && normalized != '/') {
    normalized = normalized.substring(0, normalized.length - 1);
  }
  return normalized;
}

bool _unauthenticatedBypass(String normalizedPath, Uri uri) {
  if (normalizedPath == '/login') {
    return true;
  }
  if (kIsWeb) {
    final path = uri.path;
    if (path.startsWith('/assets/') || path.startsWith('/canvaskit/') || path.startsWith('/icons/')) {
      return true;
    }
    if (normalizedPath == '/favicon.ico' || normalizedPath == '/flutter.js') {
      return true;
    }
  }
  return false;
}

class _AuthRefreshNotifier extends ChangeNotifier {
  _AuthRefreshNotifier(AnyhooAuthCubit<User> authCubit) {
    _subscription = authCubit.stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<AnyhooAuthState<User>> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
