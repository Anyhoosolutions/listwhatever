import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:anyhoo_widget_extension_methods/anyhoo_widget_extension_methods.dart';
import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:listwhatever/app/features/add_item/category_attribute_row.dart';
import 'package:listwhatever/app/features/add_item/location_map_preview.dart';
import 'package:listwhatever/app/features/forms/form_section_header.dart';
import 'package:listwhatever/app/features/forms/labeled_form_builder_text_field.dart';
import 'package:listwhatever/i18n/strings.g.dart';

abstract final class AddItemFormFields {
  static const name = 'name';
  static const description = 'description';
  static const latitude = 'latitude';
  static const longitude = 'longitude';

  static final latitudePattern = RegExp(r'^([0-9.]+)° [NS]$');

  static String attributeKey(int id) => 'attributeKey_$id';
  static String attributeValue(int id) => 'attributeValue_$id';
}

class AddItemView extends StatelessWidget {
  const AddItemView({
    super.key,
    required this.formKey,
    required this.list,
    required this.attributeIds,
    required this.onAddAttribute,
    required this.onUseCurrentLocation,
    required this.onCreate,
  });

  final GlobalKey<FormBuilderState> formKey;
  final ListWithItems list;
  final List<int> attributeIds;
  final VoidCallback onAddAttribute;
  final VoidCallback onUseCurrentLocation;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return FormBuilder(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LabeledFormBuilderTextField(
              name: AddItemFormFields.name,
              label: t.addItemPage.itemNameLabel,
              hint: t.addItemPage.itemNameHint,
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            LabeledFormBuilderTextField(
              name: AddItemFormFields.description,
              label: t.addItemPage.descriptionLabel,
              hint: t.addItemPage.descriptionHint,
              maxLines: 4,
            ),
            const SizedBox(height: DesignTokens.spacingLg),
            FormSectionHeader(
              title: t.addItemPage.categoriesTitle,
              subtitle: t.addItemPage.categoriesSubtitle,
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            for (final id in attributeIds) ...[
              CategoryAttributeRow(
                keyFieldName: AddItemFormFields.attributeKey(id),
                valueFieldName: AddItemFormFields.attributeValue(id),
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
                    child: LabeledFormBuilderTextField(
                      name: AddItemFormFields.latitude,
                      label: t.addItemPage.latitudeLabel,
                      hint: t.addItemPage.latitudeHint,
                      initialValue: '34.0522° N',
                      validator: (value) {
                        if (value == null || !AddItemFormFields.latitudePattern.hasMatch(value)) {
                          return t.addItemPage.latitudeInvalid;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacingMd),
                  Expanded(
                    child: LabeledFormBuilderTextField(
                      name: AddItemFormFields.longitude,
                      label: t.addItemPage.longitudeLabel,
                      hint: t.addItemPage.longitudeHint,
                      initialValue: '118.2437° W',
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
        ),
      ),
    ).pad(
      l: DesignTokens.marginMobile,
      t: DesignTokens.spacingMd,
      r: DesignTokens.marginMobile,
      b: DesignTokens.spacingXl,
    );
  }
}
