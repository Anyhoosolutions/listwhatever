import 'dart:async';

import 'package:anyhoo_design_system/anyhoo_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listwhatever/app/features/forms/labeled_text_field.dart';
import 'package:listwhatever/app/features/geocoding/cubit/geocoding_cubit.dart';
import 'package:listwhatever/app/features/geocoding/cubit/geocoding_state.dart';
import 'package:listwhatever/app/features/geocoding/geocoding_result.dart';
import 'package:listwhatever/i18n/strings.g.dart';

class LocationSearchSheet extends StatefulWidget {
  const LocationSearchSheet({super.key});

  static Future<GeocodingResult?> show(BuildContext context) {
    final cubit = context.read<GeocodingCubit>()..clear();
    return showModalBottomSheet<GeocodingResult>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return BlocProvider.value(
          value: cubit,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(sheetContext).bottom),
            child: const LocationSearchSheet(),
          ),
        );
      },
    );
  }

  @override
  State<LocationSearchSheet> createState() => _LocationSearchSheetState();
}

class _LocationSearchSheetState extends State<LocationSearchSheet> {
  final _queryController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _queryController.dispose();
    super.dispose();
  }

  void _onQueryChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<GeocodingCubit>().search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final surface = context.surface;

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.55,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            DesignTokens.marginMobile,
            DesignTokens.spacingSm,
            DesignTokens.marginMobile,
            DesignTokens.spacingMd,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                t.addItemPage.searchAddressTitle,
                style: AnyhooTypography.headline(HeadlineSize.small).copyWith(
                  color: surface.primaryText,
                ),
              ),
              const SizedBox(height: DesignTokens.spacingMd),
              LabeledTextField(
                hint: t.addItemPage.searchAddressHint,
                controller: _queryController,
                onChanged: _onQueryChanged,
              ),
              const SizedBox(height: DesignTokens.spacingMd),
              Expanded(
                child: BlocBuilder<GeocodingCubit, GeocodingState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.errorMessage != null) {
                      return Center(
                        child: Text(
                          t.addItemPage.searchAddressError,
                          style: AnyhooTypography.body(BodySize.medium).copyWith(
                            color: surface.secondaryText,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    final results = state.data ?? const <GeocodingResult>[];
                    if (results.isEmpty) {
                      return Center(
                        child: Text(
                          t.addItemPage.noAddressResults,
                          style: AnyhooTypography.body(BodySize.medium).copyWith(
                            color: surface.secondaryText,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: results.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final result = results[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.place_outlined, color: context.accent.primaryFixed),
                          title: Text(
                            result.displayName,
                            style: AnyhooTypography.body(BodySize.large).copyWith(
                              color: surface.primaryText,
                            ),
                          ),
                          onTap: () => Navigator.of(context).pop(result),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
