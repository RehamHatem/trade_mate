

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class ContainerTextIcon extends StatelessWidget {
   ContainerTextIcon({required this.txt,required this.icn});
   String txt;
   Icon icn;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.w,right: 5.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            txt,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(
                fontSize: 16,
                color: AppColors.primaryColor),
          ),

          SizedBox(height: 10.h,),
          icn,
        ],
      ),
    );
  }
}
