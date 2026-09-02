import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:anyhoo_widget_extension_methods/anyhoo_widget_extension_methods.dart';
import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/add_item/category_attribute_row.dart';
import 'package:listwhatever/app/features/add_item/location_map_preview.dart';
import 'package:listwhatever/app/features/forms/form_section_header.dart';
import 'package:listwhatever/app/features/forms/labeled_text_field.dart';
import 'package:listwhatever/i18n/strings.g.dart';

class AttributeFieldPair {
  const AttributeFieldPair({required this.keyController, required this.valueController});

  final TextEditingController keyController;
  final TextEditingController valueController;
}

class AddItemView extends StatelessWidget {
  const AddItemView({
    super.key,
    required this.list,
    required this.nameController,
    required this.descriptionController,
    required this.latitudeController,
    required this.longitudeController,
    required this.attributes,
    required this.onAddAttribute,
    required this.onUseCurrentLocation,
    required this.onCreate,
  });

  final ListWithItems list;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController latitudeController;
  final TextEditingController longitudeController;
  final List<AttributeFieldPair> attributes;
  final VoidCallback onAddAttribute;
  final VoidCallback onUseCurrentLocation;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    print('list: ${list.toJson()}');

    return ListView(
      children: [
        LabeledTextField(
          label: t.addItemPage.itemNameLabel,
          hint: t.addItemPage.itemNameHint,
          controller: nameController,
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        LabeledTextField(
          label: t.addItemPage.descriptionLabel,
          hint: t.addItemPage.descriptionHint,
          controller: descriptionController,
          maxLines: 4,
        ),
        const SizedBox(height: DesignTokens.spacingLg),
        FormSectionHeader(
          title: t.addItemPage.categoriesTitle,
          subtitle: t.addItemPage.categoriesSubtitle,
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        for (final attribute in attributes) ...[
          CategoryAttributeRow(
            keyController: attribute.keyController,
            valueController: attribute.valueController,
            keyHint: t.addItemPage.attributeKeyHint,
            valueHint: t.addItemPage.attributeValueHint,
          ),
          const SizedBox(height: DesignTokens.spacingSm),
        ],
        Align(
          alignment: Alignment.centerLeft,
          child: AnyhooTextButton(
            label: t.addItemPage.addCategory,
            leadingIcon: Icons.add,
            onPressed: onAddAttribute,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingLg),
        if (list.hasLocations) ...[
          FormSectionHeader(title: t.addItemPage.locationTitle),
          const SizedBox(height: DesignTokens.spacingMd),
          LocationMapPreview(
            tapToSetLabel: t.addItemPage.tapToSet,
            onTap: onUseCurrentLocation,
          ),
          const SizedBox(height: DesignTokens.spacingMd),
          Row(
            children: [
              Expanded(
                child: LabeledTextField(
                  label: t.addItemPage.latitudeLabel,
                  hint: t.addItemPage.latitudeHint,
                  controller: latitudeController,
                ),
              ),
              const SizedBox(width: DesignTokens.spacingMd),
              Expanded(
                child: LabeledTextField(
                  label: t.addItemPage.longitudeLabel,
                  hint: t.addItemPage.longitudeHint,
                  controller: longitudeController,
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacingMd),
          AnyhooSecondaryButton(
            label: t.addItemPage.useCurrentLocation,
            leadingIcon: Icons.my_location,
            fullWidth: true,
            onPressed: onUseCurrentLocation,
          ),
          const SizedBox(height: DesignTokens.spacingLg),
        ],

        AnyhooPrimaryButton(
          label: t.addItemPage.createItem,
          fullWidth: true,
          onPressed: onCreate,
        ),
      ],
    ).pad(
      l: DesignTokens.marginMobile,
      t: DesignTokens.spacingMd,
      r: DesignTokens.marginMobile,
      b: DesignTokens.spacingXl,
    );
  }
}
