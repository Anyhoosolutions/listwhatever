import 'package:bloc/bloc.dart';
import 'package:lowercase_app_name/app/features/counter/cubit/counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState());

  Future<void> load() async {
    emit(const CounterState(isLoading: true));
    try {
      emit(CounterState(data: 0, isLoading: false));
    } catch (error) {
      emit(CounterState(errorMessage: error.toString()));
    }
  }

  Future<void> increment() async {
    var updatedValue = (state.data ?? 0);
    updatedValue++;
    emit(const CounterState(isLoading: true));
    try {
      emit(CounterState(data: updatedValue));
    } catch (error) {
      emit(CounterState(errorMessage: error.toString()));
    }
  }
}
