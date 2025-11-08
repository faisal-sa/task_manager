// part of 'statistics_bloc.dart';

// @freezed
// class StatisticsState with _$StatisticsState {
//   const factory StatisticsState.initial() = _Initial;
//   const factory StatisticsState.loading() = _Loading;
//   const factory StatisticsState.loaded({
//     required int totalTasks,
//     required Map<String, int> tasksByStatus,
//     required Map<String, int> tasksByPriority,
//     required List<EmployeeStats> employeeStats,
//     required int overdueTasks,
//     required List<Task> recentTasks,
//   }) = _Loaded;
//   const factory StatisticsState.error({required String message}) = _Error;
// }

// class EmployeeStats {
//   final String employeeName;
//   final int taskCount;

//   EmployeeStats({required this.employeeName, required this.taskCount});
// }
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
