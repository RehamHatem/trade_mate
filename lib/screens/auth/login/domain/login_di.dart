import 'package:trade_mate/screens/auth/login/data/data/firebase_login.dart';
import 'package:trade_mate/screens/auth/login/data/repo_impl/login_data_source_impl.dart';
import 'package:trade_mate/screens/auth/login/data/repo_impl/login_repo_impl.dart';
import 'package:trade_mate/screens/auth/login/domain/repository/login_data_source.dart';
import 'package:trade_mate/screens/auth/login/domain/repository/login_repo.dart';
import 'package:trade_mate/screens/auth/login/domain/use_case/login_use_case.dart';

LoginUseCase injectLoginUseCase(){
  return LoginUseCase(loginRepo: injectLoginRepo());
}
LoginRepo injectLoginRepo(){
  return LoginRepoImpl(loginDataSource: injectLoginDataSource());
}
LoginDataSource injectLoginDataSource(){
  return LoginDataSourceImpl(firebaseLogin: injectFirebaseLogin());
}
FirebaseLogin injectFirebaseLogin(){
  return FirebaseLogin();
}