@Tags(['golden'])
library;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lowercase_app_name/app/features/counter/counter_page.dart';
import 'package:lowercase_app_name/app/features/counter/cubit/counter_cubit.dart';

import 'support/golden_test_helpers.dart';
import 'support/hub_golden_harness.dart';

void main() {
  appGoldenTest(
    description: 'Counter Page',
    fileName: 'counter_page',
    scenarioName: 'default',
    child: buildHubGoldenHarnessWithShell(
      shellPage: CounterPage(),
      extraBlocProviders: [
        BlocProvider<CounterCubit>(create: (_) => CounterCubit()..load()),
      ],
    ),
  );
}
