import 'package:equatable/equatable.dart';

class LoadableState<T> extends Equatable {
  const LoadableState({
    this.data,
    this.errorMessage,
    this.isLoading = false,
  });

  final T? data;
  final String? errorMessage;
  final bool isLoading;

  @override
  List<Object?> get props => [data, errorMessage, isLoading];
}
