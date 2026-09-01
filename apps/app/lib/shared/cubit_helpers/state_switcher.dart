import 'package:anyhoo_core/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listwhatever/shared/cubit_helpers/loadable_shimmer.dart';
import 'package:listwhatever/shared/cubit_helpers/loadable_state.dart';

typedef StateSuccessBuilder<B extends StateStreamable<S>, S extends LoadableState<T>, T> =
    Widget Function(BuildContext context, T data, B bloc);

class StateSwitcher<B extends StateStreamable<S>, S extends LoadableState<T>, T> extends StatelessWidget {
  const StateSwitcher({
    required this.successBuilder,
    required this.skeleton,
    this.emptyBuilder,
    super.key,
  });

  final StateSuccessBuilder<B, S, T> successBuilder;
  final Widget skeleton;
  final Widget Function(BuildContext context, B bloc)? emptyBuilder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      builder: (context, state) {
        final bloc = context.read<B>();

        if (state.isLoading) {
          return loadableShimmer(context, skeleton);
        }

        if (state.errorMessage != null) {
          return ErrorPage(errorMessage: state.errorMessage!);
        }

        final data = state.data;
        if (data == null) {
          return const SizedBox.shrink();
        }

        if (emptyBuilder != null && data is List && data.isEmpty) {
          return emptyBuilder!(context, bloc);
        }

        return successBuilder(context, data, bloc);
      },
    );
  }
}
