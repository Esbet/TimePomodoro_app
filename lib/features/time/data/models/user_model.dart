import 'dart:convert';

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.email,
    required super.name,
  });

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        name: json["name"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "email": email,
        "name": name,
      };

  factory UserModel.entityToModel(UserEntity data) =>
      UserModel.fromMap(data.toMap());
}
