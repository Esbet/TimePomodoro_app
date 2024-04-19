import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.email,
    required this.name,
  });

  final String email;
  final String name;

  const UserEntity.empty()
      : email = '',
        name = '';

  UserEntity copyWith({
    String? email,
    String? name,
  }) =>
      UserEntity(
        email: email ?? this.email,
        name: name ?? this.name,
      );

  factory UserEntity.fromMap(Map<String, dynamic> json) => UserEntity(
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "Name": name,
      };

  @override
  List<Object?> get props => [email, name];
}
