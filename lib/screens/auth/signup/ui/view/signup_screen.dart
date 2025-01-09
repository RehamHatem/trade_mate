import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/auth/login/ui/view/login_screen.dart';
import 'package:trade_mate/screens/auth/signup/domain/entity/user_entity.dart';
import 'package:trade_mate/screens/auth/signup/ui/view_model/signup_states.dart';
import 'package:trade_mate/screens/auth/signup/ui/view_model/signup_view_model.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/dialog_utils.dart';
import '../../../../../utils/text_field_item.dart';
import '../../data/model/user_model.dart';
import '../../domain/di.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName="signup";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var signupViewModel=SignupViewModel( signupUseCase:  injectSignupUseCase());
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: signupViewModel,
      listener: (context, state) {
        if (state is LoadingSignupState){
          return DialogUtils.showLoading(context, "Loading...");
        }
        else if (state is ErrorSignupState){
          DialogUtils.hideLoading(context);
          return DialogUtils.showMessage(context, state.errorMessage.toString(),title: "Error");
        }
        else if (state  is SuccessSignupState){
          DialogUtils.hideLoading(context);
          Navigator.pushReplacementNamed(context,LoginScreen. routeName);
          return DialogUtils.showMessage(context, "success");
        }

      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 75.h, bottom: 30.h, left: 100.w, right: 100.w),
                child: Image.asset(
                  'assets/images/logo2.png',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:20.w,vertical: 15.h),
                child: Text(
                  'SignUp',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 26.sp),
                ),
              ),
          
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal:20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Form(
                            key: signupViewModel.formKey,
                            child: Column(
                              children: [
                                TextFieldItem(
                                  fieldName: 'Full Name',
                                  hintText: 'enter your name',
                                  controller: signupViewModel.nameController,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'please enter your name';
                                    }
                                    return null;
                                  },
                                ),
                                TextFieldItem(
                                  fieldName: 'E-mail address',
                                  hintText: 'enter your email address',
                                  controller: signupViewModel.emailController,
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
                                  controller: signupViewModel.passwordController,
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
                                  keyboardType: TextInputType.visiblePassword,
                                  isObscure: signupViewModel.isObscure,
                                  suffixIcon: InkWell(
                                    child: signupViewModel.isObscure
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                    onTap: () {
                                      if (signupViewModel.isObscure) {
                                        signupViewModel.isObscure = false;
                                      } else {
                                        signupViewModel.isObscure = true;
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ),
                                TextFieldItem(
                                  fieldName: 'Confirmation Password',
                                  hintText: 'enter your confirmation Password',
                                  controller: signupViewModel.confirmationPasswordController,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'please enter rePassword';
                                    }
                                    if (value != signupViewModel.passwordController.text) {
                                      return "Password doesn't match";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  isObscure: signupViewModel.isObscure,
                                  suffixIcon: InkWell(
                                    child: signupViewModel.isObscure
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                    onTap: () {
                                      if (signupViewModel.isObscure) {
                                        signupViewModel.isObscure = false;
                                      } else {
                                        signupViewModel.isObscure = true;
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ),
                                TextFieldItem(
                                  fieldName: 'Mobile Number',
                                  hintText: 'enter your mobile number',
                                  controller: signupViewModel.phoneController,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'please enter your mobile no';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'back to login',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: AppColors.primaryColor,fontSize: 16.sp,decoration: TextDecoration.underline),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.h),
                          child: ElevatedButton(
                            onPressed: () {
                              var user = UserModel(
                                id: "",
                                email: signupViewModel.emailController.text,
                                userName: signupViewModel.nameController.text,
                                phone: signupViewModel.phoneController.text,
                              );
                              signupViewModel.signUp(user ,signupViewModel.passwordController.text);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.lightGreyColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15.r)))),
                            child: SizedBox(
                              height: 64.h,
                              width: 398.w,
                              child: Center(
                                child: Text(
                                  'Sign up',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                      color: AppColors.primaryColor,
                                      fontSize: 30.sp),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SafeArea(child: SizedBox(height: 20.h,))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
