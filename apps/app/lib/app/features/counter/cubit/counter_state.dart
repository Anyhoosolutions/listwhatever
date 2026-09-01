import 'package:listwhatever/shared/cubit_helpers/loadable_state.dart';

class CounterState extends LoadableState<int> {
  const CounterState({
    super.data,
    super.errorMessage,
    super.isLoading = false,
  });
}
