import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

SizedBox SinUp(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    height: 48,
    child: OutlinedButton(
      onPressed: () => context.go('/sign_up'),
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          style: BorderStyle.solid,
          width: 2,

          color: Colors.black,
        ),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text(
        'Sign Up',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}
