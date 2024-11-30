import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/auth/login/data/model/user_login_model.dart';
import 'package:trade_mate/screens/auth/login/ui/view_model/login_screen_view_model.dart';
import 'package:trade_mate/screens/auth/login/ui/view_model/states.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/dialog_utils.dart';
import '../../../../../utils/text_field_item.dart';
import '../../../signup/ui/view/signup_screen.dart';
import '../../domain/login_di.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName="login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  var loginViewModel=LoginScreenViewModel(loginUseCase:  injectLoginUseCase());
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: loginViewModel,
      listener: (context, state) {
        if (state is LoadingLoginState){
          return DialogUtils.showLoading(context, "Loading...");
        }
        else if (state is ErrorLoginState){
          DialogUtils.hideLoading(context);
          return DialogUtils.showMessage(context, state.errorMessage.toString(),title: "Error");
        }
        else if (state  is SuccessLoginState){
          DialogUtils.hideLoading(context);
          return DialogUtils.showMessage(context, "success");
        }

      },
      child: Scaffold(
        backgroundColor: Colors.white,
        drawerScrimColor: Colors.white,

        body: Container(
          color: Colors.white,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 75.h, bottom: 60.h, left: 100.w, right: 100.w),
                  child: Image.asset(
                    'assets/images/logo2.png',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Welcome',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 24.sp),
                      ),
                      Text(
                        'Please sign in with your email',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 16.sp),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: Form(
                          key: loginViewModel.formKey,
                          child: Column(
                            children: [
                              TextFieldItem(
                                fieldName: 'E-mail address',
                                hintText: 'enter your email address',
                                controller: loginViewModel.emailController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'please enter your email address';
                                  }
                                  bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value);
                                  if (!emailValid) {
                                    return 'invalid email';
                                  }
                                  return null;
                                },
                              ),
                              TextFieldItem(
                                fieldName: 'Password',
                                hintText: 'enter your password',
                                controller: loginViewModel.passwordController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'please enter password';
                                  }
                                  if (value.trim().length < 6 ||
                                      value.trim().length > 30) {
                                    return 'password should be >6 & <30';
                                  }
                                  return null;
                                },
                                isObscure: loginViewModel.isObscure,
                                suffixIcon: InkWell(
                                  child: loginViewModel.isObscure
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  onTap: () {
                                    if (loginViewModel.isObscure) {
                                      loginViewModel.isObscure = false;
                                    } else {
                                      loginViewModel.isObscure = true;
                                    }
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'Forgot Password',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: AppColors.primaryColor,fontSize: 16.sp),
                        textAlign: TextAlign.end,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 35.h),
                        child: ElevatedButton(
                          onPressed: () {
                            var user=UserLoginModel(password: loginViewModel.passwordController.text, email: loginViewModel.emailController.text);
                            loginViewModel.login(user);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.lightGreyColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15.r)))),
                          child: Container(
                            height: 64.h,
                            width: 398.w,
                            child: Center(
                              child: Text(
                                'Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 20.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don’t have an account? ',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(SignupScreen.routeName);
                              },
                              child: Text(
                                'Create Account',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith( decoration: TextDecoration.underline,decorationColor: AppColors.primaryColor),

                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
