abstract class LoginStates{
}
class InitLoginState extends LoginStates{

}
class LoadingLoginState extends LoginStates{
  String ?loadinMessage;
  LoadingLoginState({required this.loadinMessage});
}
class ErrorLoginState extends LoginStates{
  String ?errorMessage;
  ErrorLoginState({required this.errorMessage});
}
class SuccessLoginState extends LoginStates{

}