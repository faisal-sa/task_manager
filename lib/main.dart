import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/di/get_it.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/router/router.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        routerConfig: router,
      ),
    );
  }
}
