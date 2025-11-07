import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/di/get_it.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/task/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final SupabaseClient client;

  EmployeeBloc({required this.client}) : super(EmployeeState.initial()) {
    on<EmployeeEvent>((event, emit) async {
      await event.when(
        initialize: () {
          EmployeeEvent.fetchTasks(employeeId: client.auth.currentUser!.id);
        },
        fetchTasks: (id) async {
          emit(const EmployeeState.loading());

          try {
            final response = await client
                .from('tasks')
                .select()
                .eq('assigned_to', id)
                .order('created_at', ascending: false);

            final tasks = (response as List)
                .map((taskJson) => Task.fromJson(taskJson))
                .toList();

            emit(EmployeeState.loaded(tasks: tasks));
          } catch (e) {
            emit(
              EmployeeState.error(
                message: 'Failed to fetch tasks: ${e.toString()}',
              ),
            );
          }
        },
      );
    });
  }
}
