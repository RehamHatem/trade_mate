import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';

import '../../../../../../utils/app_colors.dart';

class CustomerView extends StatelessWidget {
  CustomerView({required this.customerEntity});
SupplierEntity customerEntity;
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
            Text("Customer name: ",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.greyColor
                ,fontSize: 20.sp,overflow: TextOverflow.ellipsis ),),
            Expanded(
              child: Text("${customerEntity.name}",maxLines: 3,overflow:TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.primaryColor
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
              child: Text("${customerEntity.phone
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
              child: Text("${customerEntity.city}",
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
            Text("${customerEntity.address} ",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.primaryColor
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
              child: Text("${customerEntity.notes??"N/A"}",maxLines: 3,overflow:TextOverflow.ellipsis,style: Theme.of(context)
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
              child: Text("${customerEntity.date}",maxLines: 3,overflow:TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium!.
                copyWith(color: AppColors.primaryColor
                    ,fontSize: 20.sp),),
            ),
          ],
        ),



      ],);
  }
}
