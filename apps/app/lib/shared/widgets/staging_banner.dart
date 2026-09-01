import 'package:flutter/material.dart';

/// Wraps the app when running a staging deploy flavor.
class StagingBanner extends StatelessWidget {
  const StagingBanner({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Banner(
      message: 'STAGING',
      location: BannerLocation.topStart,
      color: Colors.orange.shade800,
      child: child,
    );
  }
}
