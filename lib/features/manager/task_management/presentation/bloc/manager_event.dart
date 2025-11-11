import 'package:equatable/equatable.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/utils/task_filter.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/domain/usecases/add_comment_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/domain/usecases/create_task_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/domain/usecases/update_task_usecase.dart';

abstract class ManagerEvent extends Equatable {
  const ManagerEvent();
  @override
  List<Object> get props => [];
}

class FetchAllData extends ManagerEvent {}

class CreateTask extends ManagerEvent {
  final CreateTaskParams params;
  const CreateTask(this.params);
  @override
  List<Object> get props => [params];
}

class UpdateTask extends ManagerEvent {
  final UpdateTaskParams params;
  const UpdateTask(this.params);
  @override
  List<Object> get props => [params];
}

class DeleteTask extends ManagerEvent {
  final String taskId;
  const DeleteTask(this.taskId);
  @override
  List<Object> get props => [taskId];
}

class AddComment extends ManagerEvent {
  final AddCommentParams params;
  const AddComment(this.params);
  @override
  List<Object> get props => [params];
}

class FilterChanged extends ManagerEvent {
  final TaskFilter filter;
  const FilterChanged(this.filter);
  @override
  List<Object> get props => [filter];
}

class SearchQueryChanged extends ManagerEvent {
  final String query;
  const SearchQueryChanged(this.query);
  @override
  List<Object> get props => [query];
}
