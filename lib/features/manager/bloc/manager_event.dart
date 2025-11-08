import 'package:freezed_annotation/freezed_annotation.dart';

part 'manager_event.freezed.dart';

@freezed
class ManagerEvent with _$ManagerEvent {
  const factory ManagerEvent.fetchAllData() = _FetchAllData;

  const factory ManagerEvent.deleteTask({required String taskId}) = _DeleteTask;
}
