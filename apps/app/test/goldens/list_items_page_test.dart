@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listwhatever/app/features/list_items/cubit/list_items_cubit.dart';
import 'package:listwhatever/app/features/list_items/fake_list_items_repository.dart';
import 'package:listwhatever/app/features/list_items/list_items_page.dart';
import 'package:listwhatever/app/features/list_items/list_items_view.dart';

import 'support/golden_screenshot_presets.dart';
import 'support/golden_test_helpers.dart';
import 'support/hub_golden_harness.dart';

void main() {
  const devices = [
    (
      name: 'phone',
      preset: GoldenScreenshotPresets.phone,
    ),
    (
      name: 'tablet_landscape',
      preset: GoldenScreenshotPresets.tabletLandscape,
    ),
    (
      name: 'laptop',
      preset: GoldenScreenshotPresets.laptop,
    ),
  ];

  for (final themeMode in [ThemeMode.light, ThemeMode.dark]) {
    final themeName = themeMode == ThemeMode.dark ? 'dark' : 'light';
    for (final device in devices) {
      appGoldenTest(
        description: 'List Items Page ${device.name} $themeName',
        fileName: 'list_items_page_${device.name}_$themeName',
        surfaceWidth: device.preset.width.toDouble(),
        surfaceHeight: device.preset.height.toDouble(),
        child: buildHubGoldenHarnessWithShell(
          themeMode: themeMode,
          initialLocation: '/lists/golf',
          extraBlocProviders: [
            BlocProvider<ListItemsCubit>(
              create: (_) => ListItemsCubit(repository: FakeListItemsRepository())..load('golf'),
            ),
          ],
          shellPage: const ListItemsPage(listId: 'golf'),
        ),
      );
      appGoldenTest(
        description: 'List Map Page ${device.name} $themeName',
        fileName: 'list_map_page_${device.name}_$themeName',
        surfaceWidth: device.preset.width.toDouble(),
        surfaceHeight: device.preset.height.toDouble(),
        child: buildHubGoldenHarnessWithShell(
          themeMode: themeMode,
          initialLocation: '/lists/golf',
          extraBlocProviders: [
            BlocProvider<ListItemsCubit>(
              create: (_) => ListItemsCubit(repository: FakeListItemsRepository())..load('golf'),
            ),
          ],
          shellPage: const ListItemsPage(
            listId: 'golf',
            initialMode: ListItemsViewMode.map,
          ),
        ),
      );
    }
  }
}
