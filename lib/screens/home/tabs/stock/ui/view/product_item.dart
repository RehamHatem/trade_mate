import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/utils/app_colors.dart';

class ProductItem extends StatelessWidget {
   ProductItem({
    required this.name,
     required this.quantity,
     required this.price,
     required this.totalPrice,
     this.supplier,this.category});
String name;
double quantity;
String price;
   String totalPrice;
  String? category;
  String? supplier;
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: 170.h,
      margin: EdgeInsets.only(left: 15.w,right: 15.w,top: 10.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(children: [
        Image.asset("assets/images/product.png",height: 100.h,),
        SizedBox(width: 15.w,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

          Text(name,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.darkPrimaryColor
          ,fontSize: 22.sp),),
          SizedBox(height: 5.h,),

          Text("price: ${price} EGP",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.greyColor
              ,fontSize: 14.sp,overflow: TextOverflow.ellipsis,),),

          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("quantity: ${quantity}",
                    style: Theme.of(context).textTheme.titleMedium!.
                    copyWith(color: AppColors.greyColor
                      ,fontSize: 14.sp),),
                  Text("category: "
                      "${category??"N/A"}",style: Theme.of(context)
                      .textTheme.titleMedium!.copyWith(color: AppColors.greyColor
                      ,fontSize: 14.sp),)
                ],
              ),
              SizedBox(width: 20.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("total: ${totalPrice} EGP",
                    style: Theme.of(context).textTheme.titleMedium!.
                    copyWith(color: AppColors.greyColor,overflow:TextOverflow.ellipsis
                      ,fontSize: 14.sp),),
                  Text("supplier: ${supplier??"N/A"} ",
                    style: Theme.of(context).textTheme.titleMedium!.
                    copyWith(color: AppColors.greyColor
                      ,fontSize: 14.sp),),
                ],
              ),
            ],
          ),
            Row(

              children: [
                ElevatedButton(onPressed: () {
            //ToDo: edit
                },
                    style: ButtonStyle(



                      minimumSize: WidgetStatePropertyAll(Size(50.w,30.h)),
                      backgroundColor: WidgetStateColor.transparent,side: WidgetStatePropertyAll(BorderSide(color: AppColors.primaryColor)),
                      elevation: WidgetStatePropertyAll(0),),
                    child: Row(
                      children: [
                                      Container(
                    height: 20.h,width: 20.h,

                    decoration:BoxDecoration(

                        borderRadius: BorderRadius.circular(25.r),
                        color: AppColors.primaryColor),

                      child: Icon(Icons.edit,size: 10.sp,color: AppColors.whiteColor,)),
                                      SizedBox(width: 10.h,),
                                      Text("Edit",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.greyColor
                      ,fontSize: 14.sp),),
                                    ],)),
    SizedBox(width:85.w,),
                IconButton(onPressed: () {
                  //ToDo: delete
                }, icon: Icon(Icons.delete,size: 30.sp,color: AppColors.redColor,))
              ],
            )

        ],)


      ],),
    );
  }
}
