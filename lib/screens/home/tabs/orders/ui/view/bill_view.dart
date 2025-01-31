import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/entity/bill_entity.dart';

import '../../../../../../utils/app_colors.dart';

class BillView extends StatelessWidget {
   BillView({super.key,required this.billEntity});
  BillEntity billEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
        Row(
          children: [
            Text(
              "Bill type: ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.blackColor,
                  fontSize: 16.sp,
                  overflow: TextOverflow.ellipsis),
            ),
            Text(
              "${billEntity.billType.toString().substring(9) }",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.blackColor,
                  fontSize: 16.sp,
                  overflow: TextOverflow.ellipsis),
            ),
            Text(
              " | Payment Method: ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.blackColor,
                  fontSize: 16.sp,
                  overflow: TextOverflow.ellipsis),
            ),
            Text(
              "${billEntity.paymentMethod}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.blackColor,
                  fontSize: 16.sp,
                  overflow: TextOverflow.ellipsis),
            ),


          ],
        ),


        Row(
          children: [
            Text(
              "Total: ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.blackColor,
                  fontSize: 16.sp,
                  overflow: TextOverflow.ellipsis),
            ),
            Text(
              "${billEntity.totalBill} EGP",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.blackColor,
                  fontSize: 16.sp,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Discount: ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(
                  color: AppColors.blackColor,
                  fontSize: 16.sp,
                  overflow: TextOverflow.ellipsis),
            ),
            Text(
              "${billEntity.discountBill} EGP",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                  color: AppColors.blackColor,
                  fontSize: 16.sp,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Total after discount: ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(
                  color: AppColors.blackColor,
                  fontSize: 16.sp,
                  overflow: TextOverflow.ellipsis),
            ),
            Text(
              "${billEntity.totalBill-billEntity.discountBill} EGP",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                  color: AppColors.blackColor,
                  fontSize: 16.sp,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Paid: ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(
                  color: AppColors.blackColor,

                  fontSize: 16.sp,
                  overflow: TextOverflow.ellipsis),
            ),
            Text(
              "${billEntity.paid} EGP ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                  color: AppColors.blackColor,

                  fontSize: 16.sp,
                  overflow: TextOverflow.ellipsis),
            ),
            Text(
              "| Remain: ",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(
                  color: AppColors.blackColor,

                  fontSize: 16.sp,
                  overflow: TextOverflow.ellipsis),
            ),
            Text(
              "${billEntity.remain} EGP",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                  color: AppColors.blackColor,

                  fontSize: 16.sp,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),


        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Products:",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.blackColor,

                fontSize: 16.sp,
              ),
            ),
            ...billEntity.products.map((e) => Column(
              children: [
                Text(
                  "${e.name} (Total: ${e.total} EGP, Discount: ${e.discount} ${e.discountType}, After Discount: ${e.totalAfterDiscount} EGP)",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.blackColor,
                    fontSize: 14.sp,
                  ),
                ),
                Divider(color: Colors.grey), // Line separator
              ],
            )),
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



      ],);
  }
}
