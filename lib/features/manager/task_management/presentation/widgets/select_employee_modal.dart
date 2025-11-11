import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';

class SelectEmployeeModal extends StatefulWidget {
  final List<UserEntity> employees;
  final UserEntity? initialSelectedEmployee;

  const SelectEmployeeModal({
    super.key,
    required this.employees,
    this.initialSelectedEmployee,
  });

  @override
  State<SelectEmployeeModal> createState() => _SelectEmployeeModalState();
}

class _SelectEmployeeModalState extends State<SelectEmployeeModal> {
  UserEntity? _selectedEmployee;

  @override
  void initState() {
    super.initState();
    _selectedEmployee = widget.initialSelectedEmployee;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Select Employee',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (widget.employees.isEmpty)
            const Center(child: Text('No employees found'))
          else
            Expanded(
              child: ListView.builder(
                itemCount: widget.employees.length,
                itemBuilder: (context, index) {
                  final employee = widget.employees[index];
                  return RadioListTile<String>(
                    title: Text(employee.fullName),
                    value: employee.id,
                    groupValue: _selectedEmployee?.id,
                    onChanged: (_) {
                      setState(() {
                        _selectedEmployee = employee;
                      });
                    },
                  );
                },
              ),
            ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(_selectedEmployee);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}
