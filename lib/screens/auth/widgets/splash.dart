
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trade_mate/utils/app_colors.dart';

import '../../../utils/shared_preference.dart';
import '../../home/home.dart';
import '../login/ui/view/login_screen.dart';

class Splash extends StatefulWidget {
  static const String routeName="splash";
  Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}


class _SplashState extends State<Splash> {

  Future<void> autoLogin()async{
    await SharedPreference.init();
    var user=SharedPreference.getData(key: 'email' );
    String route;
    if(user==null){
      route= LoginScreen.routeName;
    }else route=Home.routeName;
    Timer(Duration(seconds: 5),(){
      Navigator.pushReplacementNamed(context, route);
    });
  }
  @override
  void initState()  {
    super.initState();
    autoLogin();

  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          backgroundColor: AppColors.whiteColor,
        body: Center(
          child: Container(
          decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/logo1.png")),

              ),),
        ),


    );
  }
}
