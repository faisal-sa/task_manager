import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/bloc/manager_bloc.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/bloc/manager_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/di/get_it.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/widgets/select_employee_modal.dart';

class AddTaskModal extends StatefulWidget {
  const AddTaskModal({super.key});

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedPriority;
  DateTime? _selectedDate;
  Map<String, dynamic>? _assignedEmployee;

  final List<String> _priorities = ['low', 'medium', 'high', 'urgent'];
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 5),
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _openEmployeeSelector() async {
    final Map<String, dynamic>? selectedEmployee = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => FractionallySizedBox(
        heightFactor: 0.7,
        child: SelectEmployeeModal(initialSelectedEmployee: _assignedEmployee),
      ),
    );

    if (selectedEmployee != null) {
      setState(() {
        _assignedEmployee = selectedEmployee;
      });
    }
  }

  Future<void> _createTaskInSupabase() async {
    try {
      final supabase = locator<SupabaseClient>();
      final userId = supabase.auth.currentUser?.id;

      if (userId == null) {
        throw Exception('User not authenticated.');
      }

      final newTask = {
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'priority': _selectedPriority,
        'due_date': _selectedDate?.toIso8601String(),
        'created_by': userId,
        'assigned_to': _assignedEmployee?['id'],
      };

      final response = await supabase.from('tasks').insert(newTask).select();

      debugPrint('✅ Task successfully created: $response');
    } catch (e) {
      debugPrint('❌ Error creating task: $e');
      rethrow;
    }
  }

  /// --- Handles form submission ---
  void _submitTask() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid || _selectedDate == null || _assignedEmployee == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill all fields, select a priority, assign an employee, and select a deadline.',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await _createTaskInSupabase();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task successfully added!')),
        );
        Navigator.of(context).pop();
        context.read<ManagerBloc>().add(ManagerEvent.fetchAllData());
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add task: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.r,
        right: 20.r,
        top: 20.r,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.r,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add New Task',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24.h),

              // --- Task Title ---
              TextFormField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a task title.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // --- Task Description ---
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Task Description',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.description_outlined),
                ),
              ),
              SizedBox(height: 20.h),

              // --- Priority Dropdown ---
              DropdownButtonFormField<String>(
                initialValue: _selectedPriority,
                decoration: const InputDecoration(
                  labelText: 'Priority',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.flag_outlined),
                ),
                items: _priorities.map((String priority) {
                  return DropdownMenuItem<String>(
                    value: priority,
                    child: Text(
                      priority[0].toUpperCase() + priority.substring(1),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPriority = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a priority.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),

              // --- Assign Employee ---
              OutlinedButton.icon(
                onPressed: _isSubmitting ? null : _openEmployeeSelector,
                icon: const Icon(Icons.person_add_alt_1_outlined),
                label: const Text('Assign Employee'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
              SizedBox(height: 8.h),

              // --- Display Assigned Employee ---
              if (_assignedEmployee != null)
                Chip(
                  avatar: CircleAvatar(
                    child: Text(
                      _assignedEmployee!['full_name']
                          .toString()
                          .substring(0, 1)
                          .toUpperCase(),
                    ),
                  ),
                  label: Text(_assignedEmployee!['full_name']),
                  onDeleted: _isSubmitting
                      ? null
                      : () => setState(() => _assignedEmployee = null),
                ),
              SizedBox(height: 16.h),

              // --- Deadline Picker ---
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No Deadline Selected'
                          : 'Deadline: ${DateFormat.yMd().format(_selectedDate!)}',
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: _isSubmitting ? null : _presentDatePicker,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // --- Action Buttons ---
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSubmitting
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  SizedBox(width: 8.w),
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitTask,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Add Task'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
