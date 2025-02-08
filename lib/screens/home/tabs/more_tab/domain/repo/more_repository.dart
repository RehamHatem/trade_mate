import '../../../../../auth/signup/data/model/user_model.dart';

abstract class MoreRepository{
  Future<UserModel?> readUser();
  void logOut();

}