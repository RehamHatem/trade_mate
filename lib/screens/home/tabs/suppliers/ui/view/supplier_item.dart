import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';

import '../../../../../../utils/app_colors.dart';

class SupplierItem extends StatelessWidget {
   SupplierItem({required this.supplierEntity,required this.delete});
SupplierEntity supplierEntity;
   void Function (String)delete;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: double.infinity,
          height: 110.h,

          margin: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h,bottom: 10.h),
          padding: EdgeInsets.only(left: 20.w),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,

            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Row(children: [
            Container(
              alignment: Alignment.center,
              height: 60.h,width: 60.w,
              child: Text("${supplierEntity.name.substring(0,1)}",


                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.whiteColor
                  ,fontSize: 28.sp,
                    ),),
              decoration: BoxDecoration(
                color: AppColors.darkPrimaryColor,
                borderRadius: BorderRadius.circular(50.r),

              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(supplierEntity.name,maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.darkPrimaryColor
                      ,fontSize: 22.sp,overflow: TextOverflow.ellipsis),),
                  SizedBox(height: 2.h,),
                  Text(supplierEntity.phone,maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.darkPrimaryColor
                      ,fontSize: 22.sp,overflow: TextOverflow.ellipsis),),
                  SizedBox(height: 2.h,),
                  Text(supplierEntity.date,maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.greyColor
                      ,fontSize: 20.sp,overflow: TextOverflow.ellipsis),),

                ],),

            ),
           



          ],),
        ),
        Positioned(
          bottom: 88.h,
          left: 350.w,
          child: IconButton(onPressed: () {
            delete(supplierEntity.name);

          },
            color: AppColors.redColor,
            icon: Icon(Icons.cancel),),
        ),
        Positioned(
          top: 72.h,
          right: 15.w,
          child: IconButton(onPressed: () {
          
          },
          
          
            color: Colors.transparent,
            icon: Icon(Icons.edit,color: AppColors.greyColor,size: 15,),),
        ),
      ],
    );
  }
}
