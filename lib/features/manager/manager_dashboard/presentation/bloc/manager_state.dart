import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/profile/user_profile_model.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/task/task_model.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/utils/task_filter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'manager_state.freezed.dart';

@freezed
class ManagerState with _$ManagerState {
  const factory ManagerState.initial() = _Initial;
  const factory ManagerState.loading() = _Loading;

  const factory ManagerState.loaded({
    required List<Task> tasks,
    required List<UserProfile> employees,
    @Default(TaskFilter.all) TaskFilter currentFilter,
    @Default('') String searchQuery,
  }) = _Loaded;

  const factory ManagerState.error({required String message}) = _Error;
}

extension ManagerStateX on ManagerState {
  List<Task> get filteredTasks {
    return whenOrNull(
          loaded: (tasks, employees, currentFilter, searchQuery) {
            List<Task> tasksToShow = tasks;

            if (currentFilter == TaskFilter.inProgress) {
              tasksToShow = tasksToShow
                  .where((task) => task.status == TaskStatus.in_progress)
                  .toList();
            } else if (currentFilter == TaskFilter.completed) {
              tasksToShow = tasksToShow
                  .where((task) => task.status == TaskStatus.completed)
                  .toList();
            }

            if (searchQuery.isNotEmpty) {
              final query = searchQuery.toLowerCase();
              tasksToShow = tasksToShow.where((task) {
                final titleMatch = task.title.toLowerCase().contains(query);

                final assigneeName = employees
                    .firstWhere(
                      (emp) => emp.id == task.assignedTo,
                      orElse: () =>
                          const UserProfile(id: '', fullName: 'Unassigned'),
                    )
                    .fullName;
                final assigneeMatch = assigneeName.toLowerCase().contains(
                  query,
                );

                return titleMatch || assigneeMatch;
              }).toList();
            }

            return tasksToShow;
          },
        ) ??
        [];
  }
}
