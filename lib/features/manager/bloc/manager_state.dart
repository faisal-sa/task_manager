import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/profile/user_profile_model.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/task/task_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'manager_state.freezed.dart';

@freezed
class ManagerState with _$ManagerState {
  const factory ManagerState.initial() = _Initial;
  const factory ManagerState.loading() = _Loading;

  const factory ManagerState.loaded({
    required List<Task> tasks,
    required List<UserProfile> employees,
  }) = _Loaded;

  const factory ManagerState.error({required String message}) = _Error;
}
