// lib/features/auth/signup/bloc/signup_bloc.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/services/auth_service.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/utils/validators.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthService authService;

  SignupBloc({required this.authService}) : super(const SignupState()) {
    on<NameChanged>((event, emit) {
      emit(
        state.copyWith(
          name: event.name,
          nameError: Validators.validateName(event.name),
        ),
      );
    });
    on<EmailChanged>((event, emit) {
      emit(
        state.copyWith(
          email: event.email,
          emailError: Validators.validateEmail(event.email),
        ),
      );
    });

    on<PasswordChanged>((event, emit) {
      emit(
        state.copyWith(
          password: event.password,
          passwordError: Validators.validatePassword(event.password),
        ),
      );
    });

    on<ConfirmPasswordChanged>((event, emit) {
      emit(
        state.copyWith(
          confirmPassword: event.confirmPassword,
          confirmPasswordError: Validators.validateConfirmPassword(
            event.confirmPassword,
            state.password,
          ),
        ),
      );
    });

    on<SignupSubmitted>((event, emit) async {
      final emailError = Validators.validateEmail(state.email);
      final passwordError = Validators.validatePassword(state.password);
      final confirmError = Validators.validateConfirmPassword(
        state.confirmPassword,
        state.password,
      );

      if (emailError != null || passwordError != null || confirmError != null) {
        emit(
          state.copyWith(
            emailError: emailError,
            passwordError: passwordError,
            confirmPasswordError: confirmError,
          ),
        );
        return;
      }

      emit(state.copyWith(isLoading: true, errorMessage: null));

      try {
        await authService.signUp(email: state.email, password: state.password);

        emit(state.copyWith(isLoading: false, success: true));
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
    });
  }
}
