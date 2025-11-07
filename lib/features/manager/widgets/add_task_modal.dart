import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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

  // --- State for new task properties ---
  String? _selectedPriority;
  DateTime? _selectedDate;
  String? _assignedEmployee; // Task can only be assigned to one employee

  final List<String> _priorities = ['low', 'medium', 'high', 'urgent'];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: DateTime(now.year + 5),
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _openEmployeeSelector() async {
    // Show the modal and wait for a single employee name to be returned
    final String? selectedEmployee = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => FractionallySizedBox(
        heightFactor: 0.7,
        child: SelectEmployeeModal(
          // Use the updated single-select modal
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

  void _submitTask() async {
    final isValid = _formKey.currentState!.validate();

    // Updated validation to check for all required fields
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

    // --- Print the collected task data ---
    print('Task Title: ${_titleController.text}');
    print('Description: ${_descriptionController.text}');
    print('Priority: $_selectedPriority');
    print('Assigned Employee: $_assignedEmployee');
    print('Deadline: $_selectedDate');

    Navigator.of(context).pop(); // Close the modal on successful submission
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
                'Add New Task', // Changed from Project to Task
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
                  labelText: 'Task Title', // Changed label
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
                  labelText: 'Task Description', // Changed label
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.description_outlined),
                ),
              ),
              SizedBox(height: 20.h),

              // --- Priority Dropdown ---
              DropdownButtonFormField<String>(
                value: _selectedPriority,
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
                onPressed: _openEmployeeSelector,
                icon: const Icon(Icons.person_add_alt_1_outlined),
                label: const Text('Assign Employee'), // Changed label
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
              SizedBox(height: 8.h),

              // --- Display Assigned Employee ---
              if (_assignedEmployee != null)
                Chip(
                  avatar: CircleAvatar(child: Text(_assignedEmployee![0])),
                  label: Text(_assignedEmployee!),
                  onDeleted: () {
                    setState(() {
                      _assignedEmployee = null;
                    });
                  },
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
                      onPressed: _presentDatePicker,
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
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  SizedBox(width: 8.w),
                  ElevatedButton(
                    onPressed: _submitTask, // Changed method name
                    child: const Text('Add Task'), // Changed label
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
