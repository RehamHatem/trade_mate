import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/entity/bill_entity.dart';
import 'package:trade_mate/screens/home/tabs/bill/ui/view/bill_tab.dart';
import 'package:trade_mate/screens/home/tabs/orders/domain/orders_di.dart';
import 'package:trade_mate/screens/home/tabs/orders/ui/view_model/orders_view_model.dart';
import 'package:trade_mate/utils/dialog_utils.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../widgets/add_product_text_field.dart';

class OrderItem extends StatelessWidget {
   OrderItem({super.key,required this.billEntity,required this.delete,
     required this.update,required this.ordersViewModel,
   required this.collectMoney,required this.payMoney});
  BillEntity billEntity;
   void Function(String) delete;
   void Function(String id, BillEntity bill) update;
   var formKey=GlobalKey<FormState>();
   OrdersViewModel ordersViewModel;
    Function collectMoney;
    Function payMoney;


   @override
  Widget build(BuildContext context) {
     // ordersViewModel.homeTabViewModel.getBalance( FirebaseAuth.instance.currentUser!.uid);
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
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        billEntity.supplierName==""?billEntity.customerName:billEntity.supplierName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: AppColors.darkPrimaryColor,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Icon(billEntity.billType==BillType.inBill? Icons.move_to_inbox_rounded:Icons.outbox_rounded,color: AppColors.darkPrimaryColor,size: 25.sp,)

                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Bill type: ${billEntity.billType.toString().substring(9)} ",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.blackColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w300,
                      overflow: TextOverflow.ellipsis),
                ),

                Text(
                  "Total: ${billEntity.totalBill} EGP",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.blackColor,
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
                      color: AppColors.blackColor,
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
                      color: AppColors.blackColor,
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
                      color: AppColors.blackColor,
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
                          color: AppColors.blackColor,
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
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  if (billEntity.remain!=0){
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: AppColors.lightGreyColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          title: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      billEntity.billType==BillType.inBill?"Pay to ${billEntity.supplierName}":
                                      "Collect from ${billEntity.customerName}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                          color: AppColors
                                              .darkPrimaryColor,fontSize: 25.sp),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),

                                  IconButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                        WidgetStatePropertyAll(
                                            AppColors
                                                .darkPrimaryColor),
                                        shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  50.r),
                                            ))),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.close,
                                        size: 25.sp,
                                        color: AppColors.whiteColor),
                                  ),
                                ],
                              ),
                              Divider(
                                color: AppColors.darkPrimaryColor,
                              )
                            ],
                          ),
                          alignment: Alignment.center,
                          content: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "amount: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                            color: AppColors
                                                .darkPrimaryColor,fontSize: 22.sp),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(width: 5.w,),
                                    Expanded(
                                      flex:2,
                                      child: AddProductTextField(

                                        controller:ordersViewModel.payOrCollectController,
                                        hintText: "0.00",

                                        suffix:Text(
                                          "EGP",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                              color: AppColors
                                                  .darkPrimaryColor,fontSize: 20.sp),
                                          textAlign: TextAlign.center,

                                        ) ,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return 'please enter amount';
                                          }if(billEntity.remain<double.parse(value)){
                                            return 'the total remain is ${billEntity.remain.toStringAsFixed(2)} ';

                                          }
                                          return null;
                                        },
                                        isEnabled: true,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        ordersViewModel.homeTabViewModel.getBalance( FirebaseAuth.instance.currentUser!.uid);
                                        if(formKey.currentState!.validate()){
                                          BillEntity updated=BillEntity(id: billEntity.id,
                                              supplierName: billEntity.supplierName,
                                              customerName: billEntity.customerName,
                                              billType: billEntity.billType,
                                              paymentMethod: billEntity.paymentMethod,
                                              retailOrWholesale: billEntity.retailOrWholesale,
                                              products: billEntity.products,
                                              paid: billEntity.paid+double.parse(ordersViewModel.payOrCollectController.text),
                                              remain: billEntity.remain-double.parse(ordersViewModel.payOrCollectController.text),
                                              discountBill: billEntity.discountBill,
                                              totalBill: billEntity.totalBill,
                                              date: billEntity.date,
                                              userId: billEntity.userId);
                                          if(billEntity.billType==BillType.inBill && ordersViewModel.homeTabViewModel.myBalance>=double.parse(ordersViewModel.payOrCollectController.text)) {
                                            update(billEntity.id, updated);
                                            payMoney();

                                          }
                                          else if(billEntity.billType==BillType.outBill ) {
                                            update(billEntity.id, updated);
                                            collectMoney();

                                          }
                                          else {
                                            Navigator.pop(context);
                                            return DialogUtils.showMessage(context, "You can't pay , Your balance is ${ordersViewModel.homeTabViewModel.myBalance} EGP",title: "Note");
                                          }
                                          Navigator.pop(context);
                                        }

                                      },
                                      style: ButtonStyle(
                                          padding: WidgetStatePropertyAll(EdgeInsets.only(bottom: 5.h,top: 5.h)),
                                          backgroundColor:
                                          WidgetStatePropertyAll(AppColors.darkPrimaryColor),
                                          shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15.r)),
                                          )),
                                      child: Text(
                                        "Save",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                            color: AppColors.whiteColor, fontSize: 20.sp),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                        );
                      },
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(right: 10.h,left: 10.h),
                  // margin: EdgeInsets.only(right: 5.h,left: 5.h),
                  decoration: BoxDecoration(
                      color:Colors.transparent,
                      borderRadius: BorderRadius.circular(5.r),
                    border: Border.all(color: AppColors.primaryColor.withOpacity(.7))
                  ),
                  child: Center(
                    child: Text(
                      billEntity.billType==BillType.inBill&&billEntity.remain!=0? "pay": billEntity.billType==BillType.outBill&&billEntity.remain!=0?"collect":"completed",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                        fontSize: 16.sp,
                        color:
                        billEntity.remain==0?AppColors.greenColor:AppColors.greyColor,


                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h,),

              Container(

                padding: EdgeInsets.only(right: 15.h,left: 15.h),
                margin: EdgeInsets.only(left: 5.h),
                height: 35.h,
                width: 120.w,

                decoration: BoxDecoration(
                    color: AppColors.lightGreyColor.withOpacity(.4),
                    borderRadius: BorderRadius.circular(5.r)
                ),
                child: Center(
                  child: Text(
                    billEntity.paymentMethod,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                      fontSize: 20.sp,
                      color:
                      AppColors.blackColor,


                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h,),

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
