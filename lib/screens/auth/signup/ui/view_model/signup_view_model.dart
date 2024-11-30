import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_mate/screens/auth/signup/domain/use_case/signup_use_case.dart';
import 'package:trade_mate/screens/auth/signup/ui/view_model/signup_states.dart';
import 'package:trade_mate/utils/failures.dart';

import '../../data/model/user_model.dart';
import '../../domain/entity/user_entity.dart';

class SignupViewModel extends Cubit<SignupStates>{
  SignupViewModel({required this.signupUseCase}):super(InitSignupState());
  var formKey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  var passwordController=TextEditingController();
  var confirmationPasswordController=TextEditingController();
  var nameController=TextEditingController();
  bool isObscure=true;
  SignupUseCase signupUseCase;
  void signUp(UserModel user,String password) async{
    emit(LoadingSignupState(loadinMessage: "Loading..."));
    var either= await signupUseCase.signUp(user, password);
    return either.fold((l) {
      emit(ErrorSignupState(errorMessage: l.errorMsg));
    }, (r) {
      emit(SuccessSignupState());
    },);


  }

}