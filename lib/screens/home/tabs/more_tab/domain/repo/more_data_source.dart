import '../../../../../auth/signup/data/model/user_model.dart';

abstract class MoreDataSource{
  Future<UserModel?> readUser();
  void logOut();
}