import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/auth/signup/data/model/user_model.dart';
import 'package:trade_mate/screens/home/tabs/add_product/ui/view/add_product_screen.dart';
import 'package:trade_mate/screens/home/tabs/home_tab/ui/view_model/home_tab_states.dart';
import 'package:trade_mate/screens/home/tabs/home_tab/ui/view_model/home_tab_view_model.dart';
import 'package:trade_mate/screens/home/tabs/orders/ui/view/orders_screen.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view/suplliers_screen.dart';
import 'package:trade_mate/screens/widgets/container_text_icon.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../auth/login/data/model/user_login_model.dart';
import '../../../../../widgets/add_product_text_field.dart';
import '../../../../../widgets/container_icon_txt.dart';
import '../../../bill/ui/view/add_bill_screen.dart';
import '../../../bill/ui/view/bill_screen.dart';
import '../../../cutomers/ui/view/customers_screen.dart';
import '../../../stock/ui/view/stock_screen.dart';
import '../../domain/home_tab_di.dart';

class HomeTab extends StatelessWidget {

   HomeTab({super.key});

HomeTabViewModel homeTabViewModel=HomeTabViewModel(homeTabUseCases: injectHomeTabUseCases());

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      homeTabViewModel.getBalance(currentUser.uid);
    }
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
             SizedBox(height: 80.h,),

            InkWell(
              onTap: () {
                Navigator.pushNamed(context, BillScreen.routeName);
              },
              child: Container(
                        margin: EdgeInsets.only(left: 10.w, right: 10.w),
                        decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(15.r),
                gradient: LinearGradient(colors: [
                  AppColors.darkPrimaryColor,
                  AppColors.primaryColor
                ])),
                        width: double.infinity,
                        height: 200.h,
                        child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New Bill',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontSize: 35.sp,
                                  color: AppColors.whiteColor),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          'Add new bill',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppColors.whiteColor),
                        ),
                        SizedBox(height: 10.h,),
                        Container(
                            height: 25.h,
                            width: 25.h,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color: AppColors.whiteColor,
                                    width: 2.w),
                                borderRadius:
                                    BorderRadius.circular(8.r)),child: Icon(Icons.arrow_forward,color: AppColors.whiteColor,size: 17.sp,),)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60.r),
                        child: Image.asset(
                          "assets/images/cart.png",
                          fit: BoxFit.cover,
                          height: 120.h,
                          width: 120.w,
                        ),
                      )
                    ],
                  ),
                )
              ],
                        ),
                      ),
            ),
            SizedBox(height: 10.h,),
            Container(
              margin: EdgeInsets.only(left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15.r),
                  ),
              width: double.infinity,
              height: 100.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          // ToDo: purchase
                        },
                        child: ContainerTextIcon(txt: 'Purchase Entry', icn: Icon(Icons.shopping_bag_outlined,color: AppColors.primaryColor,size: 35.sp,))),
                  ),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context,AddProductScreen.routeName);
                        },
                        child: ContainerTextIcon(txt: 'Add Products To Shop', icn: Icon(Icons.add_shopping_cart,color: AppColors.primaryColor,size: 35.sp,))),
                  ),
                ],
              ),

            ),
            SizedBox(height: 10.h,),
            BlocListener<HomeTabViewModel, HomeTabStates>(
              bloc: homeTabViewModel,
              listener: (context, state) {

                if (state is GetUserBalanceSuccessState){
                  homeTabViewModel.myBalance=state.balance;
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: 15.w, right: 15.w),
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                width: double.infinity,
                height: 80.h,
                child: InkWell(
                    onTap: () {
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
                                  children: [
                                    Text(
                                      "Enter Your Balance",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                          color: AppColors
                                              .darkPrimaryColor,fontSize: 27.sp),
                                      textAlign: TextAlign.center,
                                    ),
                                    Spacer(),
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
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Form(
                                  key:homeTabViewModel.formKey,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Balance: ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                    color: AppColors
                                                        .darkPrimaryColor,fontSize: 25.sp),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(width: 5.w,),
                                            Expanded(
                                              flex:2,
                                              child: AddProductTextField(

                                                controller:homeTabViewModel. balance,
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
                                                    return 'please enter your balance';
                                                  }
                                                  return null;
                                                },
                                                isEnabled: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                                SizedBox(height: 10.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElevatedButton(

                                      onPressed: () {
                                        homeTabViewModel.formKey.currentState!.save();
                                        if (homeTabViewModel.formKey.currentState!.validate()) {
                                          final currentUser = FirebaseAuth.instance.currentUser;

                                          if (currentUser != null) {
                                            final userId = currentUser.uid;
                                            final newBalance = double.tryParse(homeTabViewModel.balance.text) ?? 0.0;
                                             homeTabViewModel.updateBalance(userId, newBalance);
homeTabViewModel.getBalance(currentUser.uid);
                                            Navigator.pop(context);

                                          } else {
                                            print("User not logged in");
                                          }
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
                                            color: AppColors.whiteColor, fontSize: 25.sp),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),

                          );
                        },
                      );


                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.w,right: 10.w),
                      child: Row(
                        children: [
                          Image.asset("assets/images/mony_preview_rev_1.png",),
                          Text(
                            ' My Balance ',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: AppColors.coffeColor),
                          ),
                          StreamBuilder(
                            stream: homeTabViewModel.balanceee.stream,
                            builder: (context, snapshot) {
                              return Expanded(
                                child: Text(
                                  " ${homeTabViewModel.myBalance.toStringAsFixed(2)} EGP",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(color: AppColors.coffeColor,overflow: TextOverflow.ellipsis),
                                ),
                              );
                            },

                          ),


                        ],
                      ),
                    ),),

              ),
            ),
            SizedBox(height: 20.h,),
            Wrap(
              spacing: 20.w,
              children: [
                InkWell(onTap: () {
                  Navigator.pushNamed(context, StockScreen.routeName);
                  print("stock clicked");
                },
                    child: ContainerIconTxt(txt: 'Stock ', icn: Icon(Icons.inventory_2_outlined,color: AppColors.primaryColor,size: 25.sp,))),
                InkWell(onTap: () {
                  Navigator.pushNamed(context, SuplliersScreen.routeName);
                },child: ContainerIconTxt(txt: 'Suppliers ', icn: Icon(Icons.local_shipping_outlined,color: AppColors.primaryColor,size: 25.sp,),)),
                InkWell(onTap: () {
                  Navigator.pushNamed(context, CustomersScreen.routeName);
                },child: ContainerIconTxt(txt: 'Customers ', icn: Icon(Icons.people_outline,color: AppColors.primaryColor,size: 25.sp,),)),
                InkWell(onTap: () {
                  Navigator.pushNamed(context, OrdersScreen.routeName);
                },child: ContainerIconTxt(txt: 'Orders ', icn: Icon(Icons.fact_check_outlined,color: AppColors.primaryColor,size: 25.sp,))),

              ],
            ),


          ],
        ),
      ),
    );
  }
}
