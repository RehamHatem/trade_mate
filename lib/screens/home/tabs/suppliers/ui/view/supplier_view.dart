import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view/supplier_history_details.dart';

import '../../../../../../utils/app_colors.dart';

class SupplierView extends StatelessWidget {
   SupplierView({required this.supplierEntity});
SupplierEntity supplierEntity;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Row(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Supplier name: ",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.greyColor
                ,fontSize: 20.sp,overflow: TextOverflow.ellipsis ),),
            Expanded(
              child: Text("${supplierEntity.name}",maxLines: 3,overflow:TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.primaryColor
                  ,fontSize: 20.sp,overflow: TextOverflow.ellipsis ),),
            ),
          ],
        ),

        Row(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Phone: ",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.greyColor
              ,fontSize: 20.sp,overflow: TextOverflow.ellipsis,),),
            Expanded(
              child: Text("${supplierEntity.phone
                  } ",maxLines: 3,overflow:TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.primaryColor
                ,fontSize: 20.sp,overflow: TextOverflow.ellipsis,),),
            ),

          ],
        ),

        Row(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("City: ",
              style: Theme.of(context).textTheme.titleMedium!.
              copyWith(color: AppColors.greyColor
                  ,fontSize: 20.sp),),
            Expanded(
              child: Text("${supplierEntity.city}",
                maxLines: 3,overflow:TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium!.
                copyWith(color: AppColors.primaryColor
                    ,fontSize: 20.sp),),
            ),
          ],
        ),
        Row(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Address: ",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.greyColor
              ,fontSize: 20.sp,overflow: TextOverflow.ellipsis,),),
            Text("${supplierEntity.address} ",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.primaryColor
              ,fontSize: 20.sp,overflow: TextOverflow.ellipsis,),),
          ],
        ),
        Row(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notes: ",style: Theme.of(context)
                .textTheme.titleMedium!.copyWith(color: AppColors.greyColor
                ,fontSize: 20.sp),),
            Expanded(
              child: Text("${supplierEntity.notes??"N/A"}",maxLines: 3,overflow:TextOverflow.ellipsis,style: Theme.of(context)
                  .textTheme.titleMedium!.copyWith(color: AppColors.primaryColor
                  ,fontSize: 20.sp),),
            ),
          ],
        ),
        Row(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Date: ",
              style: Theme.of(context).textTheme.titleMedium!.
              copyWith(color: AppColors.greyColor
                  ,fontSize: 20.sp),),
            Expanded(
              child: Text("${supplierEntity.date}",maxLines: 3,overflow:TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium!.
                copyWith(color: AppColors.primaryColor
                    ,fontSize: 20.sp),),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, SupplierHistoryDetails.routeName,arguments: supplierEntity);

              },
              style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.only(bottom: 5.h,top: 5.h,right: 15.w,left: 15.w)),
                  backgroundColor:
                  WidgetStatePropertyAll(AppColors.darkPrimaryColor),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r)),
                  )),
              child: Text(
                "view more",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(
                    color: AppColors.whiteColor, fontSize: 20.sp),
              ),
            ),
          ],
        )



      ],);
  }
}
