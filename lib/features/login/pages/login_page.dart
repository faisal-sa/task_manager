import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/login/bloc/login_bloc.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/login/widgets/custom_text_field.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/login/widgets/login_button.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/login/widgets/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();

    return Scaffold(
      backgroundColor: Colors.white,
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
                if (state.success == true) {
                  print("success");
                  if (state.role == 'manager') {
                    print("going to manager");
                    context.go(
                      "/manager_page",
                      extra: {
                        'fullName': state.fullName,
                        'avatarUrl': state.avatarUrl,
                      },
                    );
                  } else if (state.role == 'employee') {
                    print("going to employee");
                    context.go(
                      "/employee_page",
                      extra: {
                        'fullName': state.fullName,
                        'avatarUrl': state.avatarUrl,
                      },
                    );
                  }
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
                  Signup(context),

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
