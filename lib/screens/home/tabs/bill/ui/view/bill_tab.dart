import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/bill/ui/view/add_bill_screen.dart';
import 'package:trade_mate/screens/home/tabs/bill/ui/view/bill_product_item.dart';
import 'package:trade_mate/screens/widgets/add_product_text_field.dart';
import 'package:trade_mate/utils/app_colors.dart';

import '../../../../../../utils/text_field_item.dart';
enum BillType { inBill, outBill }
class BillTab extends StatefulWidget {
  final String billName;

   BillTab({Key? key, required this.billName}) : super(key: key);

  @override
  State<BillTab> createState() => _BillTabState();
}

class _BillTabState extends State<BillTab> {
  BillType? bill = BillType.inBill;
  int selectedIndex = 0;

TextEditingController paymentType=TextEditingController();
TextEditingController searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w,right: 10.w),
      child: Column(
        children: [
          Container(
            height: 110.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Radio<BillType>(
                          value: BillType.inBill,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          groupValue:bill,
                          fillColor: bill==BillType.inBill?MaterialStateProperty.all(AppColors.greenColor):MaterialStateProperty.all(AppColors.blackColor),
                          onChanged: (BillType? newValue) {
                            setState(() {
                              bill = newValue;
                            });
                          },
                        ),
                        Text(
                          "In Bill",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.darkPrimaryColor,fontSize: 16.sp
                          ),
                        ),
                        Radio<BillType>(
                          value: BillType.outBill,
                          groupValue:bill,

                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          fillColor: bill==BillType.outBill?MaterialStateProperty.all(AppColors.greenColor):MaterialStateProperty.all(AppColors.blackColor),

                          onChanged: (BillType? newValue) {
                            setState(() {
                              bill = newValue;
                            });
                          },
                        ),
                        Text(
                          "Out Bill",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.darkPrimaryColor,fontSize: 16.sp
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: 210.w,
                      height: 30.h,
                      margin: EdgeInsets.only(bottom: 5.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Colors.transparent,
                        border: Border.all(color: AppColors.darkPrimaryColor),
                      ),
                      child: DropdownButton<String>(
                        style:  Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                            fontSize:18.sp,
                            color: AppColors.primaryColor),
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(15.r),
                        alignment: Alignment.center,
                        dropdownColor: AppColors.lightGreyColor,
                        underline: Container(color: Colors.transparent,),
                        padding: EdgeInsets.only(
                            left: 10.h,right: 10.h
                        ),
                        value: "Cash",
                        items: ["Cash", "Card"]
                            .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ))
                            .toList(),
                        onChanged: (value) {},
                      ),
                    ),

                    Container(
                      height: 30.h,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(color: AppColors.darkPrimaryColor,width: 2.w)
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = 0;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 15.w,right: 15.w),

                              decoration: BoxDecoration(
                                color: selectedIndex == 0
                                    ? AppColors.darkPrimaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.r),
                                  bottomRight: Radius.circular(25.r),
                                  topRight:Radius.circular(25.r) ,
                                  bottomLeft: Radius.circular(25.r),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Retail",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: 16.sp,
                                  color: selectedIndex == 0
                                      ? Colors.white
                                      : AppColors.darkPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = 1;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 15.w,right: 15.w),
                              decoration: BoxDecoration(
                                color: selectedIndex == 1
                                    ? AppColors.darkPrimaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.r),
                                  bottomRight: Radius.circular(25.r),
                                  topRight:Radius.circular(25.r) ,
                                  bottomLeft: Radius.circular(25.r),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Wholesale",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: 16.sp,
                                  color: selectedIndex == 1
                                      ? Colors.white
                                      : AppColors.darkPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.w),
                  width: 180.w,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [AppColors.darkPrimaryColor,AppColors.primaryColor]),

                  ),
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                            fontSize:18.sp,
                            color: AppColors.whiteColor),
                      ),
                      Text(
                        "200.0 EGP",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                            fontSize:20.sp,
                            color: AppColors.whiteColor),
                      ),
                      Text(
                        "+ tab to add Discount",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                            fontSize:14.sp,
                            color: AppColors.whiteColor),
                      ),
                    ],
                  ),
                ),



              ],
            ),
          ),
          SizedBox(height: 20.h,),
          BillProductItem(),



          Spacer(),
          Padding(
            padding:  EdgeInsets.only(left: 8.w,right: 8.w,bottom: 10.h),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AddBillScreen.routeName);

                      },

                      style: ButtonStyle(
                          elevation: WidgetStatePropertyAll(5),

                          shadowColor: WidgetStatePropertyAll(AppColors.coffeColor),
                          padding: WidgetStatePropertyAll(EdgeInsets.only(bottom: 10.h,top: 10.h,right: 15.w,left: 15.w)),

                          backgroundColor: WidgetStatePropertyAll(
                              AppColors.coffeColor),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r)),
                          )),
                      child: Text(
                        "Quick add",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                            color: AppColors.whiteColor,
                            fontSize: 20.sp),
                      )),
                ),
                SizedBox(width: 20.w,),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                      onPressed: () {
                        // clearForm();

                      },

                      style: ButtonStyle(
                        elevation: WidgetStatePropertyAll(5),

                          shadowColor: WidgetStatePropertyAll(AppColors.greenColor),
                          padding: WidgetStatePropertyAll(EdgeInsets.only(bottom: 10.h,top: 10.h)),

                          backgroundColor: WidgetStatePropertyAll(
                              AppColors.greenColor),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r)),
                          )),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Create bill",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                color: AppColors.whiteColor,
                                fontSize: 20.sp),
                          ),
                          SizedBox(width: 15.w,),
                          Icon(Icons.arrow_forward,color: AppColors.whiteColor,)
                        ],
                      )),
                ),
              ],
            ),
          ),
          Container(
              width: double.infinity,
              height: 105.h,
              decoration: BoxDecoration(color: AppColors.darkPrimaryColor),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                ),
                child: TextFieldItem(
                  controller: searchController,
                  // change: (query) {
                  //   stockViewModel.searchProducts(query);
                  // },
                  hintText: "Search name ",
                  suffixIcon: Icon(
                    Icons.search,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}