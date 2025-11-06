import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';

SizedBox LoginButton(LoginState state, LoginBloc bloc) {
  return SizedBox(
    width: double.infinity,
    height: 48,
    child: ElevatedButton(
      onPressed: state.isValid ? () => bloc.add(LoginSubmitted()) : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: state.isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : const Text(
              'Login Now',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
    ),
  );
}
