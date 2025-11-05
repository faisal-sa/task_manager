import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  static Future<void> load() async {
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      debugPrint("ERROR: COULDN'T LOAD ENV FILE $e");
    }
  }
}
