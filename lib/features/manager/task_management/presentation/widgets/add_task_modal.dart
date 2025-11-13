import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/presentation/cubit/manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/create_task_usecase.dart';

import 'select_employee_modal.dart';

class AddTaskModal extends StatefulWidget {
  final List<UserEntity> employees;
  const AddTaskModal({super.key, required this.employees});

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedPriority;
  DateTime? _selectedDate;
  UserEntity? _assignedEmployee;
  bool _isSubmitting = false;

  final List<String> _priorities = ['low', 'medium', 'high', 'urgent'];

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

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _openEmployeeSelector() async {
    final UserEntity? selectedEmployee = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => FractionallySizedBox(
        heightFactor: 0.7,
        child: SelectEmployeeModal(
          employees: widget.employees,
          initialSelectedEmployee: _assignedEmployee,
        ),
      ),
    );

    if (selectedEmployee != null) {
      setState(() {
        _assignedEmployee = selectedEmployee;
      });
    }
  }

  void _submitTask() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedPriority == null ||
        _selectedDate == null ||
        _assignedEmployee == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select a priority, an employee, and a deadline.',
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final params = CreateTaskParams(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      priority: _selectedPriority!,
      assignedTo: _assignedEmployee!.id,
      dueDate: _selectedDate,
    );

    context.read<ManagerCubit>().createTask(params);
    Navigator.of(context).pop();
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

              TextFormField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  labelText: 'Task Title*',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty)
                    return 'Please enter a task title.';
                  return null;
                },
              ),
              SizedBox(height: 16.h),

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

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Priority*',
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
                onChanged: (value) => setState(() => _selectedPriority = value),
                validator: (value) =>
                    value == null ? 'Please select a priority.' : null,
              ),
              SizedBox(height: 20.h),

              OutlinedButton.icon(
                onPressed: _isSubmitting ? null : _openEmployeeSelector,
                icon: const Icon(Icons.person_add_alt_1_outlined),
                label: Text(
                  _assignedEmployee == null
                      ? 'Assign Employee*'
                      : 'Change Assignee',
                ),
              ),
              SizedBox(height: 8.h),
              if (_assignedEmployee != null)
                Chip(
                  avatar: CircleAvatar(
                    child: Text(
                      _assignedEmployee!.fullName.substring(0, 1).toUpperCase(),
                    ),
                  ),
                  label: Text(_assignedEmployee!.fullName),
                  onDeleted: _isSubmitting
                      ? null
                      : () => setState(() => _assignedEmployee = null),
                ),
              SizedBox(height: 16.h),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'Select Deadline*'
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
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
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
