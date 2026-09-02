import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Like [FloatingActionButtonLocation.endFloat], but keeps the FAB fully above
/// a persistent bottom sheet using the same margin as above the bottom bar.
class EndFloatAboveBottomSheetFabLocation extends StandardFabLocation with FabEndOffsetX {
  const EndFloatAboveBottomSheetFabLocation();

  @override
  double getOffsetY(ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) {
    final contentBottom = scaffoldGeometry.contentBottom;
    final bottomContentHeight = scaffoldGeometry.scaffoldSize.height - contentBottom;
    final bottomSheetHeight = scaffoldGeometry.bottomSheetSize.height;
    final fabHeight = scaffoldGeometry.floatingActionButtonSize.height;
    final snackBarHeight = scaffoldGeometry.snackBarSize.height;
    final safeMargin = math.max(
      kFloatingActionButtonMargin,
      scaffoldGeometry.minViewPadding.bottom - bottomContentHeight + kFloatingActionButtonMargin,
    );

    var fabY = contentBottom - fabHeight - safeMargin;
    if (snackBarHeight > 0.0) {
      fabY = math.min(
        fabY,
        contentBottom - snackBarHeight - fabHeight - kFloatingActionButtonMargin,
      );
    }
    if (bottomSheetHeight > 0.0) {
      fabY = math.min(
        fabY,
        contentBottom - bottomSheetHeight - fabHeight - kFloatingActionButtonMargin,
      );
    }
    return fabY + adjustment;
  }
}
