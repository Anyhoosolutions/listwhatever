import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:lowercase_app_name/app/features/home/home_page.dart';

void main() {
  patrolTest('home page smoke', ($) async {
    await $.pumpWidgetAndSettle(
      const MaterialApp(
        home: Scaffold(body: HomePage()),
      ),
    );

    expect($('Home'), findsOneWidget);
    expect($('Open sample item'), findsOneWidget);
  });
}
