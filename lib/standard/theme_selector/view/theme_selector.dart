import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/standard/theme_selector/bloc/theme_mode_bloc.dart';
import '/standard/theme_selector/bloc/theme_mode_event.dart';

/// A drop down menu to select a new [ThemeMode]
///
/// Requires a [ThemeModeBloc] to be provided in the widget tree
/// (usually above [MaterialApp])
class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeMode = context.watch<ThemeModeBloc>().state;
    return DropdownButton(
      key: const Key('themeSelector_dropdown'),
      onChanged: (ThemeMode? selectedThemeMode) => context
          .read<ThemeModeBloc>()
          .add(ThemeModeChanged(selectedThemeMode)),
      value: themeMode,
      items: [
        DropdownMenuItem(
          value: ThemeMode.system,
          child: Text(
            l10n.systemOption,
            key: const Key('themeSelector_system_dropdownMenuItem'),
          ),
        ),
        DropdownMenuItem(
          value: ThemeMode.light,
          child: Text(
            l10n.lightModeOption,
            key: const Key('themeSelector_light_dropdownMenuItem'),
          ),
        ),
        DropdownMenuItem(
          value: ThemeMode.dark,
          child: Text(
            l10n.darkModeOption,
            key: const Key('themeSelector_dark_dropdownMenuItem'),
          ),
        ),
      ],
    );
  }
}
