import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/initializer/supabase_initializer.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/services/auth_service.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final locator = GetIt.instance;
Future<void> setupLocator() async {
  final supabaseClient = await SupabaseInitializer.init();

  locator.registerSingleton<SupabaseClient>(supabaseClient);
  locator.registerLazySingleton<AuthService>(
    () => AuthService(locator<SupabaseClient>()),
  );
}
