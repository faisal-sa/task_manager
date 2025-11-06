import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/login/pages/login_page.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/signup/pages/signup_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: LoginPage.builder),
    GoRoute(path: '/sign_up', builder: SignupPage.builder),
  ],
);
