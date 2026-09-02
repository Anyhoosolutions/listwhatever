import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/add_item/add_item_form_fields.dart';
import 'package:listwhatever/app/features/add_item/category_attribute_row.dart';
import 'package:listwhatever/app/features/add_item/category_values_from_items.dart';
import 'package:listwhatever/i18n/strings.g.dart';

class CategoryAttributeRows extends StatefulWidget {
  const CategoryAttributeRows({
    super.key,
    required this.list,
    required this.attributeIds,
    required this.onAddAttribute,
  });

  final ListWithItems list;
  final List<int> attributeIds;
  final VoidCallback onAddAttribute;

  @override
  State<CategoryAttributeRows> createState() => _CategoryAttributeRowsState();
}

class _CategoryAttributeRowsState extends State<CategoryAttributeRows> {
  late Map<String, List<String>> _valuesByCategory;

  @override
  void initState() {
    super.initState();
    _valuesByCategory = categoryValuesFromItems(widget.list.items);
  }

  @override
  void didUpdateWidget(CategoryAttributeRows oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.list, widget.list)) {
      _valuesByCategory = categoryValuesFromItems(widget.list.items);
    }
  }

  void _addCategory(String key) {
    final category = key.trim();
    if (category.isEmpty) {
      return;
    }
    setState(() {
      _valuesByCategory.putIfAbsent(category, () => []);
    });
  }

  void _addValue(String key, String value) {
    final category = key.trim();
    final trimmedValue = value.trim();
    if (category.isEmpty || trimmedValue.isEmpty) {
      return;
    }
    setState(() {
      final existing = _valuesByCategory.putIfAbsent(category, () => []);
      if (!existing.contains(trimmedValue)) {
        _valuesByCategory[category] = [...existing, trimmedValue]..sort();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final categoryKeys = _valuesByCategory.keys.toList()..sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final id in widget.attributeIds) ...[
          CategoryAttributeRow(
            keyFieldName: AddItemFormFields.attributeKey(id),
            valueFieldName: AddItemFormFields.attributeValue(id),
            keyHint: t.addItemPage.attributeKeyHint,
            valueHint: t.addItemPage.attributeValueHint,
            categoryKeys: categoryKeys,
            valuesFor: (key) => _valuesByCategory[key] ?? [],
            onCategoryCreated: _addCategory,
            onValueCreated: _addValue,
          ),
          const SizedBox(height: DesignTokens.spacingSm),
        ],
        Align(
          alignment: Alignment.centerLeft,
          child: AnyhooTextButton(
            label: t.addItemPage.addCategory,
            leadingIcon: Icons.add,
            onPressed: widget.onAddAttribute,
          ),
        ),
      ],
    );
  }
}
