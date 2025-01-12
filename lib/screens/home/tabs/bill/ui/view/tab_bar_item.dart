
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/app_colors.dart';

class TabBarItem extends StatelessWidget {
  String bill;
  bool isSelected;
  Function(String) removeBill;
  TabBarItem({required this.bill,required this.isSelected,required this.removeBill});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.h),
height: 53.h,
      width: 70.w,
      decoration: BoxDecoration(
          color: isSelected? AppColors.darkPrimaryColor:Colors.transparent,
          borderRadius: BorderRadius.only(topRight: Radius.circular(15.r),topLeft: Radius.circular(15.r)),
          border: Border.all(color: isSelected? Colors.transparent:Colors.transparent)
      ),
      child: Row(
        children: [
          SizedBox(width: 8.w,),
          Text(
            bill,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(
                fontSize: 14.sp,
                color: isSelected? Colors.white:AppColors.darkPrimaryColor),
          ),
          Spacer(),
          InkWell(


            child: Icon(Icons.close, size: 14.sp,color: isSelected? Colors.white:AppColors.darkPrimaryColor,),
            onTap: () => removeBill(bill),
          ),

        ],
      ),
    );
  }
}
