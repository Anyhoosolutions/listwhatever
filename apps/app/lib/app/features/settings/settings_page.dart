import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';
import 'package:lowercase_app_name/i18n/strings.g.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Center(child: t.settingsPage.header.headline());
  }
}
