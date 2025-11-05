import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/test.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [GoRoute(
      path: '/',
      builder: (_, __) => const Test(),
    ),], //GoRoute(path: '/sign_in', builder: LoginPage.builder)
);
