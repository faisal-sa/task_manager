import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/di/get_it.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/task/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatefulWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;
  bool _isUpdatingStatus = false;
  List<Map<String, dynamic>> _comments = [];
  late TaskStatus _status;

  SupabaseClient get _supabase => locator<SupabaseClient>();

  @override
  void initState() {
    super.initState();
    _status = widget.task.status;
    _fetchComments();
  }

  /// Fetch comments and include username
  Future<void> _fetchComments() async {
    final response = await _supabase
        .from('task_comments')
        .select('id, comment, created_at, user_id, user_profiles(email)')
        .eq('task_id', widget.task.id)
        .order('created_at', ascending: false);

    setState(() {
      _comments = List<Map<String, dynamic>>.from(response);
    });
  }

  /// Add a new comment
  Future<void> _addComment() async {
    final commentText = _commentController.text.trim();
    if (commentText.isEmpty) return;

    setState(() => _isSubmitting = true);

    try {
      final user = _supabase.auth.currentUser;
      await _supabase.from('task_comments').insert({
        'task_id': widget.task.id,
        'user_id': user?.id,
        'comment': commentText,
      });

      _commentController.clear();
      await _fetchComments();
    } catch (e) {
      debugPrint('Error adding comment: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to add comment.')));
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  /// Update task status
  Future<void> _updateStatus(TaskStatus newStatus) async {
    setState(() => _isUpdatingStatus = true);

    try {
      await _supabase
          .from('tasks')
          .update({
            'status': newStatus.name,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', widget.task.id);

      setState(() => _status = newStatus);
    } catch (e) {
      debugPrint('Error updating status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You do not have permission to update this task.'),
        ),
      );
    } finally {
      setState(() => _isUpdatingStatus = false);
    }
  }

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

  bool get _isOverdue {
    final due = widget.task.dueDate;
    if (due == null) return false;
    return due.isBefore(DateTime.now()) && _status != TaskStatus.completed;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _isOverdue ? Colors.red.shade50 : null,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.task.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _isOverdue ? Colors.red : null,
                    ),
                  ),
                ),
                Chip(
                  label: Text(
                    widget.task.priority.name.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: _getPriorityColor(widget.task.priority),
                ),
              ],
            ),

            if (widget.task.description?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(widget.task.description!),
              ),

            const Divider(),

            // Status and Due date
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
                      widget.task.dueDate != null
                          ? DateFormat.yMMMd().format(widget.task.dueDate!)
                          : 'No Deadline',
                      style: TextStyle(
                        color: _isOverdue ? Colors.red : Colors.grey.shade800,
                        fontWeight: _isOverdue
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                _isUpdatingStatus
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : DropdownButton<TaskStatus>(
                        value: _status,
                        icon: const Icon(Icons.arrow_drop_down),
                        underline: const SizedBox(),
                        onChanged: (newStatus) {
                          if (newStatus != null) _updateStatus(newStatus);
                        },
                        items: TaskStatus.values.map((status) {
                          return DropdownMenuItem(
                            value: status,
                            child: Row(
                              children: [
                                Icon(
                                  _getStatusIcon(status),
                                  size: 16,
                                  color: Colors.grey.shade700,
                                ),
                                const SizedBox(width: 8),
                                Text(status.name.replaceAll('_', ' ')),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
              ],
            ),

            const Divider(),
            const SizedBox(height: 8),

            // Comments Section
            Text('Comments', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),

            if (_comments.isEmpty)
              const Text('No comments yet.')
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _comments.length,
                itemBuilder: (context, index) {
                  final c = _comments[index];
                  final username = c['user_profiles']?['email'] ?? 'Unknown';
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      '$username • ${DateFormat.yMMMd().add_jm().format(DateTime.parse(c['created_at']))}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    subtitle: Text(
                      c['comment'],
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),

            const SizedBox(height: 8),

            // Add Comment
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                border: const OutlineInputBorder(),
                suffixIcon: _isSubmitting
                    ? const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _addComment,
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
