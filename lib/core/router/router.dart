import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/di/get_it.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/services/auth_service.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/employee/bloc/employee_bloc.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/employee/bloc/employee_event.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/employee/pages/employee_page.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/login/bloc/login_bloc.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/login/pages/login_page.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/bloc/manager_bloc.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/bloc/manager_event.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/pages/manager_page.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/signup/bloc/signup_bloc.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/signup/pages/signup_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => LoginBloc(authService: locator<AuthService>()),
          child: LoginPage(),
        );
      },
    ),
    GoRoute(
      path: '/sign_up',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => SignupBloc(authService: locator<AuthService>()),
          child: SignupPage(),
        );
      },
    ),
    GoRoute(
      path: '/employee_page',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>?;

        final fullName = extras?['fullName'] as String?;
        final avatarUrl = extras?['avatarUrl'] as String?;
        final employeeId = locator<SupabaseClient>().auth.currentUser!.id;
        return BlocProvider(
          create: (context) =>
              EmployeeBloc(client: locator<SupabaseClient>())
                ..add(EmployeeEvent.fetchTasks(employeeId: employeeId)),
          child: EmployeePage(
            fullName: fullName,
            avatarUrl: avatarUrl,
            employeeId: employeeId,
          ),
        );
      },
    ),
    GoRoute(
      path: '/manager_page',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>?;
        final fullName = extras?['fullName'] as String?;
        final avatarUrl = extras?['avatarUrl'] as String?;
        return BlocProvider(
          create: (context) =>
              ManagerBloc(client: locator<SupabaseClient>())
                ..add(ManagerEvent.fetchAllData()),
          child: ManagerPage(fullName: fullName, avatarUrl: avatarUrl),
        );
      },
    ),
  ],
);
