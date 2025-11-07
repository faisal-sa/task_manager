import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/task/task_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.urgent:
        return Colors.red.shade700;
      case TaskPriority.high:
        return Colors.orange.shade600;
      case TaskPriority.medium:
        return Colors.blue.shade600;
      case TaskPriority.low:
        return Colors.green.shade600;
    }
  }

  IconData _getStatusIcon(TaskStatus status) {
    switch (status) {
      case TaskStatus.completed:
        return Icons.check_circle;
      case TaskStatus.in_progress:
        return Icons.sync;
      case TaskStatus.cancelled:
        return Icons.cancel;
      case TaskStatus.pending:
        return Icons.pending_actions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Chip(
                  label: Text(
                    task.priority.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: _getPriorityColor(task.priority),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            if (task.description != null && task.description!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  task.description!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),

            const Divider(),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        task.dueDate != null
                            ? DateFormat.yMMMd().format(task.dueDate!)
                            : 'No Deadline',
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        _getStatusIcon(task.status),
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        task.status.name
                            .replaceAll('_', ' ')
                            .replaceFirst(
                              task.status.name[0],
                              task.status.name[0].toUpperCase(),
                            ),
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(),
            const SizedBox(height: 8),

            Text('Comments', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              minLines: 1,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
