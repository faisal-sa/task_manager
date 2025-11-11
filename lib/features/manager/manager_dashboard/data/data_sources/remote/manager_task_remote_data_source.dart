import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/data/models/manager_task_model.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/data/models/task_comment_model.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/data/models/user_profile_model.dart';

abstract class ManagerTaskRemoteDataSource {
  Future<List<ManagerTaskModel>> getAllTasks();
  Future<List<UserProfileModel>> getAllEmployees();
  Future<ManagerTaskModel> createTask(Map<String, dynamic> taskData);
  Future<ManagerTaskModel> updateTask(
    String taskId,
    Map<String, dynamic> taskData,
  );
  Future<void> deleteTask(String taskId);
  Future<TaskCommentModel> addComment(String taskId, String comment);
}

class ManagerTaskRemoteDataSourceImpl implements ManagerTaskRemoteDataSource {
  final SupabaseClient supabaseClient;

  ManagerTaskRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<ManagerTaskModel>> getAllTasks() async {
    final response = await supabaseClient
        .from('tasks')
        .select('*, task_comments(*, profiles(full_name))')
        .order('created_at', ascending: false);
    return (response as List)
        .map((task) => ManagerTaskModel.fromJson(task))
        .toList();
  }

  @override
  Future<List<UserProfileModel>> getAllEmployees() async {
    final response = await supabaseClient
        .from('profiles')
        .select('id, full_name')
        .eq('role', 'employee');
    return (response as List)
        .map((profile) => UserProfileModel.fromJson(profile))
        .toList();
  }

  @override
  Future<ManagerTaskModel> createTask(Map<String, dynamic> taskData) async {
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId == null) throw const AuthException('User not authenticated.');

    final response = await supabaseClient
        .from('tasks')
        .insert({...taskData, 'created_by': userId})
        .select()
        .single();
    return ManagerTaskModel.fromJson(response);
  }

  @override
  Future<ManagerTaskModel> updateTask(
    String taskId,
    Map<String, dynamic> taskData,
  ) async {
    final response = await supabaseClient
        .from('tasks')
        .update(taskData)
        .eq('id', taskId)
        .select()
        .single();
    return ManagerTaskModel.fromJson(response);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await supabaseClient.from('tasks').delete().eq('id', taskId);
  }

  @override
  Future<TaskCommentModel> addComment(String taskId, String comment) async {
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId == null) throw const AuthException('User not authenticated.');

    final response = await supabaseClient
        .from('task_comments')
        .insert({'task_id': taskId, 'user_id': userId, 'comment': comment})
        .select('*, profiles(full_name)')
        .single();

    return TaskCommentModel.fromJson(response);
  }
}
