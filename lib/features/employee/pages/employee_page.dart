import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/employee/bloc/employee_bloc.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/employee/bloc/employee_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeePage extends StatelessWidget {
  const EmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocBuilder<EmployeeBloc, EmployeeState>(
            builder: (context, state) => state.when(
              initial: () => Text("Welcome"),
              loading: () => CircularProgressIndicator(),
              loaded: (List string) => Row(
                children: List.generate(
                  string.length,
                  (index) => Text(string[index]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
