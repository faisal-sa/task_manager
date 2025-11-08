import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/di/get_it.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/services/auth_service.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/employee/bloc/employee_bloc.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/employee/bloc/employee_event.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/employee/bloc/employee_state.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/employee/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmployeePage extends StatelessWidget {
  final String employeeId;
  final String? fullName;
  final String? avatarUrl;

  const EmployeePage({
    super.key,
    required this.employeeId,
    this.fullName,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fullName ?? 'Employee Tasks'),
        actions: [
          IconButton(
            onPressed: () {
              locator<AuthService>().signOut();
              context.go("/login");
            },
            icon: Icon(Icons.logout),
          ),
          //  performance stats
          // Changed: Navigate to performance page after fetching stats
          // Changed: use GoRouter for smooth navigation instead of MaterialPageRoute
          IconButton(
            icon: const Icon(Icons.insights),
            onPressed: () async {
              final bloc = context.read<EmployeeBloc>();
              bloc.add(
                EmployeeEvent.fetchPerformanceStats(employeeId: employeeId),
              );

              await Future.delayed(const Duration(milliseconds: 600));

              bloc.state.maybeMap(
                performanceStats: (data) {
                  if (context.mounted) {
                    context.go(
                      '/employee_performance',
                      extra: {
                        'completed': data.completed,
                        'inProgress': data.inProgress,
                        'completionRate': data.completionRate,
                      },
                    );
                  }
                },
                orElse: () {},
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            return state.when(
              initial: () => Center(child: Text("Welcome $fullName")),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Error: $message',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              performanceStats: (completed, inProgress, completionRate) =>
                  const SizedBox.shrink(),

              loaded: (tasks) {
                if (tasks.isEmpty) {
                  return Center(
                    child: Text(
                      'No tasks assigned yet. Great job!',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskCard(task: task);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
