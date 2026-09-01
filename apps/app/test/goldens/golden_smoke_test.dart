@Tags(['golden'])
library;

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Golden smoke', () {
    goldenTest(
      'renders golden smoke placeholder',
      fileName: 'golden_smoke',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'default',
            child: const Center(child: Text('Golden smoke')),
          ),
        ],
      ),
    );
  });
}
