import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/authentication/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class UserModel extends Equatable {
  final String fullName;
  final String email;
  final String? avatarURL;
  final Role role;

  const UserModel({
    required this.fullName,
    required this.email,
    required this.avatarURL,
    required this.role,
  });

  factory UserModel.fromSupabaseUser(supabase.User supabaseUser) {
    final metaData = supabaseUser.userMetadata ?? {};

    return UserModel(
      email: supabaseUser.email ?? '',
      fullName: metaData['full_name'] ?? 'No Name',
      avatarURL: metaData['avatar_url'],
      role: _roleFromString(metaData['role'] ?? 'employee'),
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      fullName: fullName,
      email: email,
      avatarURL: avatarURL,
      role: role,
    );
  }

  static Role _roleFromString(String role) {
    return Role.values.firstWhere(
      (e) => e.name == role,
      orElse: () => Role.employee,
    );
  }

  @override
  List<Object?> get props => [fullName, email, avatarURL, role];
}
