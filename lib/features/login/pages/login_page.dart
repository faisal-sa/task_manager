import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/di/get_it.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/services/auth_service.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/login/bloc/login_bloc.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/login/widgets/custom_text_field.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/login/widgets/login_button.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/login/widgets/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(authService: locator<AuthService>()),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.errorMessage != null) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  const Center(
                    child: Text(
                      'Login into your account',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),

                  /// -------- Email Field --------
                  const Text('Email Address', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return CustomTextField(
                        hintText: 'alex@email.com',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        errorText: state.emailError,
                        onChanged: (value) => bloc.add(EmailChanged(value)),
                      );
                    },
                  ),

                  const SizedBox(height: 25),

                  /// -------- Password Field --------
                  const Text('Password', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return CustomTextField(
                        hintText: 'Enter your password',
                        icon: Icons.lock_outline,
                        obscureText: true,
                        errorText: state.passwordError,
                        onChanged: (value) => bloc.add(PasswordChanged(value)),
                      );
                    },
                  ),

                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Add forgot password navigation
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// -------- Login Button --------
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return LoginButton(state, bloc);
                    },
                  ),

                  const SizedBox(height: 32),

                  /// -------- Divider --------
                  Row(
                    children: const [
                      Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'OR',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      Expanded(child: Divider(thickness: 1)),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// -------- Sign Up Button --------
                  SinUp(context),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
