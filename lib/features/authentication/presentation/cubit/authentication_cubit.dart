import 'package:bloc/bloc.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/error/failures.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/usecase/no_params.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/authentication/domain/entities/user_entity.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/authentication/domain/usecases/get_current_user_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/authentication/domain/usecases/login_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/authentication/domain/usecases/signout_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:equatable/equatable.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final GetCurrentUserUsecase _getCurrentUser;
  final LoginUsecase _login;
  final SignoutUsecase _signout;
  final SignupUsecase _signup;

  AuthenticationCubit({
    required GetCurrentUserUsecase getCurrentUserUsecase,
    required LoginUsecase loginUsecase,
    required SignoutUsecase signoutUsecase,
    required SignupUsecase signupUsecase,
  }) : _getCurrentUser = getCurrentUserUsecase,
       _login = loginUsecase,
       _signout = signoutUsecase,
       _signup = signupUsecase,
       super(AuthenticationInitial());

  Future<void> login(LoginParams params) async {
    await _login(params).run().then(
      (result) => result.fold(
        (failure) => emit(AuthenticationError(message: failure.message)),
        (user) => emit(AuthenticationSuccess(user: user)),
      ),
    );
  }

  Future<void> signup(SignUpParams params) async {
    await _signup(params).run().then(
      (result) => result.fold(
        (failure) => emit(AuthenticationError(message: failure.message)),
        (_) => emit(AuthenticationLoaded()),
      ),
    );
  }

  Future<void> logout(NoParams params) async {
    await _signout(params).run().then(
      (result) => result.fold(
        (failure) => emit(AuthenticationError(message: failure.message)),
        (_) => emit(AuthenticationInitial()),
      ),
    );
  }
}
// Future<void> createTask(CreateTaskParams params) async {
//     final result = await _createTask(params).run();
//     result.fold(
//       (failure) => emit(ManagerError(failure.message)),
//       (_) => fetchAllData(),
//     );
//   }