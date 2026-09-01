import 'dart:async';

import 'package:alchemist/alchemist.dart';

const _kSkipGoldenTests = String.fromEnvironment(
  'SKIP_GOLDEN_TESTS',
  defaultValue: 'false',
);

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
      platformGoldensConfig: const PlatformGoldensConfig(obscureText: false),
      ciGoldensConfig: CiGoldensConfig(
        enabled: !_kSkipGoldenTests.toLowerCase().trim().contains('true'),
        obscureText: true,
      ),
    ),
    run: () async {
      await testMain();
    },
  );
}
