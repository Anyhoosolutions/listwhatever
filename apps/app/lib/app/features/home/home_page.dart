import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/routing/routes.dart';
import 'package:listwhatever/i18n/strings.g.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          t.homePage.header.headline(),
          const SizedBox(height: 16),
          AnyhooPrimaryButton(
            label: t.homePage.openButton,
            onPressed: () => const ItemRoute(itemId: '1').push(context),
          ),
        ],
      ),
    );
  }
}
