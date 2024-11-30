import 'package:trade_mate/screens/auth/signup/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  static const String collectionName="Users";

  UserModel({
    required super.id,
    required super.email,
    super.phone = "",
    super.emailVerified = false,
    required super.userName,
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

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
    id: json['id'],
    email: json['email'],
    phone: json['phone'],
    emailVerified: json['emailVerified'],
    userName: json['userName'],
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "phone": phone,
      "emailVerified": emailVerified,
      "userName": userName,
    };
  }
}