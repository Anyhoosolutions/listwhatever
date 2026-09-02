import 'package:core_models/core_models.dart';
import 'package:listwhatever/shared/cubit_helpers/loadable_state.dart';

class ListWithItemsState extends LoadableState<ListWithItems> {
  const ListWithItemsState({
    super.data,
    super.errorMessage,
    super.isLoading = false,
  });
}
