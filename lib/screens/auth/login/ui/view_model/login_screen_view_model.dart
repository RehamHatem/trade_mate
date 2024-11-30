import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_mate/screens/auth/login/data/model/user_login_model.dart';
import 'package:trade_mate/screens/auth/login/domain/use_case/login_use_case.dart';
import 'package:trade_mate/screens/auth/login/ui/view_model/states.dart';

class LoginScreenViewModel extends Cubit<LoginStates>{
  LoginScreenViewModel({required this.loginUseCase}):super(InitLoginState());
  var formKey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  bool isObscure=true;
LoginUseCase loginUseCase;
  void login(UserLoginModel user)async{
    emit(LoadingLoginState(loadinMessage: "Loading.."));
    var either = await loginUseCase.login(user);
    return either.fold((l) {
      emit(ErrorLoginState(errorMessage: l.errorMsg.toString()));
    }, (r) {
      emit( SuccessLoginState());
    },);


  }


}