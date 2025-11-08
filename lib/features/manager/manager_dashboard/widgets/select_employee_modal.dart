// ignore_for_file: use_build_context_synchronously

import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/di/get_it.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SelectEmployeeModal extends StatefulWidget {
  final Map<String, dynamic>? initialSelectedEmployee; // now stores id & name

  const SelectEmployeeModal({super.key, required this.initialSelectedEmployee});

  @override
  State<SelectEmployeeModal> createState() => _SelectEmployeeModalState();
}

class _SelectEmployeeModalState extends State<SelectEmployeeModal> {
  Map<String, dynamic>? _selectedEmployee;
  List<Map<String, dynamic>> employees = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedEmployee = widget.initialSelectedEmployee;
    _fetchEmployees();
  }

  Future<void> _fetchEmployees() async {
    setState(() => _isLoading = true);
    try {
      final supabase = locator<SupabaseClient>();

      final response = await supabase
          .from('profiles')
          .select('id, full_name')
          .eq('role', 'employee');

      setState(() {
        employees = List<Map<String, dynamic>>.from(response);
      });
    } catch (error) {
      debugPrint('Error fetching employees: $error');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch employees')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
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
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (employees.isEmpty)
            const Center(child: Text('No employees found'))
          else
            Expanded(
              child: ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  final employee = employees[index];
                  final employeeName = employee['full_name'] ?? 'Unnamed';
                  final employeeId = employee['id'];

                  return RadioListTile<String>(
                    title: Text(employeeName),
                    value: employeeId,
                    groupValue: _selectedEmployee?['id'],
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
