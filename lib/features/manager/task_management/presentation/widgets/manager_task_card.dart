import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/presentation/cubit/manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/manager_task_entity.dart';
import '../../domain/usecases/add_comment_usecase.dart';

class ManagerTaskCard extends StatefulWidget {
  final ManagerTaskEntity task;
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

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _addComment() {
    final commentText = _commentController.text.trim();
    if (commentText.isEmpty) {
      return;
    }

    setState(() => _isSubmittingComment = true);

    final params = AddCommentParams(
      taskId: widget.task.id,
      comment: commentText,
    );
    context.read<ManagerCubit>().addComment(params);

    _commentController.clear();
    FocusScope.of(context).unfocus();
    // A small delay to allow the UI to feel responsive before resetting the state
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() => _isSubmittingComment = false);
      }
    });
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
    final textTheme = Theme.of(context).textTheme;

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
            // =========================================================
            // NEW SECTION: DISPLAYING TASK DETAILS (START)
            // =========================================================

            // --- Row 1: Title and Priority ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.task.title,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(
                    widget.task.priority.name.toUpperCase(),
                    style: textTheme.labelSmall?.copyWith(color: Colors.white),
                  ),
                  backgroundColor: _getPriorityColor(widget.task.priority),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // --- Row 2: Status, Assignee, and Due Date ---
            Row(
              children: [
                Icon(_getStatusIcon(widget.task.status), size: 16),
                const SizedBox(width: 4),
                Text(
                  widget.task.status.name.replaceAll('_', ' ').toUpperCase(),
                  style: textTheme.labelSmall,
                ),
                const SizedBox(width: 12),
                const Icon(Icons.person_outline, size: 16),
                const SizedBox(width: 4),
                Text(widget.assigneeName, style: textTheme.bodySmall),
                const Spacer(),
                if (widget.task.dueDate != null) ...[
                  const Icon(Icons.calendar_today_outlined, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat.yMMMd().format(widget.task.dueDate!),
                    style: textTheme.bodySmall,
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),

            // --- Description (if it exists) ---
            if (widget.task.description != null &&
                widget.task.description!.isNotEmpty)
              Text(
                widget.task.description!,
                style: textTheme.bodyMedium?.copyWith(color: Colors.black87),
              ),

            // =========================================================
            // NEW SECTION: DISPLAYING TASK DETAILS (END)
            // =========================================================
            const Divider(),
            const SizedBox(height: 8),

            // --- This is your existing code, which is correct ---
            Text('Comments', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),

            if (widget.task.comments.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('No comments yet.'),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.task.comments.length,
                itemBuilder: (context, index) {
                  final comment = widget.task.comments[index];
                  final timestamp = DateFormat.yMMMd().add_jm().format(
                    comment.createdAt,
                  );
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      '${comment.authorName} • $timestamp',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    subtitle: Text(
                      comment.comment,
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
