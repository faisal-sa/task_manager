import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/utils/task_filter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'manager_event.freezed.dart';

@freezed
class ManagerEvent with _$ManagerEvent {
  const factory ManagerEvent.fetchAllData() = _FetchAllData;

  const factory ManagerEvent.deleteTask({required String taskId}) = _DeleteTask;
  const factory ManagerEvent.filterChanged({required TaskFilter filter}) =
      _FilterChanged;

  const factory ManagerEvent.searchQueryChanged({required String query}) =
      _SearchQueryChanged;
}
