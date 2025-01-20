import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/entity/bill_entity.dart';

import '../../../../../../utils/app_colors.dart';

class OrderItem extends StatelessWidget {
   OrderItem({super.key,required this.billEntity});
  BillEntity billEntity;

  @override
  Widget build(BuildContext context) {
    return   Container(
      width: double.infinity,

      margin:
      EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 2.h),
      padding: EdgeInsets.only(left: 20.w,top: 5.h,bottom: 5.h,right: 5.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [BoxShadow(color: AppColors.greyColor.withOpacity(.1),spreadRadius: 1)],

        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  billEntity.supplierName==""?billEntity.customerName:billEntity.supplierName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.darkPrimaryColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Bill type: ${billEntity.billType.toString().substring(9)}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w300,
                      overflow: TextOverflow.ellipsis),
                ),

                Text(
                  "Total: ${billEntity.totalBill} EGP",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 18.sp,
                      overflow: TextOverflow.ellipsis),
                ),
                Text(
                  "Discount: ${billEntity.discountBill} EGP",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 16.sp,
                      overflow: TextOverflow.ellipsis),
                ),
                Text(
                  "Total after discount: ${billEntity.totalBill-billEntity.discountBill} EGP",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 16.sp,
                      overflow: TextOverflow.ellipsis),
                ),
                Text(
                  "Paid: ${billEntity.paid} EGP | Remain: ${billEntity.remain} EGP",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 16.sp,
                      overflow: TextOverflow.ellipsis),
                ),


                Row(
                  children: [
                    Text(
                      "Products: ${billEntity.products.map((e)=>e.name ,).toList() }",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w300,
                          fontSize: 16.sp,
                          overflow: TextOverflow.ellipsis),
                    ),

                  ],
                ),
                Text(
                  "Date: ${billEntity.date}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 16.sp,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          Container(

            padding: EdgeInsets.only(right: 15.h,left: 15.h),
            margin: EdgeInsets.only(right: 5.h,left: 5.h),
            height: 30.h,
            width: 100.w,

            decoration: BoxDecoration(
                color: AppColors.lightGreyColor,
                borderRadius: BorderRadius.circular(5.r)
            ),
            child: Text(
              billEntity.paymentMethod,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(
                fontSize: 25.sp,
                color:
                AppColors.primaryColor,


              ),
            ),
          ),
        ],
      ),
    );
  }
}
