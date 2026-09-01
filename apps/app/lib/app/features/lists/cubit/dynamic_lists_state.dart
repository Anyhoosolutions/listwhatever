import 'package:core_models/core_models.dart';
import 'package:listwhatever/shared/cubit_helpers/loadable_state.dart';

class DynamicListsState extends LoadableState<List<DynamicList>> {
  const DynamicListsState({
    super.data,
    super.errorMessage,
    super.isLoading = false,
  });
}
