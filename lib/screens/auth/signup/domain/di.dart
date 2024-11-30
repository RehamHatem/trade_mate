import 'package:trade_mate/screens/auth/signup/data/data/firebase_signup.dart';
import 'package:trade_mate/screens/auth/signup/data/repo_impl/signup_data_source_impl.dart';
import 'package:trade_mate/screens/auth/signup/data/repo_impl/signup_repo_impl.dart';
import 'package:trade_mate/screens/auth/signup/domain/repository/signup_data_source.dart';
import 'package:trade_mate/screens/auth/signup/domain/repository/signup_repo.dart';
import 'package:trade_mate/screens/auth/signup/domain/use_case/signup_use_case.dart';

SignupUseCase injectSignupUseCase(){
  return SignupUseCase(signupRepo: injectSignupRepo());

}
SignupRepo injectSignupRepo(){
  return SignupRepoImpl(signupDataSource: injectSignupDataSource());
}
SignupDataSource injectSignupDataSource(){
  return SignupDataSourceImpl(firebaseSignup: injectFirebaseSignup());
}
FirebaseSignup injectFirebaseSignup(){
  return FirebaseSignup();
}