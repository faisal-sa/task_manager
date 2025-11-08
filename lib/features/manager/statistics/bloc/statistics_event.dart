part of 'statistics_bloc.dart';

@freezed
class StatisticsEvent with _$StatisticsEvent {
  const factory StatisticsEvent.fetchStatistics() = _FetchStatistics;
}
