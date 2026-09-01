import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:listwhatever/app/features/lists/cubit/dynamic_lists_cubit.dart';
import 'package:listwhatever/app/features/new_list/new_list_view.dart';

class NewListPage extends StatefulWidget {
  const NewListPage({super.key});

  @override
  State<NewListPage> createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {
  late final TextEditingController _name;
  ListItemIcon _icon = ListItemIcon.movie;
  ListItemIconBackground _color = ListItemIconBackground.blue;
  bool _enableMapView = true;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NewListView(
      nameController: _name,
      icons: ListItemIcon.values,
      selectedIcon: _icon,
      onIconSelected: (icon) => setState(() => _icon = icon),
      colors: ListItemIconBackground.values,
      selectedColor: _color,
      onColorSelected: (color) => setState(() => _color = color),
      enableMapView: _enableMapView,
      onEnableMapViewChanged: (value) => setState(() => _enableMapView = value),
      onShareWithFriends: () {},
      onCreate: () async {
        final navigator = GoRouter.of(context);

        final list = DynamicList(
          id: 'empty',
          title: _name.text,
          icon: _icon,
          hasLocations: _enableMapView,
          ownerId: '',
          description: '',
          visibility: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await context.read<DynamicListsCubit>().create(list);

        if (navigator.canPop()) {
          navigator.pop();
        }
      },
    );
  }
}
