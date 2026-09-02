import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:anyhoo_widget_extension_methods/anyhoo_widget_extension_methods.dart';
import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:listwhatever/app/features/add_item/add_item_form_fields.dart';
import 'package:listwhatever/app/features/add_item/category_attribute_rows.dart';
import 'package:listwhatever/app/features/add_item/location_map_preview.dart';
import 'package:listwhatever/app/features/forms/form_section_header.dart';
import 'package:listwhatever/app/features/forms/labeled_form_builder_text_field.dart';
import 'package:listwhatever/app/features/geocoding/coordinate_format.dart';
import 'package:listwhatever/app/features/geocoding/geocoding_result.dart';
import 'package:listwhatever/i18n/strings.g.dart';

class AddItemView extends StatelessWidget {
  const AddItemView({
    super.key,
    required this.formKey,
    required this.list,
    required this.attributeIds,
    required this.onAddAttribute,
    required this.onSearchLocation,
    required this.onUseCurrentLocation,
    required this.onCreate,
  });

  final GlobalKey<FormBuilderState> formKey;
  final ListWithItems list;
  final List<int> attributeIds;
  final VoidCallback onAddAttribute;
  final VoidCallback onSearchLocation;
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
            CategoryAttributeRows(
              list: list,
              attributeIds: attributeIds,
              onAddAttribute: onAddAttribute,
            ),
            const SizedBox(height: DesignTokens.spacingLg),
            if (list.hasLocations) ...[
              FormSectionHeader(title: t.addItemPage.locationTitle),
              const SizedBox(height: DesignTokens.spacingMd),
              FormBuilderField<GeocodingResult>(
                name: AddItemFormFields.location,
                validator: (value) {
                  if (value == null) {
                    return t.addItemPage.locationRequired;
                  }
                  return null;
                },
                builder: (field) {
                  final location = field.value;
                  final surface = context.surface;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LocationMapPreview(
                        tapToSetLabel: location == null ? t.addItemPage.tapToSet : t.addItemPage.changeLocation,
                        showPin: location != null,
                        onTap: onSearchLocation,
                      ),
                      const SizedBox(height: DesignTokens.spacingMd),
                      Row(
                        children: [
                          Text(
                            location?.displayName ?? t.addItemPage.noLocationSelected,
                            style: AnyhooTypography.body(BodySize.large).copyWith(
                              color: location == null ? surface.secondaryText : surface.primaryText,
                            ),
                          ),
                          if (location != null) ...[
                            Spacer(),
                            const SizedBox(height: DesignTokens.spacingXs),
                            Text(
                              '(${formatLatitude(location.latitude)}, ${formatLongitude(location.longitude)})',
                              style: AnyhooTypography.body(BodySize.medium).copyWith(
                                color: surface.secondaryText,
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (field.errorText != null) ...[
                        const SizedBox(height: DesignTokens.spacingXs),
                        Text(
                          field.errorText!,
                          style: AnyhooTypography.label(LabelSize.medium).copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
              // const SizedBox(height: DesignTokens.spacingMd),
              // AnyhooSecondaryButton(
              //   label: t.addItemPage.useCurrentLocation,
              //   leadingIcon: Icons.my_location,
              //   fullWidth: true,
              //   onPressed: onUseCurrentLocation,
              // ),
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
