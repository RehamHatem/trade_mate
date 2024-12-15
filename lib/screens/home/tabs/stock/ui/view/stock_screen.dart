import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/utils/app_colors.dart';
import 'package:trade_mate/utils/text_field_item.dart';

class StockScreen extends StatelessWidget {
  static const String routeName="stock";
   StockScreen({super.key});
  var search= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.darkPrimaryColor,
        title: Text(
        'Stock',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: AppColors.whiteColor),
      ),),
      body: Padding(
        padding:  EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h,),
        child: Column(
          children: [
            TextFieldItem(controller: search,hintText: "Search in stock ",suffixIcon: Icon(Icons.search,),),

          ],
        ),
      ),
    );
  }
}
