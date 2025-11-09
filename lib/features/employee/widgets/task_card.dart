import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/models/task/task_model.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/di/get_it.dart';

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
  bool _expanded = false;
  bool _isPressed = false;

  SupabaseClient get _supabase => locator<SupabaseClient>();

  @override
  void initState() {
    super.initState();
    _status = widget.task.status;
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    final response = await _supabase
        .from('task_comments')
        .select('id, comment, created_at, user_id, profiles(full_name)')
        .eq('task_id', widget.task.id)
        .order('created_at', ascending: false);
    setState(() => _comments = List<Map<String, dynamic>>.from(response));
  }

  Future<void> _addComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;
    setState(() => _isSubmitting = true);

    try {
      final user = _supabase.auth.currentUser;
      await _supabase.from('task_comments').insert({
        'task_id': widget.task.id,
        'user_id': user?.id,
        'comment': text,
      });
      _commentController.clear();
      await _fetchComments();
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

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
    } finally {
      if (mounted) setState(() => _isUpdatingStatus = false);
    }
  }

  Color _getPriorityColor(TaskPriority p) => switch (p) {
    TaskPriority.urgent => Colors.redAccent,
    TaskPriority.high => Colors.deepOrange,
    TaskPriority.medium => Colors.indigoAccent,
    TaskPriority.low => Colors.greenAccent,
  };

  IconData _getStatusIcon(TaskStatus s) => switch (s) {
    TaskStatus.completed => Icons.check_circle,
    TaskStatus.in_progress => Icons.timelapse,
    TaskStatus.cancelled => Icons.cancel_outlined,
    TaskStatus.pending => Icons.schedule,
  };

  bool get _isOverdue =>
      widget.task.dueDate != null &&
      widget.task.dueDate!.isBefore(DateTime.now()) &&
      _status != TaskStatus.completed;

  @override
  Widget build(BuildContext context) {
    final accent = _getPriorityColor(widget.task.priority);
    final theme = Theme.of(context);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        Future.delayed(
          const Duration(milliseconds: 120),
          () => setState(() => _isPressed = false),
        );
        setState(() => _expanded = !_expanded);
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: _isPressed ? 0.98 : 1.0,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            boxShadow: [
              BoxShadow(
                color: accent.withOpacity(_isPressed ? 0.25 : 0.15),
                blurRadius: _isPressed ? 8 : 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.9),
                      Colors.white.withOpacity(0.7),
                    ],
                  ),
                  border: Border.all(color: accent.withOpacity(.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.task.title,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: _isOverdue
                                  ? Colors.redAccent
                                  : Colors.grey.shade900,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: accent.withOpacity(.15),
                          ),
                          child: Text(
                            widget.task.priority.name.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if ((widget.task.description ?? '').isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        child: Text(
                          widget.task.description!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade800,
                            height: 1.4,
                          ),
                        ),
                      ),

                    // STATUS / DUE DATE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_outlined,
                              size: 18,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              widget.task.dueDate != null
                                  ? DateFormat.yMMMd().format(
                                      widget.task.dueDate!,
                                    )
                                  : "No Deadline",
                              style: TextStyle(
                                color: _isOverdue
                                    ? Colors.redAccent
                                    : Colors.grey.shade700,
                                fontWeight: _isOverdue
                                    ? FontWeight.bold
                                    : FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        _isUpdatingStatus
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : DropdownButtonHideUnderline(
                                child: DropdownButton<TaskStatus>(
                                  value: _status,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  borderRadius: BorderRadius.circular(14),
                                  onChanged: (s) =>
                                      s != null ? _updateStatus(s) : null,
                                  items: TaskStatus.values.map((s) {
                                    return DropdownMenuItem(
                                      value: s,
                                      child: Row(
                                        children: [
                                          Icon(
                                            _getStatusIcon(s),
                                            color: Colors.grey.shade800,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            s.name.replaceAll('_', ' '),
                                            style: const TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                      ],
                    ),

                    // EXPANDED COMMENTS AREA
                    AnimatedCrossFade(
                      crossFadeState: _expanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 400),
                      secondChild: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Comments 💬",
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (_comments.isEmpty)
                              Text(
                                'No comments yet.',
                                style: TextStyle(color: Colors.grey.shade600),
                              )
                            else
                              ..._comments.map((c) {
                                final username =
                                    c['profiles']?['full_name'] ?? 'Unknown';
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(color: Colors.black87),
                                      children: [
                                        TextSpan(
                                          text:
                                              "$username • ${DateFormat.yMMMd().add_jm().format(DateTime.parse(c['created_at']))}\n",
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12,
                                          ),
                                        ),
                                        TextSpan(
                                          text: c['comment'],
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),

                            const SizedBox(height: 10),
                            TextField(
                              controller: _commentController,
                              decoration: InputDecoration(
                                hintText: 'Add a comment...',
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.6),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: accent.withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                suffixIcon: _isSubmitting
                                    ? const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : IconButton(
                                        icon: const Icon(Icons.send_rounded),
                                        color: accent,
                                        onPressed: _addComment,
                                      ),
                              ),
                              minLines: 1,
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                      firstChild: const SizedBox.shrink(),
                    ),

                    AnimatedOpacity(
                      opacity: 0.7,
                      duration: const Duration(milliseconds: 400),
                      child: Center(
                        child: Icon(
                          _expanded
                              ? Icons.expand_less_rounded
                              : Icons.expand_more_rounded,
                          color: accent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
