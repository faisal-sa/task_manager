import 'package:bloc/bloc.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/profile/user_profile_model.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/task/task_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';
part 'statistics_bloc.freezed.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final SupabaseClient client;

  StatisticsBloc({required this.client})
    : super(const StatisticsState.initial()) {
    on<_FetchStatistics>((event, emit) async {
      emit(const StatisticsState.loading());
      try {
        final responses = await Future.wait([
          client
              .from('tasks')
              .select(
                'id, title, status, priority, created_at, assigned_to, completed_at',
              ),
          client
              .from('profiles')
              .select('id, full_name')
              .eq('role', 'employee'),
        ]);

        final taskResponse = responses[0] as List;
        final tasks = taskResponse
            .map((json) => Task.fromJson(json as Map<String, dynamic>))
            .toList();

        final employeeResponse = responses[1] as List;
        final employees = employeeResponse
            .map((json) => UserProfile.fromJson(json as Map<String, dynamic>))
            .toList();
        final employeeMap = {for (var e in employees) e.id: e.fullName};

        final totalTaskCount = tasks.length;

        final tasksByStatus = <TaskStatus, int>{};
        for (final task in tasks) {
          tasksByStatus.update(
            task.status,
            (value) => value + 1,
            ifAbsent: () => 1,
          );
        }

        final tasksByPriority = <TaskPriority, int>{};
        for (final task in tasks) {
          tasksByPriority.update(
            task.priority,
            (value) => value + 1,
            ifAbsent: () => 1,
          );
        }

        final tasksPerEmployee = <String, int>{};
        for (final task in tasks) {
          if (task.assignedTo != null) {
            final employeeName =
                employeeMap[task.assignedTo] ?? 'Unassigned/Unknown';
            tasksPerEmployee.update(
              employeeName,
              (value) => value + 1,
              ifAbsent: () => 1,
            );
          }
        }

        Duration? averageCompletionTime;
        final completedTasks = tasks
            .where((t) => t.completedAt != null)
            .toList();
        if (completedTasks.isNotEmpty) {
          final totalDuration = completedTasks.fold<Duration>(
            Duration.zero,
            (previousValue, task) =>
                previousValue + task.completedAt!.difference(task.createdAt),
          );
          averageCompletionTime = Duration(
            microseconds: totalDuration.inMicroseconds ~/ completedTasks.length,
          );
        }

        emit(
          StatisticsState.loaded(
            totalTaskCount: totalTaskCount,
            tasksByStatus: tasksByStatus.map(
              (key, value) =>
                  MapEntry(key.name.replaceAll('_', ' ').toUpperCase(), value),
            ),
            tasksByPriority: tasksByPriority.map(
              (key, value) => MapEntry(key.name.toUpperCase(), value),
            ),
            tasksPerEmployee: tasksPerEmployee,
            averageCompletionTime: averageCompletionTime,
          ),
        );
      } catch (e) {
        emit(StatisticsState.error(message: 'Failed to load statistics: $e'));
      }
    });
  }
}
