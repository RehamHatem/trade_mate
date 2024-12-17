import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/add_product/ui/view/add_product_screen.dart';
import 'package:trade_mate/screens/home/tabs/customers/ui/view/customers_screen.dart';
import 'package:trade_mate/screens/home/tabs/orders/ui/view/orders_screen.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view/suplliers_screen.dart';
import 'package:trade_mate/screens/widgets/container_text_icon.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../widgets/container_icon_txt.dart';
import '../../../stock/ui/view/stock_screen.dart';

class HomeTab extends StatelessWidget {

  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(child: SizedBox()),
        InkWell(
          onTap: () {
            //ToDo : add bill
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
                      //ToDo: add products
                      Navigator.pushNamed(context,AddProductScreen. routeName);
                    },
                    child: ContainerTextIcon(txt: 'Add Products To Shop', icn: Icon(Icons.add_shopping_cart,color: AppColors.primaryColor,size: 35.sp,))),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h,),
        Wrap(
          spacing: 20.w,
          children: [
            InkWell(onTap: () {
              Navigator.pushNamed(context, StockScreen.routeName);
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
        )
      ],
    );
  }
}
