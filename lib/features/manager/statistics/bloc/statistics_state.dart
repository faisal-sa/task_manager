part of 'statistics_bloc.dart';

@freezed
class StatisticsState with _$StatisticsState {
  const factory StatisticsState.initial() = _Initial;
  const factory StatisticsState.loading() = _Loading;
  const factory StatisticsState.error({required String message}) = _Error;
  const factory StatisticsState.loaded({
    required int totalTaskCount,
    required Map<String, int> tasksByStatus,
    required Map<String, int> tasksByPriority,
    required Map<String, int> tasksPerEmployee,
    required Duration? averageCompletionTime,
  }) = _Loaded;
}
