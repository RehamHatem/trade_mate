import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/app_colors.dart';
import 'in_bill_screen.dart';
import 'out_bill_screen.dart';

class AddBillScreen extends StatelessWidget {
  static const String routeName="addBill";
  const AddBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.whiteColor),
          bottom: TabBar(
            indicatorColor: Colors.cyan,
            unselectedLabelStyle: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.greyColor,fontSize: 20.sp,fontWeight:FontWeight.w400),

            labelStyle: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.lightGreyColor,fontSize: 20.sp,fontWeight:FontWeight.w400),

            tabs: [
              Tab(text: "In Bill",),
              Tab(text: "Out Bill"),

            ],
          ),
          backgroundColor: AppColors.darkPrimaryColor,
          title: Text(
            'New Bill',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.whiteColor),
          ),
          toolbarHeight: 100.h,

        ),
        backgroundColor: AppColors.lightGreyColor,
        resizeToAvoidBottomInset: true,

        body: TabBarView(
          children: [
            InBillScreen(),
            OutBillScreen()
          ],
        ),
      ),
    );
  }
}
