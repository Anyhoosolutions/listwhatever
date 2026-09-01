import 'package:lowercase_app_name/app/features/items/cubit/item_cubit.dart';
import 'package:lowercase_app_name/app/features/items/cubit/item_state.dart';
import 'package:lowercase_app_name/app/features/items/item_skeleton.dart';
import 'package:lowercase_app_name/app/features/items/item_view.dart';
import 'package:lowercase_app_name/shared/cubit_helpers/state_switcher.dart';
import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key, required this.itemId});

  final String itemId;

  @override
  Widget build(BuildContext context) {
    return StateSwitcher<ItemCubit, ItemState, Item>(
      skeleton: const ItemSkeleton(),
      successBuilder: (context, item, cubit) {
        return ItemView(
          item: item,
          onRefresh: () => cubit.load(itemId),
        );
      },
    );
  }
}
