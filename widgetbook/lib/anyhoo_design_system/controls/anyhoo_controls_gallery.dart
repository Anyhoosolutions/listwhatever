import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:anyhoo_design_system/galleries.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/helpers/starter_widgetbook_host.dart';

@widgetbook.UseCase(name: 'Gallery', type: AnyhooSwitch, path: 'anyhoo_design_system/controls')
Widget buildAnyhooControlsGallery(BuildContext context) {
  return starterViewHost(const AnyhooControlsGallery());
}
