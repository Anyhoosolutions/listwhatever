import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:core_models/core_models.dart';
import 'package:flutter/material.dart';
import 'package:listwhatever/app/features/forms/form_section_header.dart';
import 'package:listwhatever/app/features/forms/labeled_text_field.dart';
import 'package:listwhatever/app/features/new_list/list_icon_picker.dart';
import 'package:listwhatever/app/features/new_list/theme_color_swatch_picker.dart';
import 'package:listwhatever/i18n/strings.g.dart';
import 'package:listwhatever/shared/colorAndIcons/mapping.dart';

class NewListView extends StatelessWidget {
  const NewListView({
    super.key,
    required this.nameController,
    required this.icons,
    required this.selectedIcon,
    required this.onIconSelected,
    required this.colors,
    required this.selectedColor,
    required this.onColorSelected,
    required this.enableMapView,
    required this.onEnableMapViewChanged,
    required this.onShareWithFriends,
    required this.onCreate,
  });

  final TextEditingController nameController;
  final List<ListItemIcon> icons;
  final ListItemIcon selectedIcon;
  final ValueChanged<ListItemIcon> onIconSelected;
  final List<ListItemIconBackground> colors;
  final ListItemIconBackground selectedColor;
  final ValueChanged<ListItemIconBackground> onColorSelected;
  final bool enableMapView;
  final ValueChanged<bool> onEnableMapViewChanged;
  final VoidCallback onShareWithFriends;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final surface = context.surface;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        DesignTokens.marginMobile,
        DesignTokens.spacingMd,
        DesignTokens.marginMobile,
        DesignTokens.spacingXl,
      ),
      children: [
        Center(
          child: Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: ColorMapping.colorFor(selectedColor),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusXl),
                ),
                child: SizedBox(
                  width: 88,
                  height: 88,
                  child: Icon(IconMapping.iconDataFor(selectedIcon), color: Colors.white, size: 40),
                ),
              ),
              const SizedBox(height: DesignTokens.spacingSm),
              Text(
                t.newListPage.previewLabel,
                style: AnyhooTypography.body(BodySize.medium).copyWith(
                  color: surface.secondaryText,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: DesignTokens.spacingLg),
        FormSectionHeader(title: t.newListPage.nameLabel),
        const SizedBox(height: DesignTokens.spacingSm),
        LabeledTextField(
          hint: t.newListPage.nameHint,
          controller: nameController,
        ),
        const SizedBox(height: DesignTokens.spacingLg),
        FormSectionHeader(title: t.newListPage.iconLabel),
        const SizedBox(height: DesignTokens.spacingSm),
        ListIconPicker(
          icons: icons,
          selected: selectedIcon,
          onSelected: onIconSelected,
        ),
        const SizedBox(height: DesignTokens.spacingLg),
        FormSectionHeader(title: t.newListPage.themeColorLabel),
        const SizedBox(height: DesignTokens.spacingSm),
        ThemeColorSwatchPicker(
          colors: colors,
          selected: selectedColor,
          onSelected: onColorSelected,
        ),
        const SizedBox(height: DesignTokens.spacingLg),
        AnyhooCardShell(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spacingMd),
                child: AnyhooSwitch(
                  label: t.newListPage.enableMapView,
                  value: enableMapView,
                  onChanged: onEnableMapViewChanged,
                ),
              ),
              Divider(height: 1, color: surface.cardBorder.withValues(alpha: 0.4)),
              AnyhooListItem(
                title: t.newListPage.shareWithFriends,
                onTap: onShareWithFriends,
              ),
            ],
          ),
        ),
        const SizedBox(height: DesignTokens.spacingLg),
        AnyhooPrimaryButton(
          label: t.newListPage.createList,
          fullWidth: true,
          onPressed: onCreate,
        ),
      ],
    );
  }
}
