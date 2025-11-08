import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_event.freezed.dart';

@freezed
class EmployeeEvent with _$EmployeeEvent {
  const factory EmployeeEvent.initialize() = _Initialize;
  const factory EmployeeEvent.fetchTasks({required String employeeId}) =
      _FetchTasks;

  // filtering tasks
  const factory EmployeeEvent.filterTasks({
    required String employeeId,
    required String priority,
  }) = _FilterTasks;

  const factory EmployeeEvent.fetchPerformanceStats({
    required String employeeId,
  }) = _FetchPerformanceStats;
}
