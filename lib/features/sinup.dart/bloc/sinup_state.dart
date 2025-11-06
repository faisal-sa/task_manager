// lib/features/auth/signup/bloc/signup_state.dart
part of 'sinup_bloc.dart';

@immutable
class SignupState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final bool isLoading;
  final bool success;
  final String? errorMessage;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;

  const SignupState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isLoading = false,
    this.success = false,
    this.errorMessage,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
  });

  bool get isValid =>
      emailError == null &&
      passwordError == null &&
      confirmPasswordError == null &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      !isLoading;

  SignupState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    bool? isLoading,
    bool? success,
    String? errorMessage,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      errorMessage: errorMessage,
      emailError: emailError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    confirmPassword,
    isLoading,
    success,
    errorMessage,
    emailError,
    passwordError,
    confirmPasswordError,
  ];
}
