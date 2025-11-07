import 'package:freezed_annotation/freezed_annotation.dart';

part 'manager_event.freezed.dart';

@freezed
class ManagerEvent with _$ManagerEvent {
  // Event to fetch all data needed for the manager view
  const factory ManagerEvent.fetchAllData() = _FetchAllData;

  // Event to delete a specific task
  const factory ManagerEvent.deleteTask({required String taskId}) = _DeleteTask;
}
