import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/env_config/env_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseInitializer {
  static Future<SupabaseClient> init() async {
    await EnvConfig.load();

    final supabase = await Supabase.initialize(
      url: EnvConfig.supabaseUrl,
      anonKey: EnvConfig.supabaseAnonKey,
    );

    return supabase.client;
  }
}
