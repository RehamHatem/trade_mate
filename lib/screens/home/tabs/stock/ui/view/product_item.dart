import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/add_product/data/model/product_model.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';
import 'package:trade_mate/screens/home/tabs/stock/ui/view/edit_product.dart';
import 'package:trade_mate/screens/home/tabs/stock/ui/view/product_view.dart';
import 'package:trade_mate/screens/home/tabs/stock/ui/view_model/stock_view_model.dart';
import 'package:trade_mate/utils/app_colors.dart';

class ProductItem extends StatelessWidget {
   ProductItem({
     required this.productModel,
     required this.delete,
     required this.update,
   });
ProductEntity productModel;
void Function (String)delete;
void Function (String,ProductEntity)update;

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: 170.h,
      margin: EdgeInsets.only(left: 15.w,right: 15.w,top: 10.h,bottom: 10.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(children: [
        Image.asset("assets/images/product.png",height: 100.h,),
        SizedBox(width: 15.w,),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
          
            children: [
          
            Text(productModel.name,maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.darkPrimaryColor
            ,fontSize: 22.sp,overflow: TextOverflow.ellipsis),),
            SizedBox(height: 5.h,),
          
            Text("price: ${double.parse(productModel.price.toString()).toStringAsFixed(2)
              ??"0.00"} EGP",maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.greyColor
                ,fontSize: 14.sp,overflow: TextOverflow.ellipsis,),),
          
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("quantity: ${double.parse(productModel.quantity.toString()).toStringAsFixed(2)
                        ??"0.00"}",
                      maxLines: 1,overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium!.
                        copyWith(color: AppColors.greyColor
                          ,fontSize: 14.sp,overflow: TextOverflow.ellipsis),),
                      Text("category: "
                          "${productModel.category??"N/A"}",maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context)
                          .textTheme.titleMedium!.copyWith(color: AppColors.greyColor
                          ,fontSize: 14.sp,overflow: TextOverflow.ellipsis),)
                    ],
                  ),
                ),
                SizedBox(width: 20.w,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("total: ${productModel.total} EGP",
                      maxLines: 1,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleMedium!.
                        copyWith(color: AppColors.greyColor,overflow:TextOverflow.ellipsis
                          ,fontSize: 14.sp),),
                      Text("supplier: ${productModel.supplier??"N/A"} ",
                        overflow: TextOverflow.ellipsis,maxLines: 1,
                        style: Theme.of(context).textTheme.titleMedium!.
                        copyWith(color: AppColors.greyColor
                          ,fontSize: 14.sp,overflow: TextOverflow.ellipsis),),
                    ],
                  ),
                ),
              ],
            ),
              Row(
          
                children: [
                  ElevatedButton(onPressed: () {
              //ToDo: edit
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return Container(
                          margin: EdgeInsets.only(
                            left: 16.h,right: 16.h,bottom: 16.w,top:16.w
                          ),
          
          
                            padding: EdgeInsets.only(
          
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            decoration: BoxDecoration(color: AppColors.whiteColor,borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(15.r),topRight:
                            Radius.circular(15.r))),
                            child:EditProduct(update:(p0, p1) {
                              update(productModel.id,p1);
                            },productEntity: productModel,));
                      },
                    );
                  },
                      style: ButtonStyle(
          
          
          
                        minimumSize: WidgetStatePropertyAll(Size(50.w,30.h)),
                        backgroundColor: WidgetStateColor.transparent,side: WidgetStatePropertyAll(BorderSide(color: AppColors.primaryColor)),
                        elevation: WidgetStatePropertyAll(0),),
                      child: Row(
                        children: [
                                        Container(
                      height: 20.h,width: 20.w,
          
                      decoration:BoxDecoration(
          
                          borderRadius: BorderRadius.circular(25.r),
                          color: AppColors.primaryColor),
          
                        child: Icon(Icons.edit,size: 10.sp,color: AppColors.whiteColor,)),
                                        SizedBox(width: 10.w,),
                                        Text("Edit",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.greyColor
                        ,fontSize: 14.sp),),
                                      ],)),
              SizedBox(width:85.w,),
                  IconButton(onPressed: () {
                   delete(productModel.id);
                  }, icon: Icon(Icons.delete,size: 30.sp,color: AppColors.redColor,))
                ],
              )
          
          ],),
        )


      ],),
    );
  }
}
