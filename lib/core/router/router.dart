import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/login/pages/login_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (BuildContext context, GoRouterState state) => const LoginPage(),
    ),
  ], //GoRoute(path: '/sign_in', builder: LoginPage.builder)
);
