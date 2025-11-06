import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/azozWorld.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/services/auth_service.dart';
// import 'package:get_it/get_it.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    // final auth = GetIt.instance<AuthService>();
    // final supa = GetIt.instance<SupabaseClient>();
    final db = GetIt.I.get<SupabaseServicePro>();
    return Scaffold(
      appBar: AppBar(title: const Text("Auth Test")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await db.insert(
              table: 'projects',
              data: {
                'title': 'task manager app',
                'description': 'clean code and will ui',
                'deadline': '10 days',
              },
            );
          },
          child: const Text("Run Auth Test"),
        ),
      ),
    );
  }
}
