import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';
import 'package:trade_mate/utils/app_colors.dart';

import 'edit_product_in_bill.dart';

class BillProductItem extends StatelessWidget {
   BillProductItem({super.key,required this.productEntity,required this.remove,required this.update});
  ProductEntity productEntity;
  Function(ProductEntity) remove;
  Function(ProductEntity) update;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor.withOpacity(0.07),
          ),
        ],
      ),
      margin: EdgeInsets.only(left: 5.w, right: 5.w,bottom: 10.w),
      padding:
          EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.r),
                child: Image.asset(
                  'assets/images/product_preview_rev_1.png',
                  width: 70.w,
                  height: 70.h,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 10),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mrp: egp.${(productEntity.price).toStringAsFixed(2)} | Sp: egp.${productEntity.discount==0?productEntity.price:(productEntity.totalAfterDiscount/productEntity.quantity).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 14.sp, color: AppColors.greyColor),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${productEntity.name}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 22.sp,
                          ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${productEntity.discount==0?productEntity.total:productEntity.totalAfterDiscount}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 16.sp,
                        ),
                  ),
                  Text(
                    '${productEntity.total}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.greyColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {

                    showModalBottomSheet(
                      backgroundColor: AppColors.lightGreyColor,
                      scrollControlDisabledMaxHeightRatio: .7,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return Container(
                            margin: EdgeInsets.only(
                                left: 16.h,right: 16.h,bottom: 16.w,top:16.w
                            ),


                            padding: EdgeInsets.only(

                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            decoration: BoxDecoration(color: AppColors.lightGreyColor,borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(15.r),topRight:
                            Radius.circular(15.r))),
                            child:EditProductInBill(
                              edit:(p0) {
                              update(p0);
                              print(p0.name);
                            },productEntity: productEntity,));
                      },
                    );

                  },
                  style: ButtonStyle(
                    minimumSize: WidgetStatePropertyAll(Size(50.w, 30.h)),
                    backgroundColor: WidgetStateColor.transparent,
                    side: WidgetStatePropertyAll(
                        BorderSide(color: AppColors.primaryColor)),
                    elevation: WidgetStatePropertyAll(0),
                  ),
                  child: Row(
                    children: [
                      Container(
                          height: 20.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.r),
                              color: AppColors.primaryColor),
                          child: Icon(
                            Icons.edit,
                            size: 10.sp,
                            color: AppColors.whiteColor,
                          )),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "Edit",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: AppColors.darkPrimaryColor,
                                fontSize: 14.sp),
                      ),
                    ],
                  )),
              SizedBox(width: 8.w),
              Container(
                height: 30.h,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyColor),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        productEntity.quantity = productEntity.quantity -1 ;
                        productEntity.total=productEntity.quantity*productEntity.price;

                       productEntity.discountType=="%"? productEntity.totalAfterDiscount=productEntity.total-(productEntity.total*productEntity.discount)/100
                       :productEntity.totalAfterDiscount=productEntity.total-productEntity.discount;
                        update(productEntity);
                      },
                      child: Container(
                          width: 50.w,
                          child: Icon(
                            Icons.remove,
                            size: 25.sp,
                            color: AppColors.redColor,
                          )),
                    ),
                    Container(
                      height: 30.h,
                      width: 80.w,
                      decoration:
                          BoxDecoration(color: Colors.transparent, boxShadow: [
                        BoxShadow(
                          color: AppColors.greyColor.withOpacity(0.3),
                        )
                      ]),
                      child: Center(
                        child: Text(
                          "${productEntity.quantity}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 16.sp, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        productEntity.quantity = productEntity.quantity +1 ;
                        productEntity.total=productEntity.quantity*productEntity.price;
                        productEntity.discountType=="%"? productEntity.totalAfterDiscount=productEntity.total-(productEntity.total*productEntity.discount)/100
                            :productEntity.totalAfterDiscount=productEntity.total-productEntity.discount;
                        update(productEntity);
                      },
                      child: Container(
                          width: 50.w,
                          child: Icon(
                            Icons.add,
                            size: 25.sp,
                            color: AppColors.greenColor,
                          )),
                    ),
                    Container(
                      width: 35.w,
                      height: 33.h,
                      decoration: BoxDecoration(
                        color: AppColors.greyColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(3.r),
                            bottomRight: Radius.circular(3.r)),
                      ),
                      child: Center(
                        child: Text(
                          productEntity.quantityType=="piece"?"Pc":productEntity.quantityType=="litre"?"L":productEntity.quantityType==
                          "ton"?"ton":productEntity.quantityType,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 14.sp),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),
              // Delete Button
              InkWell(
                onTap: () {
                  remove(productEntity);
                },
                child:  Icon(Icons.delete, color: AppColors.redColor,size: 28.sp,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
