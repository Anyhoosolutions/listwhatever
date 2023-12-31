
import 'package:bloc/bloc.dart';
import 'package:listanything/standard/analyticsRepository/analytics_repository.dart';
import 'package:listanything/standard/analyticsRepository/models/analytics_event.dart';
import 'package:listanything/standard/constants.dart';

class AppBlocObserver extends BlocObserver {
  AppBlocObserver({
    required AnalyticsRepository analyticsRepository,
  }) : _analyticsRepository = analyticsRepository;

  final AnalyticsRepository _analyticsRepository;

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    logger.i('onTransition ${bloc.runtimeType}: $transition');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logger.e('onError ${bloc.runtimeType}', error: error, stackTrace: stackTrace);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    final dynamic state = change.nextState;
    if (state is AnalyticsEventMixin) _analyticsRepository.track(state.event);
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (event is AnalyticsEventMixin) _analyticsRepository.track(event.event);
  }
}
