import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/auth/signup/domain/repository/signup_repo.dart';
import 'package:trade_mate/utils/failures.dart';

import '../../data/model/user_model.dart';
import '../entity/user_entity.dart';

class SignupUseCase{
  SignupRepo signupRepo;
  SignupUseCase({required this.signupRepo});
  Future<Either<Failures,void>>signUp(UserModel user,String password) async{
    return signupRepo.signUp(user, password);
  }
}