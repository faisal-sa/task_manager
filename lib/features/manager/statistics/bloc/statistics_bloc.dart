import 'package:bloc/bloc.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/profile/user_profile_model.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/task/task_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// part 'statistics_event.dart';
// part 'statistics_state.dart';
// part 'statistics_bloc.freezed.dart';

// class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
//   final SupabaseClient client;

//   StatisticsBloc({required this.client}) : super(const _Initial()) {
//     on<StatisticsEvent>((event, emit) async {
//       await event.when(
//         started: () async => _fetchStatistics(emit),
//         refresh: () async => _fetchStatistics(emit),
//       );
//     });
//   }

//   Future<void> _fetchStatistics(Emitter<StatisticsState> emit) async {
//     emit(const StatisticsState.loading());
//     try {
//       // Fetch tasks, employees, and recent tasks in parallel
//       final responses = await Future.wait([
//         client.from('tasks').select(),
//         client.from('profiles').select('id, full_name').eq('role', 'employee'),
//         client
//             .from('tasks')
//             .select()
//             .order('created_at', ascending: false)
//             .limit(10),
//       ]);

//       final tasksResponse = responses[0] as List;
//       final allTasks = tasksResponse
//           .map((json) => Task.fromJson(json))
//           .toList();

//       final employeesResponse = responses[1] as List;
//       final employees = employeesResponse
//           .map((json) => UserProfile.fromJson(json))
//           .toList();

//       final recentTasksResponse = responses[2] as List;
//       final recentTasks = recentTasksResponse
//           .map((json) => Task.fromJson(json))
//           .toList();

//       // Calculate statistics
//       final totalTasks = allTasks.length;

//       final tasksByStatus = <String, int>{};
//       final tasksByPriority = <String, int>{};

//       for (var task in allTasks) {
//         tasksByStatus[task.status.toString()] =
//             (tasksByStatus[task.status] ?? 0) + 1;
//         tasksByPriority[task.priority.toString()] =
//             (tasksByPriority[task.priority] ?? 0) + 1;
//       }

//       final overdueTasks = allTasks.where((task) {
//         return task.dueDate != null &&
//             task.dueDate!.isBefore(DateTime.now()) &&
//             task.status != 'completed';
//       }).length;

//       // Calculate tasks per employee
//       final employeeStats = employees.map((employee) {
//         final taskCount = allTasks
//             .where((task) => task.assignedTo == employee.id)
//             .length;
//         return EmployeeStats(
//           employeeName: employee.fullName,
//           taskCount: taskCount,
//         );
//       }).toList();

//       emit(
//         StatisticsState.loaded(
//           totalTasks: totalTasks,
//           tasksByStatus: tasksByStatus,
//           tasksByPriority: tasksByPriority,
//           employeeStats: employeeStats,
//           overdueTasks: overdueTasks,
//           recentTasks: recentTasks,
//         ),
//       );
//     } catch (e) {
//       emit(
//         StatisticsState.error(
//           message: 'Failed to load statistics: ${e.toString()}',
//         ),
//       );
//     }
//   }
// }

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
        // Fetch tasks and employee profiles in parallel
        final responses = await Future.wait([
          // CORRECTED QUERY: Added 'id' and 'title' to satisfy the Task model's requirements.
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
        // This will now parse successfully
        final tasks = taskResponse
            .map((json) => Task.fromJson(json as Map<String, dynamic>))
            .toList();

        final employeeResponse = responses[1] as List;
        final employees = employeeResponse
            .map((json) => UserProfile.fromJson(json as Map<String, dynamic>))
            .toList();
        final employeeMap = {for (var e in employees) e.id: e.fullName};

        // --- Perform Calculations (Now using enums for type safety) ---

        // 1. Total tasks
        final totalTaskCount = tasks.length;

        // 2. Tasks by Status
        // The key is now the enum itself, which is safer. We'll use .name to display it.
        final tasksByStatus = <TaskStatus, int>{};
        for (final task in tasks) {
          tasksByStatus.update(
            task.status,
            (value) => value + 1,
            ifAbsent: () => 1,
          );
        }

        // 3. Tasks by Priority
        final tasksByPriority = <TaskPriority, int>{};
        for (final task in tasks) {
          tasksByPriority.update(
            task.priority,
            (value) => value + 1,
            ifAbsent: () => 1,
          );
        }

        // 4. Tasks per Employee
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

        // 5. Average Completion Time
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
            // Convert enum map to string map for the UI state
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
