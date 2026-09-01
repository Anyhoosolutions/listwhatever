import 'package:core_models/core_models.dart';
import 'package:listwhatever/shared/cubit_helpers/loadable_state.dart';

class ListItemsState extends LoadableState<List<ListItem>> {
  const ListItemsState({
    super.data,
    super.errorMessage,
    super.isLoading = false,
  });
}
