import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/auth/signup/domain/use_case/signup_use_case.dart';
import 'package:trade_mate/utils/failures.dart';

import '../../data/model/user_model.dart';
import '../entity/user_entity.dart';

abstract class SignupRepo{
  Future<Either<Failures,void>>signUp(UserModel user,String password);
}