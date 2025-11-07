// lib/features/auth/signup/bloc/signup_state.dart
part of 'signup_bloc.dart';

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
  final String name;
  final String role;
  final String? nameError;
  final String? roleError;

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
    this.roleError,
    this.name = '',
    this.role = '',
    this.nameError,
  });

  bool get isValid =>
      nameError == null &&
      role.isNotEmpty &&
      name.isNotEmpty &&
      emailError == null &&
      passwordError == null &&
      confirmPasswordError == null &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      !isLoading;

  SignupState copyWith({
    String? name,
    String? role,

    String? email,
    String? password,
    String? confirmPassword,
    bool? isLoading,
    bool? success,
    String? nameError,

    String? errorMessage,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    String? roleError,
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
