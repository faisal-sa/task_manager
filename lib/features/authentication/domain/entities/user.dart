import 'package:equatable/equatable.dart';

enum Role { manager, employee }

class User extends Equatable {
  final String fullName;
  final String email;
  final String? avatarURL;
  final Role role;

  const User({
    required this.fullName,
    required this.email,
    required this.profileUrl,
    required this.role,
  });

  @override
  List<Object?> get props => [fullName, email, profileUrl, role];
}
