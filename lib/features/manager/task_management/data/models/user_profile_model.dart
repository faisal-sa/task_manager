import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/domain/entities/user_entity.dart';

class UserProfileModel {
  final String id;
  final String fullName;

  const UserProfileModel({required this.id, required this.fullName});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
    );
  }

  // Mapper method to convert the data model to a domain entity
  UserEntity toEntity() {
    return UserEntity(id: id, fullName: fullName);
  }
}
