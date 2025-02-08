import 'package:trade_mate/screens/auth/signup/data/model/user_model.dart';

abstract class MoreStates{}
class MoreInitState extends MoreStates{}
class ReadUserSuccessState extends MoreStates{
  UserModel userModel;
  ReadUserSuccessState({required this.userModel});

}
class ReadUserLoadingState extends MoreStates{
String load;
ReadUserLoadingState({required this.load});

}
class ReadUserErrorState extends MoreStates{
  String error;
  ReadUserErrorState({required this.error});
}
class LogOutSuccessState extends MoreStates{
  String success;
  LogOutSuccessState({required this.success});

}
class LogOutLoadingState extends MoreStates{
  String load;
  LogOutLoadingState({required this.load});

}
class LogOutErrorState extends MoreStates{
  String error;
  LogOutErrorState({required this.error});
}