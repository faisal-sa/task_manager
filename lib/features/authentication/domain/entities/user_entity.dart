import 'package:equatable/equatable.dart';

enum Role { manager, employee }

class UserEntity extends Equatable {
  final String fullName;
  final String email;
  final String? avatarURL;
  final Role role;

  const UserEntity({
    required this.fullName,
    required this.email,
    required this.avatarURL,
    required this.role,
  });

  @override
  List<Object?> get props => [fullName, email, avatarURL, role];
}
