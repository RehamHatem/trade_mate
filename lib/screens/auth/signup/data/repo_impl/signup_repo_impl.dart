import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/auth/signup/domain/entity/user_entity.dart';
import 'package:trade_mate/screens/auth/signup/domain/repository/signup_data_source.dart';
import 'package:trade_mate/screens/auth/signup/domain/repository/signup_repo.dart';
import 'package:trade_mate/utils/failures.dart';

import '../model/user_model.dart';

class SignupRepoImpl implements SignupRepo{
  SignupDataSource signupDataSource;
  SignupRepoImpl({required this.signupDataSource});
  @override
  Future<Either<Failures, void>> signUp(UserModel user,String password) async {

    var either= await signupDataSource.signUp(user, password);
    return either.fold((l) {
      return left(l);
    }, (r) {
      return right(r);
    },);
  }

}