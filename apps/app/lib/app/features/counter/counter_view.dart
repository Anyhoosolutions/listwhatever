import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';
import 'package:lowercase_app_name/app/features/counter/counter_click_handlers.dart';
import 'package:lowercase_app_name/shared/keys.dart';

class CounterView extends StatelessWidget {
  const CounterView({
    super.key,
    required this.value,
    required this.clickHandlers,
  });

  final int value;
  final CounterClickHandlers clickHandlers;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value.toString(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 60),
        ),
        SizedBox(height: 16),
        AnyhooAddButton(
          key: keys.counterPage.incrementButton,
          onPressed: clickHandlers.onIncrement,
        ),
      ],
    );
  }
}
