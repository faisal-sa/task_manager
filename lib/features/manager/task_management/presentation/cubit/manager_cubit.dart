import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/usecase/no_params.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/utils/task_filter.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/domain/usecases/add_comment_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/domain/usecases/create_task_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/domain/usecases/delete_task_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/domain/usecases/get_all_employees_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/domain/usecases/get_all_tasks_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/domain/usecases/update_task_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/presentation/cubit/manager_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagerCubit extends Cubit<ManagerState> {
  final GetAllTasksUsecase _getAllTasks;
  final GetAllEmployeesUsecase _getAllEmployees;
  final CreateTaskUsecase _createTask;
  final UpdateTaskUsecase _updateTask;
  final DeleteTaskUsecase _deleteTask;
  final AddCommentUsecase _addComment;

  ManagerCubit({
    required GetAllTasksUsecase getAllTasks,
    required GetAllEmployeesUsecase getAllEmployees,
    required CreateTaskUsecase createTask,
    required UpdateTaskUsecase updateTask,
    required DeleteTaskUsecase deleteTask,
    required AddCommentUsecase addComment,
  }) : _addComment = addComment,
       _deleteTask = deleteTask,
       _updateTask = updateTask,
       _createTask = createTask,
       _getAllEmployees = getAllEmployees,
       _getAllTasks = getAllTasks,
       super(ManagerInitial());

  Future<void> fetchAllData() async {
    emit(ManagerLoading());
    final tasksResult = await _getAllTasks(NoParams()).run();
    final employeesResult = await _getAllEmployees(NoParams()).run();

    tasksResult.fold((failure) => emit(ManagerError(failure.message)), (
      tasks,
    ) async {
      employeesResult.fold(
        (failure) => emit(ManagerError(failure.message)),
        (employees) =>
            emit(ManagerLoaded(allTasks: tasks, employees: employees)),
      );
    });
  }

  Future<void> createTask(CreateTaskParams params) async {
    final result = await _createTask(params).run();
    result.fold(
      (failure) => emit(ManagerError(failure.message)),
      (_) => fetchAllData(),
    );
  }

  Future<void> updateTask(UpdateTaskParams params) async {
    final result = await _updateTask(params).run();
    result.fold(
      (failure) => emit(ManagerError(failure.message)),
      (_) => fetchAllData(),
    );
  }

  Future<void> deleteTask(String taskId) async {
    final result = await _deleteTask(DeleteTaskParams(taskId: taskId)).run();
    result.fold(
      (failure) => emit(ManagerError(failure.message)),
      (_) => fetchAllData(),
    );
  }

  Future<void> addComment(AddCommentParams params) async {
    final result = await _addComment(params).run();
    result.fold(
      (failure) => emit(ManagerError(failure.message)),
      (_) => fetchAllData(),
    );
  }

  void filterChanged(TaskFilter filter) {
    if (state is ManagerLoaded) {
      emit((state as ManagerLoaded).copyWith(currentFilter: filter));
    }
  }

  void searchQueryChanged(String query) {
    if (state is ManagerLoaded) {
      emit((state as ManagerLoaded).copyWith(searchQuery: query));
    }
  }
}
