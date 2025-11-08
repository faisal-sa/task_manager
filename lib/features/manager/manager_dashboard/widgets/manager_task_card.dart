import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/task/task_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ManagerTaskCard extends StatelessWidget {
  final Task task;
  final String assigneeName;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ManagerTaskCard({
    super.key,
    required this.task,
    required this.assigneeName,
    required this.onDelete,
    required this.onEdit,
  });

  // Reusing helper methods from the employee TaskCard
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
            // --- Title and Priority ---
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
                ),
              ],
            ),
            const SizedBox(height: 8),

            // --- Assigned To ---
            Row(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 16,
                  color: Colors.grey.shade700,
                ),
                const SizedBox(width: 8),
                Text(
                  'Assigned to: ',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                Text(
                  assigneeName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 24),

            // --- Deadline and Status ---
            Row(
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
                    Text(task.status.name.replaceAll('_', ' ').toUpperCase()),
                  ],
                ),
              ],
            ),

            const Divider(height: 24),

            // --- Action Buttons ---
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue.shade700),
                  onPressed: onEdit,
                  tooltip: 'Edit Task',
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red.shade700),
                  onPressed: onDelete,
                  tooltip: 'Delete Task',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
