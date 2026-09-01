import 'package:flutter/material.dart';
import 'package:listwhatever/app/main/app_theme.dart';
import 'package:listwhatever/i18n/strings.g.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_workspace/helpers/device_frame_wrapper.dart';

/// Material shell for stateless [view] widgets (no router or cubits).
Widget starterViewHost(
  Widget view, {
  PreferredSizeWidget? appBar,
  Widget? floatingActionButton,
  Widget? bottomNavigationBar,
}) {
  return Builder(
    builder: (context) {
      // ignore: deprecated_member_use
      final themeModeSelection = context.knobs.list(
        label: 'Theme mode',
        options: const ['light', 'dark'],
        initialOption: 'light',
      );
      final themeMode = themeModeSelection == 'dark' ? ThemeMode.dark : ThemeMode.light;

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
    },
  );
}
