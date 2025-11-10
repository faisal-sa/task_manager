import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/di/get_it.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/task/task_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ManagerTaskCard extends StatefulWidget {
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

  @override
  State<ManagerTaskCard> createState() => _ManagerTaskCardState();
}

class _ManagerTaskCardState extends State<ManagerTaskCard> {
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmittingComment = false;
  List<Map<String, dynamic>> _comments = [];

  SupabaseClient get _supabase => locator<SupabaseClient>();

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    try {
      final response = await _supabase
          .from('task_comments')
          .select('id, comment, created_at, user_id, profiles(full_name)')
          .eq('task_id', widget.task.id)
          .order('created_at', ascending: false);

      if (mounted) {
        setState(() {
          _comments = List<Map<String, dynamic>>.from(response);
        });
      }
    } catch (e) {
      debugPrint('Error fetching comments: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load comments.')),
        );
      }
    }
  }

  Future<void> _addComment() async {
    final commentText = _commentController.text.trim();
    if (commentText.isEmpty) {
      return;
    }

    setState(() => _isSubmittingComment = true);

    try {
      final user = _supabase.auth.currentUser;
      if (user == null) throw Exception("User not authenticated");

      await _supabase.from('task_comments').insert({
        'task_id': widget.task.id,
        'user_id': user.id,
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
      if (mounted) {
        setState(() => _isSubmittingComment = false);
      }
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

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffe5e5e5),
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
                    widget.task.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Chip(
                  label: Text(
                    widget.task.priority.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: _getPriorityColor(widget.task.priority),
                ),
              ],
            ),
            const SizedBox(height: 8),

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
                  widget.assigneeName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 24),

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
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      _getStatusIcon(widget.task.status),
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.task.status.name
                          .replaceAll('_', ' ')
                          .toUpperCase(),
                    ),
                  ],
                ),
              ],
            ),

            const Divider(),
            const SizedBox(height: 8),

            Text('Comments', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),

            if (_comments.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('No comments yet.'),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _comments.length,
                itemBuilder: (context, index) {
                  final comment = _comments[index];
                  final username =
                      comment['profiles']?['full_name'] ?? 'Unknown User';
                  final timestamp = DateFormat.yMMMd().add_jm().format(
                    DateTime.parse(comment['created_at']),
                  );
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      '$username • $timestamp',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    subtitle: Text(
                      comment['comment'],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                },
              ),

            const SizedBox(height: 16),

            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                border: const OutlineInputBorder(),
                suffixIcon: _isSubmittingComment
                    ? const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _addComment,
                      ),
              ),
              minLines: 1,
              maxLines: 4,
            ),
            const Divider(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue.shade700),
                  onPressed: widget.onEdit,
                  tooltip: 'Edit Task',
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red.shade700),
                  onPressed: widget.onDelete,
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
