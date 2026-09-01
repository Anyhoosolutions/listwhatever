import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/home/home_page.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/helpers/starter_widgetbook_host.dart';

@widgetbook.UseCase(name: 'Home', type: HomePage, path: 'features/home')
Widget homePageUseCase(BuildContext context) {
  return starterViewHost(const HomePage());
}
