import 'package:flutter/material.dart';
import 'package:lowercase_app_name/app/main/app_theme.dart';
import 'package:widgetbook_workspace/helpers/device_frame_wrapper.dart';

/// Material shell for stateless [view] widgets (no router or cubits).
Widget starterViewHost(Widget view) {
  return MaterialApp(
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    themeMode: ThemeMode.system,
    home: Builder(builder: (context) => DeviceFrameWrapper.wrapInDeviceFrame(context, Scaffold(body: view))),
  );
}
