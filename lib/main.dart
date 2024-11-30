import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/auth/login/ui/view/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trade_mate/screens/auth/signup/ui/view/signup_screen.dart';
import 'package:trade_mate/screens/auth/widgets/splash.dart';
import 'package:trade_mate/screens/home/home.dart';
import 'package:trade_mate/utils/app_theme.dart';
import 'package:trade_mate/utils/bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute:Splash.routeName,
        theme: AppTheme.mainTheme,
        routes: {
          Splash.routeName:(context)=>Splash(),
          LoginScreen.routeName:(context)=>LoginScreen(),
          SignupScreen.routeName:(context)=>SignupScreen(),
          Home.routeName:(context)=>Home(),
        },
      ),
    );
  }
}


