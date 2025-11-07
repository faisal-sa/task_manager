import 'package:flutter/material.dart';

const List<String> _dummyEmployees = [
  'Alice Johnson',
  'Bob Williams',
  'Charlie Brown',
  'Diana Miller',
  'Ethan Davis',
  'Fiona Garcia',
  'George Rodriguez',
  'Hannah Martinez',
];

class SelectEmployeeModal extends StatefulWidget {
  final String? initialSelectedEmployee; // Takes a single employee

  const SelectEmployeeModal({super.key, required this.initialSelectedEmployee});

  @override
  State<SelectEmployeeModal> createState() => _SelectEmployeeModalState();
}

class _SelectEmployeeModalState extends State<SelectEmployeeModal> {
  // A temporary variable to hold the selection made within this modal
  late String? _selectedEmployee;

  @override
  void initState() {
    super.initState();
    // Initialize with the employee that was already selected
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
            'Select Employee', // Changed title
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Use Expanded and ListView for a scrollable list
          Expanded(
            child: ListView.builder(
              itemCount: _dummyEmployees.length,
              itemBuilder: (context, index) {
                final employee = _dummyEmployees[index];
                return RadioListTile<String>(
                  title: Text(employee),
                  value: employee, // The value this radio button represents
                  groupValue: _selectedEmployee, // The currently selected value
                  onChanged: (String? value) {
                    setState(() {
                      _selectedEmployee = value; // Update the selected employee
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Pop the modal and return the final selected employee
              Navigator.of(context).pop(_selectedEmployee);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}
