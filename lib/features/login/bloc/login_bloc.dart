import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/services/auth_service.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/utils/validators.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;

  LoginBloc({required this.authService}) : super(const LoginState()) {
    on<EmailChanged>((event, emit) {
      final emailError = Validators.validateEmail(event.email);
      emit(state.copyWith(email: event.email, emailError: emailError));
    });

    on<PasswordChanged>((event, emit) {
      final passwordError = Validators.validatePassword(event.password);
      emit(
        state.copyWith(password: event.password, passwordError: passwordError),
      );
    });

    on<LoginSubmitted>((event, emit) async {
      final emailError = Validators.validateEmail(state.email);
      final passwordError = Validators.validatePassword(state.password);

      if (emailError != null || passwordError != null) {
        emit(
          state.copyWith(emailError: emailError, passwordError: passwordError),
        );
        return;
      }

      emit(state.copyWith(isLoading: true, errorMessage: null));

      try {
        final response = await authService.signIn(
          email: state.email,
          password: state.password,
        );

        if (response.session != null) {
          emit(state.copyWith(isLoading: false));
        } else {
          emit(state.copyWith(isLoading: false, errorMessage: 'Invalid '));
        }
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
    });
  }
}
