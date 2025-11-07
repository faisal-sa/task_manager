import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/di/get_it.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/profile/user_profile_model.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/services/auth_service.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/bloc/manager_bloc.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/bloc/manager_event.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/bloc/manager_state.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/widgets/add_task_modal.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/widgets/manager_task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ManagerPage extends StatelessWidget {
  final String? fullName;
  final String? avatarUrl;
  const ManagerPage({super.key, this.fullName, this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${fullName ?? 'Manager'}"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                context: context,
                isScrollControlled: true,
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<ManagerBloc>(context),
                  child: const AddTaskModal(),
                ),
              );
            },
            icon: const Icon(Icons.add_task),
            tooltip: 'Add New Task',
          ),
          IconButton(
            onPressed: () {
              locator<AuthService>().signOut();
              context.go("/login");
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<ManagerBloc, ManagerState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              ),
            );
          },
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: Text("Initializing...")),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Center(child: Text('Error: $message')),
              loaded: (tasks, employees) {
                if (tasks.isEmpty) {
                  return const Center(
                    child: Text(
                      'No tasks have been created yet.\nPress the + button to add one!',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<ManagerBloc>().add(
                      const ManagerEvent.fetchAllData(),
                    );
                  },
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      final assigneeName = employees
                          .firstWhere(
                            (emp) => emp.id == task.assignedTo,
                            orElse: () => const UserProfile(
                              id: '',
                              fullName: 'Unassigned',
                            ),
                          )
                          .fullName;

                      return ManagerTaskCard(
                        task: task,
                        assigneeName: assigneeName,
                        onDelete: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: Text(
                                  'Are you sure you want to delete the task "${task.title}"?',
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () =>
                                        Navigator.of(dialogContext).pop(),
                                  ),
                                  TextButton(
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      context.read<ManagerBloc>().add(
                                        ManagerEvent.deleteTask(
                                          taskId: task.id,
                                        ),
                                      );
                                      Navigator.of(dialogContext).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onEdit: () {
                          // TODO: Implement the Edit Task Modal
                          // This would be similar to the AddTaskModal but pre-filled with task data
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Edit functionality coming soon!'),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
