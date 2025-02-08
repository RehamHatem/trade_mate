import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_mate/screens/auth/signup/data/model/user_model.dart';
import 'package:trade_mate/screens/home/tabs/more_tab/domain/use_case/more_use_cases.dart';
import 'package:trade_mate/screens/home/tabs/more_tab/ui/view_model/more_states.dart';

class MoreViewModel extends Cubit<MoreStates>{
  MoreViewModel({required this.moreUseCases}):super(MoreInitState());
  MoreUseCases moreUseCases;
   UserModel? user;
  void readUser()async{
    emit(ReadUserLoadingState(load: "loading"));
    try{
      user =await moreUseCases.readUser();
      emit(ReadUserSuccessState(userModel:user!));

    }catch(e){
      emit(ReadUserErrorState(error: e.toString()));

    }
  }
  void logOut(){
    emit(LogOutLoadingState(load: "loading"));
    try{
       moreUseCases.logOut();
      emit(LogOutSuccessState(success:"success"));

    }catch(e){
      emit(LogOutErrorState(error: e.toString()));

    }
  }
}