// part of 'statistics_bloc.dart';

// @freezed
// class StatisticsEvent with _$StatisticsEvent {
//   const factory StatisticsEvent.started() = _Started;
//   const factory StatisticsEvent.refresh() = _Refresh;
// }

part of 'statistics_bloc.dart';

@freezed
class StatisticsEvent with _$StatisticsEvent {
  const factory StatisticsEvent.fetchStatistics() = _FetchStatistics;
}
