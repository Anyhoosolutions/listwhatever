import 'package:flutter/material.dart';
import 'package:listwhatever/app/main/app_theme.dart';
import 'package:listwhatever/i18n/strings.g.dart';
import 'package:widgetbook_workspace/helpers/device_frame_wrapper.dart';

/// Material shell for stateless [view] widgets (no router or cubits).
Widget starterViewHost(
  Widget view, {
  ThemeMode themeMode = ThemeMode.system,
  PreferredSizeWidget? appBar,
  Widget? floatingActionButton,
  Widget? bottomNavigationBar,
}) {
  return TranslationProvider(
    child: MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: Builder(
        builder: (context) => DeviceFrameWrapper.wrapInDeviceFrame(
          context,
          Scaffold(
            appBar: appBar,
            body: view,
            floatingActionButton: floatingActionButton,
            bottomNavigationBar: bottomNavigationBar,
          ),
        ),
      ),
    ),
  );
}
