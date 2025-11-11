import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/usecase/no_params.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/usecases/add_comment_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/usecases/create_task_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/usecases/delete_task_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/usecases/get_all_employees_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/usecases/get_all_tasks_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/usecases/update_task_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/presentation/bloc/manager_event.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/presentation/bloc/manager_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagerBloc extends Bloc<ManagerEvent, ManagerState> {
  final GetAllTasksUsecase getAllTasks;
  final GetAllEmployeesUsecase getAllEmployees;
  final CreateTaskUsecase createTask;
  final UpdateTaskUsecase updateTask;
  final DeleteTaskUsecase deleteTask;
  final AddCommentUsecase addComment;

  ManagerBloc({
    required this.getAllTasks,
    required this.getAllEmployees,
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
    required this.addComment,
  }) : super(ManagerInitial()) {
    on<FetchAllData>(_onFetchAllData);
    on<CreateTask>(_onCreateTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<AddComment>(_onAddComment);
    on<FilterChanged>(_onFilterChanged);
    on<SearchQueryChanged>(_onSearchQueryChanged);
  }

  Future<void> _onFetchAllData(
    FetchAllData event,
    Emitter<ManagerState> emit,
  ) async {
    emit(ManagerLoading());
    final tasksResult = await getAllTasks(NoParams()).run();
    final employeesResult = await getAllEmployees(NoParams()).run();

    tasksResult.fold((failure) => emit(ManagerError(failure.message)), (tasks) {
      employeesResult.fold(
        (failure) => emit(ManagerError(failure.message)),
        (employees) =>
            emit(ManagerLoaded(allTasks: tasks, employees: employees)),
      );
    });
  }

  Future<void> _onCreateTask(
    CreateTask event,
    Emitter<ManagerState> emit,
  ) async {
    final result = await createTask(event.params).run();
    result.fold(
      (failure) => emit(ManagerError(failure.message)),
      (_) => add(FetchAllData()), // Refresh all data on success
    );
  }

  Future<void> _onUpdateTask(
    UpdateTask event,
    Emitter<ManagerState> emit,
  ) async {
    final result = await updateTask(event.params).run();
    result.fold(
      (failure) => emit(ManagerError(failure.message)),
      (_) => add(FetchAllData()), // Refresh all data on success
    );
  }

  Future<void> _onDeleteTask(
    DeleteTask event,
    Emitter<ManagerState> emit,
  ) async {
    final result = await deleteTask(
      DeleteTaskParams(taskId: event.taskId),
    ).run();
    result.fold(
      (failure) => emit(ManagerError(failure.message)),
      (_) => add(FetchAllData()),
    );
  }

  Future<void> _onAddComment(
    AddComment event,
    Emitter<ManagerState> emit,
  ) async {
    final result = await addComment(event.params).run();
    result.fold(
      (failure) => emit(ManagerError(failure.message)),
      (_) => add(FetchAllData()),
    );
  }

  void _onFilterChanged(FilterChanged event, Emitter<ManagerState> emit) {
    if (state is ManagerLoaded) {
      emit((state as ManagerLoaded).copyWith(currentFilter: event.filter));
    }
  }

  void _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<ManagerState> emit,
  ) {
    if (state is ManagerLoaded) {
      emit((state as ManagerLoaded).copyWith(searchQuery: event.query));
    }
  }
}
