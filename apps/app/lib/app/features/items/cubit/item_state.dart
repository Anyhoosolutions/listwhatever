import 'package:lowercase_app_name/shared/cubit_helpers/loadable_state.dart';
import 'package:core_models/core_models.dart';

class ItemState extends LoadableState<Item> {
  const ItemState({
    super.data,
    super.errorMessage,
    super.isLoading = false,
  });
}
