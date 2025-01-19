import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';

import '../../../../../../utils/app_colors.dart';
import 'bill_tab.dart';

class ProductItemInSearch extends StatelessWidget {
   ProductItemInSearch({super.key,required this.productEntity,required this.add,required this.bill});
  ProductEntity productEntity;
  BillType bill;
  Function(List <ProductEntity>products,BillType bill)add;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
margin: EdgeInsets.only(bottom: 5.h),
      padding: EdgeInsets.only(left: 10.w,right: 20.w,top: 10.h,bottom: 10.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Row(children: [
            Image.asset("assets/images/product.png",height: 80.h,),
            SizedBox(width: 15.w,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(productEntity.name,maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.darkPrimaryColor
                      ,fontSize: 22.sp,overflow: TextOverflow.ellipsis),),
                  SizedBox(height: 5.h,),
                  Text(
                    'Mrp: egp.${(productEntity.price).toStringAsFixed(2)} | Sp: egp.${productEntity.discount==0?productEntity.price.toStringAsFixed(2) :(productEntity.totalAfterDiscount/productEntity.quantity).toStringAsFixed(2)}',
                      maxLines: 1,overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 14.sp, color: AppColors.greyColor),
                  ),



                  Text("quantity: ${double.parse(productEntity.quantity.toString()).toStringAsFixed(2)
                      ??"0.00"} ${productEntity.quantityType==""?"piece":productEntity.quantityType} | total: ${productEntity.total} EGP",
                    maxLines: 1,overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.
                    copyWith(color: AppColors.greyColor
                        ,fontSize: 14.sp,overflow: TextOverflow.ellipsis),),


                ],),
            )


          ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              ElevatedButton(onPressed: () {

                add([productEntity],bill);

              },
                  style: ButtonStyle(

                    minimumSize: WidgetStatePropertyAll(Size(40.w,40.h)),
                    backgroundColor: WidgetStatePropertyAll(AppColors.whiteColor),
                    side: WidgetStatePropertyAll(BorderSide(color: AppColors.greyColor)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.r)))),
                    elevation: WidgetStatePropertyAll(0),),
                  child: Text("Add",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.darkPrimaryColor,fontWeight:FontWeight.w600
                      ,fontSize: 20.sp),)),
            ],
          )
        ],
      ),
    );
  }
}
