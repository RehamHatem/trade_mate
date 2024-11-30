import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/auth/login/domain/repository/login_data_source.dart';
import 'package:trade_mate/screens/auth/login/domain/repository/login_repo.dart';
import 'package:trade_mate/utils/failures.dart';

import '../model/user_login_model.dart';

class LoginRepoImpl implements LoginRepo{
  LoginDataSource loginDataSource;
  LoginRepoImpl({required this.loginDataSource});
  @override
  Future<Either<Failures, void>> login(UserLoginModel user) async{
    var either=await loginDataSource.login(user);
    return either.fold((l) {
      return left(l);
    }, (r) {
      return right(r);
    },);

  }

}