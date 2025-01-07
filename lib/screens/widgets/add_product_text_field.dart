import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';



class AddProductTextField extends StatelessWidget {
  String fieldName;
  String hintText;
  Widget? suffix;
  bool isEnabled;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  TextEditingController controller;
  bool isDropdown;
   List<String>? dropdownItems;
  String? dropdownValue;
 void Function(String?)? onChanged;
  AddProductTextField(
      {
       this.fieldName="",
        required this.hintText,
        this.suffix,
        this.isEnabled=true ,
        this.validator,
         required this.controller,
        this.keyboardType,
        this.isDropdown = false,
        this.dropdownItems,
        this.dropdownValue,
        this.onChanged,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        fieldName==""?SizedBox.shrink():Text(
          fieldName,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(
              color: AppColors.primaryColor,
              fontSize: 16.sp),
        ),
        isDropdown
            ? DropdownButtonFormField<String>(

          dropdownColor: AppColors.lightGreyColor,
          menuMaxHeight: 200.h,
          isExpanded: true,


          style: Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(
    color: AppColors.primaryColor,
    fontSize: 20.sp),
          value: dropdownValue,
          items: dropdownItems
              ?.map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          ))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: AppColors.greyColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
            focusedErrorBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide:
              BorderSide(color: AppColors.primaryColor),
            ) ,
            errorBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
            hintText: hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.greyColor),
          ),
        )
            :
        TextFormField(
  keyboardType: keyboardType,


controller: controller,
          decoration: InputDecoration(
            // fillColor: Color(0xfffcfafa),
            // filled: true,
            enabled: isEnabled,
            errorStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(
                color: AppColors.redColor,
                fontSize: 12.sp),

suffix: suffix,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide:
              BorderSide(color: AppColors.greyColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide:
              BorderSide(color: AppColors.primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(15.r)),
            focusedErrorBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
    borderSide:
    BorderSide(color: AppColors.primaryColor),
    ) ,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide:
              BorderSide(color: AppColors.primaryColor),
            ),
            hintText:hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.greyColor),
          ),
          style:
          const TextStyle(color: AppColors.blackColor),
          validator: validator,
        ),
      ],
    );
  }
}