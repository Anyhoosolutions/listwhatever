import 'package:listwhatever/pages/list/models/filters.dart';

sealed class FiltersState {}

class FiltersInitial extends FiltersState {}

class FiltersLoading extends FiltersState {}

class FiltersLoaded extends FiltersState {
  FiltersLoaded({required this.filters});
  final Filters filters;
}
