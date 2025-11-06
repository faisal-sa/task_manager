part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isLoading;
  final String? errorMessage;
  final String? emailError;
  final String? passwordError;
  final bool success;

  const LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.errorMessage,
    this.emailError,
    this.passwordError,
    this.success = false,
  });

  bool get isValid =>
      emailError == null &&
      passwordError == null &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      !isLoading;

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? errorMessage,
    String? emailError,
    String? passwordError,
    bool? success,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      emailError: emailError,
      passwordError: passwordError,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    isLoading,
    errorMessage,
    emailError,
    passwordError,
  ];
}
