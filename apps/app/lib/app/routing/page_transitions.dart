import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Opaque fill for shell body routes so outgoing pages don't show through.
Widget opaqueShellBody(BuildContext context, Widget child) {
  return ColoredBox(
    color: Theme.of(context).scaffoldBackgroundColor,
    child: child,
  );
}

Page<void> slideTransitionPage({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    opaque: true,
    child: opaqueShellBody(context, child),
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final offsetAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );

      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(offsetAnimation),
        child: child,
      );
    },
  );
}
