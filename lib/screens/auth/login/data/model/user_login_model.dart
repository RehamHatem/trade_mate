import 'package:trade_mate/screens/auth/signup/domain/entity/user_entity.dart';

import '../../domain/entity/user_login_entity.dart';

class UserLoginModel extends UserLoginEntity {
  // static const String collectionName="Users";

  UserLoginModel({
    required super.password,
    required super.email,
  });


  // factory UserModel.fromEntity(UserEntity entity) {
  //   return UserModel(
  //     id: entity.id,
  //     email: entity.email,
  //     phone: entity.phone,
  //     userName: entity.userName,
  //     emailVerified: entity.emailVerified,
  //   );
  // }
  //
  // UserEntity toEntity() {
  //   return UserEntity(
  //     id: id,
  //     email: email,
  //     phone: phone,
  //     userName: userName,
  //     emailVerified: emailVerified,
  //   );
  // }

  UserLoginModel.fromJson(Map<String, dynamic> json)
      : this(
    password: json['password'],
    email: json['email'],

  );

  Map<String, dynamic> toJson() {
    return {
      "password": password,
      "email": email,

    };
  }
}