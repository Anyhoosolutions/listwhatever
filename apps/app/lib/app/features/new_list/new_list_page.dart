import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/new_list/list_icon_picker.dart';
import 'package:listwhatever/app/features/new_list/new_list_view.dart';

class NewListPage extends StatefulWidget {
  const NewListPage({super.key});

  static const icons = [
    ListIconOption(icon: Icons.explore_outlined),
    ListIconOption(icon: Icons.restaurant_outlined),
    ListIconOption(icon: Icons.local_cafe_outlined),
    ListIconOption(icon: Icons.flight_outlined),
    ListIconOption(icon: Icons.shopping_bag_outlined),
    ListIconOption(icon: Icons.fitness_center_outlined),
  ];

  static const colors = [
    Color(0xFF3B82F6),
    Color(0xFFEF4444),
    Color(0xFF10B981),
    Color(0xFFF59E0B),
    Color(0xFF8B5CF6),
    Color(0xFFEA580C),
    Color(0xFF06B6D4),
    Color(0xFFEC4899),
    Color(0xFFA78BFA),
    Color(0xFF84CC16),
    Color(0xFF64748B),
    Color(0xFFD946EF),
  ];

  @override
  State<NewListPage> createState() => _NewListPageState();
}

class _NewListPageState extends State<NewListPage> {
  late final TextEditingController _name;
  IconData _icon = NewListPage.icons.first.icon;
  Color _color = NewListPage.colors.first;
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
      icons: NewListPage.icons,
      selectedIcon: _icon,
      onIconSelected: (icon) => setState(() => _icon = icon),
      colors: NewListPage.colors,
      selectedColor: _color,
      onColorSelected: (color) => setState(() => _color = color),
      enableMapView: _enableMapView,
      onEnableMapViewChanged: (value) => setState(() => _enableMapView = value),
      onShareWithFriends: () {},
      onCreate: () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
