import 'package:flutter/material.dart';
import 'package:listwhatever/pages/filter/components/filter_view.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({required this.listId, super.key});
  final String listId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
      ),
      body: FilterView(
        listId: listId,
        showSubmitButton: true,
      ),
    );
  }
}
