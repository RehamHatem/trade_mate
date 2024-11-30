import 'package:trade_mate/screens/auth/signup/domain/entity/user_entity.dart';

abstract class SignupStates{

}
class InitSignupState extends SignupStates{

}
class LoadingSignupState extends SignupStates{
  String ?loadinMessage;
  LoadingSignupState({required this.loadinMessage});
}
class ErrorSignupState extends SignupStates{
  String ?errorMessage;
  ErrorSignupState({required this.errorMessage});
}
class SuccessSignupState extends SignupStates{
  SuccessSignupState();

}