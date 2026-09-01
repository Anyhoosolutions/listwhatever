import 'package:flutter/material.dart';
import 'package:lowercase_app_name/app/features/counter/counter_click_handlers.dart';
import 'package:lowercase_app_name/app/features/counter/counter_skeleton.dart';
import 'package:lowercase_app_name/app/features/counter/counter_view.dart';
import 'package:lowercase_app_name/app/features/counter/cubit/counter_cubit.dart';
import 'package:lowercase_app_name/app/features/counter/cubit/counter_state.dart';
import 'package:lowercase_app_name/shared/cubit_helpers/state_switcher.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StateSwitcher<CounterCubit, CounterState, int>(
      skeleton: const CounterSkeleton(),
      successBuilder: (context, value, cubit) {
        return CounterView(
          value: value,
          clickHandlers: CounterClickHandlers(onIncrement: cubit.increment),
        );
      },
    );
  }
}
