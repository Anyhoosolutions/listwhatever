@Tags(['golden'])
library;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lowercase_app_name/app/features/items/cubit/item_cubit.dart';
import 'package:lowercase_app_name/app/features/items/item_page.dart';
import 'package:lowercase_app_name/app/main/environments/fake/fake_items_repository.dart';

import 'support/golden_test_helpers.dart';
import 'support/hub_golden_harness.dart';

void main() {
  appGoldenTest(
    description: 'Item Page',
    fileName: 'item_page',
    scenarioName: 'default',
    child: buildHubGoldenHarnessWithShell(
      shellPage: ItemPage(
        itemId: '1',
      ),
      extraBlocProviders: [
        BlocProvider<ItemCubit>(create: (_) => ItemCubit(repository: FakeItemsRepository())..load('1')),
      ],
    ),
  );
}
