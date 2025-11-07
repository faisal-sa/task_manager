import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/task/task_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_state.freezed.dart';

@freezed
class EmployeeState with _$EmployeeState {
  const factory EmployeeState.initial() = _Initial;
  const factory EmployeeState.loading() = _Loading;
  const factory EmployeeState.loaded({required List<Task> tasks}) = _Loaded;
  const factory EmployeeState.error({required String message}) = _Error;
}
