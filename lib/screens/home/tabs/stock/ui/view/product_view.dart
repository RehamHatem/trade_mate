import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../widgets/add_product_text_field.dart';

class ProductView extends StatelessWidget {
   ProductView({required this.productEntity});
  ProductEntity productEntity;
  @override
  Widget build(BuildContext context) {
    return
    Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,

children: [

  Row(
    mainAxisAlignment:MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Product name: ",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.greyColor
          ,fontSize: 20.sp,overflow: TextOverflow.ellipsis ),),
      Expanded(
        child: Text("${productEntity.name}",maxLines: 3,overflow:TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.primaryColor
            ,fontSize: 20.sp,overflow: TextOverflow.ellipsis ),),
      ),
    ],
  ),

  Row(
    mainAxisAlignment:MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Price: ",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.greyColor
        ,fontSize: 20.sp,overflow: TextOverflow.ellipsis,),),
      Expanded(
        child: Text("${double.parse(productEntity.price.toString()).toStringAsFixed(2)
            ??"0.00"} EGP",maxLines: 3,overflow:TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.primaryColor
          ,fontSize: 20.sp,overflow: TextOverflow.ellipsis,),),
      ),

    ],
  ),

  Row(
    mainAxisAlignment:MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Quantity: ",
        style: Theme.of(context).textTheme.titleMedium!.
        copyWith(color: AppColors.greyColor
            ,fontSize: 20.sp),),
      Expanded(
        child: Text("${productEntity.quantity}",
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
      Text("Total: ",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.greyColor
        ,fontSize: 20.sp,overflow: TextOverflow.ellipsis,),),
      Text("${double.parse(productEntity.total.toString()).toStringAsFixed(2)
          ??"0.00"} EGP",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.primaryColor
        ,fontSize: 20.sp,overflow: TextOverflow.ellipsis,),),
    ],
  ),
  Row(
    mainAxisAlignment:MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Category: ",style: Theme.of(context)
          .textTheme.titleMedium!.copyWith(color: AppColors.greyColor
          ,fontSize: 20.sp),),
      Expanded(
        child: Text("${productEntity.category??"N/A"}",maxLines: 3,overflow:TextOverflow.ellipsis,style: Theme.of(context)
            .textTheme.titleMedium!.copyWith(color: AppColors.primaryColor
            ,fontSize: 20.sp),),
      ),
    ],
  ),
  Row(
    mainAxisAlignment:MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Supplier: ",
        style: Theme.of(context).textTheme.titleMedium!.
        copyWith(color: AppColors.greyColor
            ,fontSize: 20.sp),),
      Expanded(
        child: Text("${productEntity.supplier??"N/A"}",maxLines: 3,overflow:TextOverflow.ellipsis,
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
      Text("Notes: ",
        style: Theme.of(context).textTheme.titleMedium!.
        copyWith(color: AppColors.greyColor
            ,fontSize: 20.sp),),
      Expanded(
        child: Text("${productEntity.notes??"N/A"}",maxLines: 5,overflow:TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium!.
          copyWith(color: AppColors.primaryColor
              ,fontSize: 20.sp),),
      ),
    ],
  ),


],);









  }
}

