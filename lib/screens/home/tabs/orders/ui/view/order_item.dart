import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/entity/bill_entity.dart';

import '../../../../../../utils/app_colors.dart';

class OrderItem extends StatelessWidget {
   OrderItem({super.key,required this.billEntity,required this.delete});
  BillEntity billEntity;
   void Function(String) delete;

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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 50.h,),
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
              SizedBox(height: 50.h,),
              IconButton(onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      actions: [
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                  fontSize: 16.sp,
                                  color: AppColors.whiteColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      AppColors.primaryColor),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.r),
                                      ))),
                            ),
                            Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                delete(billEntity.id);
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Delete",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                  fontSize: 16.sp,
                                  color: AppColors.whiteColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                  WidgetStatePropertyAll(AppColors.redColor),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.r),
                                      ))),
                            ),
                          ],
                        )
                      ],
                      backgroundColor: AppColors.lightGreyColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          side: BorderSide(color: AppColors.primaryColor)),
                      alignment: Alignment.center,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Do you want to delete ${billEntity.supplierName==""?billEntity.customerName:billEntity.supplierName}?",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    );
                  },
                );

              }, icon: Icon(Icons.delete,color: AppColors.redColor,))
            ],
          ),
        ],
      ),
    );
  }
}
