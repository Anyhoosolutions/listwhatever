import 'dart:io';

import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget loadableShimmer(BuildContext context, Widget child) {
  final isInFlutterTest = !kIsWeb && Platform.environment.containsKey('FLUTTER_TEST');
  final shimmer = context.shimmer;
  return Shimmer.fromColors(
    enabled: !isInFlutterTest,
    baseColor: shimmer.baseColor,
    highlightColor: shimmer.highlightColor,
    child: child,
  );
}
