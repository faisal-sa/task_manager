import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/presentation/cubit/manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/get_it.dart';
import '../../../../../core/services/auth_service.dart';
import '../../../../../core/utils/task_filter.dart';
import '../../domain/entities/user_entity.dart';

import '../cubit/manager_state.dart';
import '../widgets/add_task_modal.dart';
import '../widgets/edit_task_modal.dart';
import '../widgets/manager_task_card.dart';

class ManagerPage extends StatelessWidget {
  final String? fullName;
  final String? avatarUrl;

  const ManagerPage({super.key, this.fullName, this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Welcome ${fullName ?? 'Manager'}"),
        actions: [
          BlocBuilder<ManagerCubit, ManagerState>(
            builder: (context, state) {
              return IconButton(
                onPressed: state is ManagerLoaded
                    ? () {
                        showModalBottomSheet(
                          backgroundColor: Colors.white,
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<ManagerCubit>(context),
                            child: AddTaskModal(employees: state.employees),
                          ),
                        );
                      }
                    : null,
                icon: const Icon(Icons.add_task),
                tooltip: 'Add New Task',
              );
            },
          ),
          IconButton(
            onPressed: () => context.push("/statistics"),
            icon: const Icon(Icons.show_chart),
            tooltip: 'View Statistics',
          ),
          IconButton(
            onPressed: () {
              locator<AuthService>().signOut();
              context.go("/login");
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const _SearchField(),
            BlocBuilder<ManagerCubit, ManagerState>(
              builder: (context, state) {
                if (state is ManagerLoaded) {
                  return _FilterChips(currentFilter: state.currentFilter);
                }
                return const SizedBox.shrink();
              },
            ),
            Expanded(
              child: BlocConsumer<ManagerCubit, ManagerState>(
                listener: (context, state) {
                  if (state is ManagerError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ManagerInitial || state is ManagerLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ManagerLoaded) {
                    final tasks = state.filteredTasks;
                    if (tasks.isEmpty) {
                      return Center(
                        child: Text(
                          state.allTasks.isEmpty
                              ? 'No tasks have been created yet.\nPress the + button to add one!'
                              : 'No tasks match your search or filter.',
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<ManagerCubit>().fetchAllData(); //?
                      },
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          final assigneeName = state.employees
                              .firstWhere(
                                (emp) => emp.id == task.assignedTo,
                                orElse: () => const UserEntity(
                                  id: '',
                                  fullName: 'Unassigned',
                                ),
                              )
                              .fullName;

                          return ManagerTaskCard(
                            task: task,
                            assigneeName: assigneeName,
                            onDelete: () => _showDeleteConfirmation(
                              context,
                              task.id,
                              task.title,
                            ),
                            onEdit: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.white,
                                context: context,
                                isScrollControlled: true,
                                builder: (_) => BlocProvider.value(
                                  value: BlocProvider.of<ManagerCubit>(context),
                                  child: EditTaskModal(
                                    task: task,
                                    employees: state.employees,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: Text("An error occurred. Please pull to refresh."),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    String taskId,
    String taskTitle,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text(
            'Are you sure you want to delete the task "$taskTitle"?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                context.read<ManagerCubit>().deleteTask(taskId);
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class _SearchField extends StatefulWidget {
  const _SearchField();

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    final currentState = context.read<ManagerCubit>().state;
    final initialQuery = currentState is ManagerLoaded
        ? currentState.searchQuery
        : '';
    _searchController = TextEditingController(text: initialQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManagerCubit, ManagerState>(
      listener: (context, state) {
        if (state is ManagerLoaded &&
            _searchController.text != state.searchQuery) {
          _searchController.text = state.searchQuery;
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextField(
          controller: _searchController,
          onChanged: (query) {
            context.read<ManagerCubit>().searchQueryChanged(query);
          },
          decoration: InputDecoration(
            labelText: 'Search by title or assignee...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  final TaskFilter currentFilter;

  const _FilterChips({required this.currentFilter});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SizedBox(
        width: 1.sw,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: TaskFilter.values.map((filter) {
            final isSelected = currentFilter == filter;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ChoiceChip(
                backgroundColor: Colors.white,
                selectedColor: Colors.black,
                checkmarkColor: Colors.white,
                label: Text(
                  filter.displayName,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    context.read<ManagerCubit>().filterChanged(filter);
                  }
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
