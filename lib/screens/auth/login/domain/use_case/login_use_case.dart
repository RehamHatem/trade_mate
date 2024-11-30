import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/auth/login/domain/entity/user_login_entity.dart';
import 'package:trade_mate/screens/auth/login/domain/repository/login_repo.dart';
import 'package:trade_mate/utils/failures.dart';

import '../../data/model/user_login_model.dart';

class LoginUseCase{
  LoginRepo loginRepo;
  LoginUseCase({required this.loginRepo});
  Future<Either<Failures,void>>login(UserLoginModel user)async{
    return  loginRepo.login(user);

  }
}