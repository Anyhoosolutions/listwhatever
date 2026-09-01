import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lowercase_app_name/app/features/counter/counter_page.dart';
import 'package:lowercase_app_name/app/features/counter/cubit/counter_cubit.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/helpers/starter_widgetbook_host.dart';

@widgetbook.UseCase(name: 'CounterPage', type: CounterPage, path: 'features/counter')
Widget homePageUseCase(BuildContext context) {
  return starterViewHost(
    BlocProvider(
      create: (context) => CounterCubit()..load(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CounterPage()],
        ),
      ),
    ),
  );
}
