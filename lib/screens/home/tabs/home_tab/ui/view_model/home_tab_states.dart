import '../../../../../auth/login/data/model/user_login_model.dart';
import '../../../../../auth/signup/data/model/user_model.dart';

abstract class HomeTabStates{

}
class HomeTabInitState extends HomeTabStates{

}
class UpdateUserBalanceLoadingState extends HomeTabStates{
  String load;
  UpdateUserBalanceLoadingState({required this.load});

}
class UpdateUserBalanceErrorState extends HomeTabStates{

  String error;
  UpdateUserBalanceErrorState({required this.error});
}
class UpdateUserBalanceSuccessState extends HomeTabStates{
  double balance;
  UpdateUserBalanceSuccessState({required this.balance});

}
class GetUserBalanceLoadingState extends HomeTabStates{
  String load;
  GetUserBalanceLoadingState({required this.load});

}
class GetUserBalanceErrorState extends HomeTabStates{

  String error;
  GetUserBalanceErrorState({required this.error});
}
class GetUserBalanceSuccessState extends HomeTabStates{
  double balance;
  GetUserBalanceSuccessState({required this.balance});

}