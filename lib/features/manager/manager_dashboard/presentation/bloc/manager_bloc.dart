import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/profile/user_profile_model.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/task/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'manager_event.dart';
import 'manager_state.dart';

class ManagerBloc extends Bloc<ManagerEvent, ManagerState> {
  final SupabaseClient client;

  ManagerBloc({required this.client}) : super(ManagerState.initial()) {
    on<ManagerEvent>((event, emit) async {
      await event.when(
        fetchAllData: () async => _fetchAllData(emit, client),
        deleteTask: (taskId) async {
          try {
            await client.from('tasks').delete().eq('id', taskId);

            add(const ManagerEvent.fetchAllData());
          } catch (e) {
            emit(
              ManagerState.error(
                message: 'Failed to delete task: ${e.toString()}',
              ),
            );
          }
        },
        filterChanged: (filter) async {
          state.whenOrNull(
            loaded: (tasks, employees, currentFilter, searchQuery) => emit(
              ManagerState.loaded(
                tasks: tasks,
                employees: employees,
                currentFilter: filter,
              ),
            ),
          );
        },
        searchQueryChanged: (query) async {
          state.whenOrNull(
            loaded: (tasks, employees, currentFilter, searchQuery) => emit(
              ManagerState.loaded(
                tasks: tasks,
                employees: employees,
                searchQuery: query,
              ),
            ),
          );
        },
      );
    });
  }
}

void _fetchAllData(Emitter<ManagerState> emit, SupabaseClient client) async {
  emit(const ManagerState.loading());
  try {
    final responses = await Future.wait([
      client.from('tasks').select().order('created_at', ascending: false),

      client.from('profiles').select('id, full_name').eq('role', 'employee'),
    ]);
    final taskResponse = responses[0] as List;
    final tasks = taskResponse.map((json) => Task.fromJson(json)).toList();

    final employeeResponse = responses[1] as List;
    final employees = employeeResponse
        .map((json) => UserProfile.fromJson(json))
        .toList();

    emit(ManagerState.loaded(tasks: tasks, employees: employees));
  } catch (e) {
    emit(ManagerState.error(message: 'Failed to load data: ${e.toString()}'));
  }
}


//   Future<void> _deleteTask(String taskId, Emitter<ManagerState> emit) async {
//     try {
//       await client.from('tasks').delete().eq('id', taskId);
//       add(const ManagerEvent.fetchAllData());
//     } catch (e) {
//       emit(ManagerState.error(
//         message: 'Failed to delete task: ${e.toString()}',
//       ));
//     }
//   }
// }