import 'package:equatable/equatable.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/utils/task_filter.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/domain/entities/manager_task_entity.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/domain/entities/user_entity.dart';

abstract class ManagerState extends Equatable {
  const ManagerState();
  @override
  List<Object> get props => [];
}

class ManagerInitial extends ManagerState {}

class ManagerLoading extends ManagerState {}

class ManagerError extends ManagerState {
  final String message;
  const ManagerError(this.message);
  @override
  List<Object> get props => [message];
}

class ManagerLoaded extends ManagerState {
  final List<ManagerTaskEntity> allTasks;
  final List<UserEntity> employees;
  final TaskFilter currentFilter;
  final String searchQuery;

  const ManagerLoaded({
    this.allTasks = const [],
    this.employees = const [],
    this.currentFilter = TaskFilter.all,
    this.searchQuery = '',
  });

  List<ManagerTaskEntity> get filteredTasks {
    List<ManagerTaskEntity> tasks = allTasks;

    if (currentFilter != TaskFilter.all) {
      tasks = tasks.where((task) {
        switch (currentFilter) {
          case TaskFilter.pending:
            return task.status == TaskStatus.pending;
          case TaskFilter.inProgress:
            return task.status == TaskStatus.in_progress;
          case TaskFilter.completed:
            return task.status == TaskStatus.completed;
          default:
            return true;
        }
      }).toList();
    }

    if (searchQuery.isNotEmpty) {
      final lowercasedQuery = searchQuery.toLowerCase();
      tasks = tasks.where((task) {
        final assigneeName = employees
            .firstWhere(
              (emp) => emp.id == task.assignedTo,
              orElse: () => const UserEntity(id: '', fullName: ''),
            )
            .fullName
            .toLowerCase();
        return task.title.toLowerCase().contains(lowercasedQuery) ||
            assigneeName.contains(lowercasedQuery);
      }).toList();
    }

    return tasks;
  }

  ManagerLoaded copyWith({
    List<ManagerTaskEntity>? allTasks,
    List<UserEntity>? employees,
    TaskFilter? currentFilter,
    String? searchQuery,
  }) {
    return ManagerLoaded(
      allTasks: allTasks ?? this.allTasks,
      employees: employees ?? this.employees,
      currentFilter: currentFilter ?? this.currentFilter,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object> get props => [allTasks, employees, currentFilter, searchQuery];
}
