import 'package:trade_mate/screens/auth/signup/domain/entity/user_entity.dart';

class UserLoginEntity   {
  static const String collectionName="Users";

  UserLoginEntity({
    required this.password,
    required this. email,
  });
  String password;
  String email;

}