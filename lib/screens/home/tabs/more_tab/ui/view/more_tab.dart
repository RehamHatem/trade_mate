import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/more_tab/ui/view_model/more_view_model.dart';
import 'package:trade_mate/utils/app_colors.dart';

import '../../../../../auth/login/ui/view/login_screen.dart';
import '../../domain/more_di.dart';

class MoreTab extends StatelessWidget {
   MoreTab({super.key});
MoreViewModel moreViewModel=MoreViewModel(moreUseCases: injectMoreUseCases());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor:AppColors.lightGreyColor,
      width: 360.w,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(children: [
        BlocListener(
          bloc: moreViewModel..readUser(),
          listener: (context, state) {

          },
          child: Container(
            padding: EdgeInsets.only(left: 8.w,top: 10.h,bottom: 10.h,right: 8.w),
height: 300.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.darkPrimaryColor,

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 100.h,
                  width: 100.w,
                  child:
                  Icon(Icons.person,color: AppColors.whiteColor.withOpacity(.7),size: 50.sp,),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor.withOpacity(.3),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                ),
                SizedBox(
                  height:5.w,
                ),
                Text(
                              "${moreViewModel.user?.userName}"??"m",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: 30.sp,
                      overflow: TextOverflow.ellipsis),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "${moreViewModel.user?.phone}"??"m",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.whiteColor.withOpacity(.8),
                      fontSize: 22.sp,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),

        ),
        SizedBox(height: 10.h,),
        Padding(
          padding:  EdgeInsets.only(left: 15.w,right: 10.w,top: 5.h,bottom: 5.h),
          child: Column(
            children: [
              Row(children: [
                Text("E-mail ",style:Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.greyColor,
                    fontSize: 20.sp,
                    overflow: TextOverflow.ellipsis) ,),
                Spacer(),
                Text("${moreViewModel.user?.email}",style:Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColors.blackColor,
                    fontSize: 22.sp,
                    overflow: TextOverflow.ellipsis) ,)
              ],),
              SizedBox(height: 5.w,),
              Divider(),
              SizedBox(height: 15.w,),

              Container(
                padding: EdgeInsets.only(bottom: 15.h,top: 15.h,right: 10.w,left: 10.w),
                decoration: BoxDecoration(color: AppColors.whiteColor.withOpacity(.4),
                    borderRadius: BorderRadius.circular(8.r)
                ),
                child: Row(children: [
                 Icon(Icons.person,size: 25.sp,color: AppColors.blackColor,),
                  SizedBox(width: 20.w,),
                  Text("Profile details ",style:Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.blackColor,
                      fontSize: 22.sp,
                      overflow: TextOverflow.ellipsis) ,),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_rounded,size: 20.sp,color: AppColors.greyColor,)
                ],),
              ),
              SizedBox(height: 15.h,),
              // Divider(),
              Container(
                padding: EdgeInsets.only(bottom: 15.h,top: 15.h,right: 10.w,left: 10.w),
                decoration: BoxDecoration(color: AppColors.whiteColor.withOpacity(.4),
                    borderRadius: BorderRadius.circular(8.r)
                ),
                child: Row(children: [
                  Icon(Icons.settings,size: 25.sp,color: AppColors.blackColor,),
                  SizedBox(width: 20.w,),
                  Text("Settings ",style:Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.blackColor,
                      fontSize: 22.sp,
                      overflow: TextOverflow.ellipsis) ,),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios_rounded,size: 20.sp,color: AppColors.greyColor,)
                ],),
              ),
              SizedBox(height: 15.h,),

              InkWell(
                onTap: () {
                  moreViewModel.logOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.routeName, (route) => false);
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 15.h,top: 15.h,right: 10.w,left: 10.w),
                  decoration: BoxDecoration(color: AppColors.whiteColor.withOpacity(.4),
                  borderRadius: BorderRadius.circular(8.r)
                  ),
                  child: Row(children: [
                    Icon(Icons.logout,size: 25.sp,color: AppColors.blackColor,),
                    SizedBox(width: 20.w,),
                    Text("Log Out ",style:Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.blackColor,
                        fontSize: 22.sp,
                        overflow: TextOverflow.ellipsis) ,),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded,size: 20.sp,color: AppColors.greyColor,)
                  ],),
                ),
              ),
            ],
          ),
        )

      ],),
    );
  }
}
