import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/services/supabase_service_pro.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/initializer/supabase_initializer.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/services/auth_service.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/data/data_sources/remote/manager_task_remote_data_source.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/data/repositories/manager_task_repository_impl.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/repositories/manager_task_repository.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/usecases/add_comment_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/usecases/create_task_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/usecases/delete_task_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/usecases/get_all_employees_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/usecases/get_all_tasks_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/usecases/update_task_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/presentation/bloc/manager_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final locator = GetIt.instance;
Future<void> setupLocator() async {
  final supabaseClient = await SupabaseInitializer.init();

  locator.registerSingleton<SupabaseClient>(supabaseClient);
  locator.registerLazySingleton<AuthService>(
    () => AuthService(locator<SupabaseClient>()),
  );
  locator.registerLazySingleton<SupabaseServicePro>(
    () => SupabaseServicePro(locator<SupabaseClient>()),
  );

  // Manager Feature
  // BLoC
  locator.registerFactory(
    () => ManagerBloc(
      getAllTasks: locator(),
      getAllEmployees: locator(),
      createTask: locator(),
      updateTask: locator(),
      deleteTask: locator(),
      addComment: locator(),
    ),
  );

  // Use Cases
  locator.registerLazySingleton(
    () => GetAllTasksUsecase(repository: locator()),
  );
  locator.registerLazySingleton(
    () => GetAllEmployeesUsecase(repository: locator()),
  );
  locator.registerLazySingleton(() => CreateTaskUsecase(repository: locator()));
  locator.registerLazySingleton(() => UpdateTaskUsecase(repository: locator()));
  locator.registerLazySingleton(() => DeleteTaskUsecase(repository: locator()));
  locator.registerLazySingleton(() => AddCommentUsecase(repository: locator()));

  // Repository
  locator.registerLazySingleton<ManagerTaskRepository>(
    () => ManagerTaskRepositoryImpl(remoteDataSource: locator()),
  );

  // Data Source
  locator.registerLazySingleton<ManagerTaskRemoteDataSource>(
    () => ManagerTaskRemoteDataSourceImpl(supabaseClient: locator()),
  );
}
