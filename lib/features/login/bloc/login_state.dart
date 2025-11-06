part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isLoading;
  final String? errorMessage;
  final String? emailError;
  final String? passwordError;

  const LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.errorMessage,
    this.emailError,
    this.passwordError,
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
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      emailError: emailError,
      passwordError: passwordError,
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
