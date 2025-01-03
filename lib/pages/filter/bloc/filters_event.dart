import 'package:listwhatever/pages/list/models/filters.dart';

sealed class FiltersEvent {}

class UpdateFilters extends FiltersEvent {
  UpdateFilters(this.filters);
  final Filters filters;
}
