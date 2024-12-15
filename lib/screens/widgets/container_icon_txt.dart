

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class ContainerIconTxt extends StatelessWidget {
  ContainerIconTxt({required this.txt,required this.icn});
   String txt;
   Icon icn;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 5.w,bottom: 15.w),
      child: Container(
        padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 5.h,bottom: 5.h),
        height: 100.h,
        width: 120.h,
        decoration: BoxDecoration(

          color: AppColors.lightGreyColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.primaryColor,width: 1.w)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
    
            icn,
            SizedBox(height: 10.h,),
            Text(
              txt,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(
                  fontSize: 16,
                  color: AppColors.primaryColor),
            ),
    
    
          ],
        ),
      ),
    );
  }
}
