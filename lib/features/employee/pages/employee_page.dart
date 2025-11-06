import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/di/get_it.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/services/auth_service.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/employee/bloc/employee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmployeePage extends StatelessWidget {
  const EmployeePage({super.key});
  static Widget builder(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => EmployeeBloc(authService: locator<AuthService>()),
      child: const EmployeePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
