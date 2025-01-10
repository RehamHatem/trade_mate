import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_mate/screens/auth/signup/data/model/user_model.dart';
import 'package:trade_mate/screens/home/tabs/home_tab/domain/use_case/home_tab_use_cases.dart';
import 'package:trade_mate/screens/home/tabs/home_tab/ui/view_model/home_tab_states.dart';

import '../../../../../auth/login/data/model/user_login_model.dart';

class HomeTabViewModel extends Cubit<HomeTabStates>{
  HomeTabViewModel({required this.homeTabUseCases}):super(HomeTabInitState());
  HomeTabUseCases homeTabUseCases;
  var balance=TextEditingController();
  var formKey=GlobalKey<FormState>();
  var balanceee =StreamController.broadcast();
  double myBalance = 0.0;
  void updateBalance(String id, double balance){
    emit(UpdateUserBalanceLoadingState(load: "loading..."));
    try{
      homeTabUseCases.updateBalance(id, balance);
      emit( UpdateUserBalanceSuccessState(balance:balance));
    }
    catch(e){
      print(e.toString());
      emit(UpdateUserBalanceErrorState(error: e.toString()));
    }
  }
  void getBalance(String id) async {
    emit(GetUserBalanceLoadingState(load: "Fetching balance..."));
    try {
      final userBalance = await homeTabUseCases.getUserBalance(id);
      myBalance=userBalance;
      balanceee.add(myBalance);
      print(myBalance);
      emit(GetUserBalanceSuccessState(balance: userBalance));
    } catch (e) {
      print(e.toString());
      emit(GetUserBalanceErrorState(error: e.toString()));
    }
  }
}