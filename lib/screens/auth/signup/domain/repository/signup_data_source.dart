import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/auth/signup/data/model/user_model.dart';
import 'package:trade_mate/utils/failures.dart';

import '../entity/user_entity.dart';

abstract class SignupDataSource{
  Future<Either<Failures,void>>signUp(UserModel user,String password);
}