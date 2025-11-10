import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/di/get_it.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/services/auth_service.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/employee/bloc/employee_bloc.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/employee/bloc/employee_event.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/employee/bloc/employee_state.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/employee/widgets/task_card.dart';

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
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          fullName ?? 'Employee Tasks',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1976D2), Color(0xFF64B5F6)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Performance Stats',
            icon: const Icon(Icons.insights, color: Colors.white),
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
          IconButton(
            onPressed: () {
              locator<AuthService>().signOut();
              context.go("/login");
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFFF5F7FA), Color(0xFFD7DBDD)],
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<EmployeeBloc, EmployeeState>(
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: state.when(
                  initial: () => Center(
                    child: Text(
                      "Welcome $fullName 👋",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator.adaptive()),
                  error: (message) => Center(
                    child: Card(
                      elevation: 6,
                      color: Colors.red.shade50,
                      margin: const EdgeInsets.all(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Error: $message',
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  performanceStats: (_, __, ___) =>
                      const Center(child: CircularProgressIndicator.adaptive()),
                  loaded: (tasks) {
                    if (tasks.isEmpty) {
                      return Center(
                        child: Text(
                          'No tasks assigned yet. 🎉',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(top: 16),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return TaskCard(task: task);
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
