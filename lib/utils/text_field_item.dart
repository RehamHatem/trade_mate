import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class TextFieldItem extends StatelessWidget {
  String? fieldName;
  String hintText;
  Widget? suffixIcon;
  bool isObscure;
   Function(String)? change;
  var keyboardType;
  String? Function(String?)? validator;
  TextEditingController controller;

  TextFieldItem(
      {
        this.fieldName,
        required this.hintText,
        this.suffixIcon,
        this.isObscure = false,
        this.validator,
        this.change,
        required this.controller,
        this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

       fieldName!=null ?Text(
          fieldName!,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 18.sp,color: AppColors.darkPrimaryColor),
          textAlign: TextAlign.start,
        ): SizedBox(),
        Padding(
          padding: EdgeInsets.only(top: 15.h, bottom: 24.h),
          child: TextFormField(
            decoration: InputDecoration(
                fillColor: AppColors.whiteColor,
                filled: true,

                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  borderSide: BorderSide(color: AppColors.greyColor),),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(15.r)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r)),
                hintText: hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColors.greyColor),
                suffixIcon: suffixIcon),
            style: const TextStyle(color: AppColors.blackColor),

            validator: validator,
            controller: controller,
            obscureText: isObscure,
            keyboardType: keyboardType,
            onChanged: change,
          ),
        )
      ],
    );
  }
}