import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/login/widgets/custom_text_field.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/signup/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignupBloc>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: BlocListener<SignupBloc, SignupState>(
              listener: (context, state) {
                if (state.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Account created successfully!'),
                    ),
                  );
                  context.go('/login');
                } else if (state.errorMessage != null) {
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
                      'Create your account',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Text('Full Name'),
                  SizedBox(height: 8),
                  BlocBuilder<SignupBloc, SignupState>(
                    builder: (context, state) {
                      return CustomTextField(
                        hintText: 'Enter your full name',
                        icon: Icons.person,
                        onChanged: (value) => bloc.add(NameChanged(value)),
                        errorText: state.nameError,
                      );
                    },
                  ),

                  //  Email
                  const Text('Email Address'),
                  const SizedBox(height: 8),
                  BlocBuilder<SignupBloc, SignupState>(
                    builder: (context, state) {
                      return CustomTextField(
                        hintText: 'you@email.com',
                        icon: Icons.email,
                        onChanged: (value) => bloc.add(EmailChanged(value)),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password
                  const Text('Password'),
                  const SizedBox(height: 8),
                  BlocBuilder<SignupBloc, SignupState>(
                    builder: (context, state) {
                      return CustomTextField(
                        hintText: 'Enter your password',
                        icon: Icons.lock_outline,
                        onChanged: (value) => bloc.add(PasswordChanged(value)),
                        obscureText: true,
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  //  Confirm Password
                  const Text('Confirm Password'),
                  const SizedBox(height: 8),
                  BlocBuilder<SignupBloc, SignupState>(
                    builder: (context, state) {
                      return CustomTextField(
                        hintText: 'Re-enter your password',
                        obscureText: true,

                        icon: Icons.lock_outline,
                        onChanged: (value) =>
                            bloc.add(ConfirmPasswordChanged(value)),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  //  Sign Up Button
                  BlocBuilder<SignupBloc, SignupState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: state.isValid
                              ? () => bloc.add(const SignupSubmitted())
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: state.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text('Sign Up'),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  //  Go to login page
                  Center(
                    child: TextButton(
                      onPressed: () => context.go('/login'),
                      child: const Text(
                        'Already have an account? Log in',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
