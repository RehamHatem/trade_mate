import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/auth/login/data/data/firebase_login.dart';
import 'package:trade_mate/screens/auth/login/domain/entity/user_login_entity.dart';
import 'package:trade_mate/screens/auth/login/domain/repository/login_data_source.dart';
import 'package:trade_mate/utils/failures.dart';

import '../model/user_login_model.dart';

class LoginDataSourceImpl implements LoginDataSource{
  FirebaseLogin firebaseLogin;
  LoginDataSourceImpl({required this.firebaseLogin});
  @override
  Future<Either<Failures, void>> login(UserLoginModel user) async {
    try{
      final either = await firebaseLogin.login(user.email,user.password);
      return right(null);
    }catch(e){
      return left(Failures(errorMsg: e.toString()));
    }

  }

}