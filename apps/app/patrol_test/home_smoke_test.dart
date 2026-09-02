import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listwhatever/app/features/home/pages/home_page.dart';
import 'package:listwhatever/app/main/app_theme.dart';
import 'package:listwhatever/i18n/strings.g.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolTest('home page smoke', ($) async {
    await $.pumpWidgetAndSettle(
      TranslationProvider(
        child: MaterialApp(
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.dark,
          home: const Scaffold(body: HomePage()),
        ),
      ),
    );

    expect($('My Lists'), findsOneWidget);
    expect($('Movies to Watch'), findsOneWidget);
    expect($('Favorite Cafes'), findsOneWidget);
  });
}
