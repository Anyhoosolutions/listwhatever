import 'package:equatable/equatable.dart';
import 'package:allmylists/standard/analyticsRepository/index.dart' as analytics;

sealed class AnalyticsEvent extends Equatable {
  const AnalyticsEvent();
}

class TrackAnalyticsEvent extends AnalyticsEvent {
  const TrackAnalyticsEvent(this.event);

  final analytics.AnalyticsEvent event;

  @override
  List<Object> get props => [event];
}
