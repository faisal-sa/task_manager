import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/di/get_it.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/profile/user_profile_model.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/services/auth_service.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/utils/task_filter.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/bloc/manager_bloc.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/bloc/manager_event.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/bloc/manager_state.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/widgets/add_task_modal.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/widgets/edit_task_modal.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/widgets/manager_task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// 1. Change to StatefulWidget
class ManagerPage extends StatefulWidget {
  final String? fullName;
  final String? avatarUrl;
  const ManagerPage({super.key, this.fullName, this.avatarUrl});

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

// 2. Create the State class
class _ManagerPageState extends State<ManagerPage> {
  // 3. Create the controller
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    // 4. Initialize the controller (optionally with initial BLoC state)
    final initialState = context.read<ManagerBloc>().state;
    final initialQuery =
        initialState.whenOrNull(loaded: (_, __, ___, sq) => sq) ?? '';
    _searchController = TextEditingController(text: initialQuery);
  }

  @override
  void dispose() {
    // 5. Dispose the controller
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // All your old 'build' method code goes here
    // Remember to use 'widget.fullName' instead of 'fullName'
    return Scaffold(
      appBar: AppBar(
        // 6. Use 'widget.fullName'
        title: Text("Welcome ${widget.fullName ?? 'Manager'}"),
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
          IconButton(
            onPressed: () {
              context.push("/statistics");
            },
            icon: Icon(Icons.document_scanner),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocListener<ManagerBloc, ManagerState>(
          listener: (context, state) {
            // 8. Listen for state changes
            final query =
                state.whenOrNull(
                  loaded: (_, __, ___, searchQuery) => searchQuery,
                ) ??
                '';

            // 9. Sync controller if text is different
            if (_searchController.text != query) {
              _searchController.text = query;
              // Move cursor to the end
              _searchController.selection = TextSelection.fromPosition(
                TextPosition(offset: _searchController.text.length),
              );
            }
          },
          // 10. Optimize listener to only run when search query changes
          listenWhen: (prev, current) {
            final prevQuery = prev.whenOrNull(loaded: (_, __, ___, sq) => sq);
            final currQuery = current.whenOrNull(
              loaded: (_, __, ___, sq) => sq,
            );
            return prevQuery != currQuery;
          },
          // 11. Your Column is the child
          child: Column(
            children: [
              // 12. REMOVE THE BlocSelector from the TextField
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  // 13. Assign the controller
                  controller: _searchController,
                  // 14. REMOVE the 'key'
                  onChanged: (query) {
                    context.read<ManagerBloc>().add(
                      ManagerEvent.searchQueryChanged(query: query),
                    );
                  },
                  decoration: InputDecoration(
                    labelText: 'Search by title or assignee...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                  ),
                ),
              ),

              // 7. ADD FILTER CHIPS
              // Use BlocSelector to rebuild only for the filter
              BlocSelector<ManagerBloc, ManagerState, TaskFilter>(
                selector: (state) =>
                    state.whenOrNull(loaded: (_, __, filter, ___) => filter) ??
                    TaskFilter.all,
                builder: (context, currentFilter) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: TaskFilter.values.map((filter) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ChoiceChip(
                            label: Text(filter.displayName),
                            selected: currentFilter == filter,
                            onSelected: (isSelected) {
                              if (isSelected) {
                                context.read<ManagerBloc>().add(
                                  ManagerEvent.filterChanged(filter: filter),
                                );
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),

              // 8. WRAP LIST IN EXPANDED
              Expanded(
                child: BlocConsumer<ManagerBloc, ManagerState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      error: (message) =>
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              backgroundColor: Colors.red,
                            ),
                          ),
                    );
                  },
                  builder: (context, state) {
                    return state.when(
                      initial: () =>
                          const Center(child: Text("Initializing...")),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (message) =>
                          Center(child: Text('Error: $message')),
                      loaded: (allTasks, employees, currentFilter, searchQuery) {
                        // 9. GET FILTERED LIST from the getter
                        final tasks = state.filteredTasks;

                        if (tasks.isEmpty) {
                          return Center(
                            child: Text(
                              allTasks.isEmpty
                                  ? 'No tasks have been created yet.\nPress the + button to add one!'
                                  : 'No tasks match your search or filter.',
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        return RefreshIndicator(
                          onRefresh: () async {
                            // 10. Refresh just calls fetchAllData.
                            // The BLoC resetting the state will
                            // automatically clear the search query,
                            // which rebuilds the TextField (via the ValueKey).
                            context.read<ManagerBloc>().add(
                              const ManagerEvent.fetchAllData(),
                            );
                          },
                          // 11. Use the filtered 'tasks' list
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
                                            onPressed: () => Navigator.of(
                                              dialogContext,
                                            ).pop(),
                                          ),
                                          TextButton(
                                            child: const Text(
                                              'Delete',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
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
                                  showModalBottomSheet(
                                    backgroundColor: Colors.white,
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (_) => BlocProvider.value(
                                      value: BlocProvider.of<ManagerBloc>(
                                        context,
                                      ),
                                      child: EditTaskModal(task: task),
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
            ],
          ),
        ),
      ),
    );
  }
}
