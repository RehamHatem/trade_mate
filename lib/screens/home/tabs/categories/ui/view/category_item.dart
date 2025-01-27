import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:trade_mate/utils/app_colors.dart';

import '../../../../../widgets/add_product_text_field.dart';
import '../../domain/category_di.dart';
import '../../domain/entity/category_entity.dart';
import '../view_model/categories_view_model.dart';

class CategoryItem extends StatefulWidget {
  CategoryEntity entity;
  int index;
  Function(String) delete;
  Function(String,CategoryEntity) update;

  CategoryItem(
      {required this.index,
      super.key,
        required this.update,
      required this.entity,
      required this.delete});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  var categoryNameController=TextEditingController();
  late Color selected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryNameController.text=widget.entity.name;
    selected=widget.entity.color;

  }

  @override
  Widget build(BuildContext context) {
    return

        Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          decoration: BoxDecoration(
              color: widget.entity.color,

              border:widget.entity.color==Colors.transparent? Border.all(color: AppColors.darkPrimaryColor):null,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.r),
                  topRight: Radius.circular(15.r),
                  bottomLeft: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r))),
          child: Center(
            child: Text(
              widget.entity.name,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color:widget.entity.color==Colors.transparent?AppColors.primaryColor: AppColors.whiteColor, fontSize: 30.sp),
            ),
          ),
        ),
        Positioned(
          bottom: 150.h,
          left: 150.w,
          child: IconButton(
            onPressed: () {
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
                              widget.delete(widget.entity.id);
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
                          "Do you want to delete ${widget.entity.name}?",
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
            },
            color:widget.entity.color==Colors.transparent?AppColors.greyColor: AppColors.whiteColor.withOpacity(0.5),
            icon: Icon(Icons.cancel),
          ),
        ),
        Positioned(
          top:20.h,
          left: 150.w,

          child: IconButton(
            onPressed: () {
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
                              "Edit Category",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                  color: AppColors
                                      .darkPrimaryColor,fontSize:25.sp),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                "Category name : ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                    color: AppColors
                                        .darkPrimaryColor,fontSize:20.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(width:2.w,),
                            Expanded(

                              child: AddProductTextField(

                                controller:categoryNameController,
                                hintText: "ex: Beans",
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'please enter category name';
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select color :',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                  color: AppColors.darkPrimaryColor, fontSize: 20.sp
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ColorPicker(
                                  pickersEnabled: <ColorPickerType,bool>{
                                    ColorPickerType.wheel:false,
                                    ColorPickerType.primary:true,
                                    ColorPickerType.accent:false,
                                    ColorPickerType.custom:false,
                                    ColorPickerType.both:false,
                                    ColorPickerType.bw:false,
                                    ColorPickerType.customSecondary:true,
                                  },
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,

                                  padding: EdgeInsets.only(top: 5.h,left: 5.w),
                                  wheelDiameter: 100,
                                  wheelWidth: 5,
                                  color: selected,
                                  onColorChanged: (Color color) =>
                                      setState(() => selected = color),

                                  width: 30.w,
                                  height: 30.h,
                                  borderRadius: 25.r,

                                ),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(

                              onPressed: () {

                                if (categoryNameController.text.isNotEmpty) {
                                  CategoryEntity category=CategoryEntity(id: "",
                                      name: categoryNameController.text,
                                      color: selected??Colors.transparent,
                                      date: widget.entity.date,
                                      userId: FirebaseAuth.instance.currentUser!.uid);

                                  widget.update(widget.entity.id,category);


                                  Navigator.pop(context);
                                }


                              },
                              style: ButtonStyle(
                                  padding: WidgetStatePropertyAll(EdgeInsets.only(bottom: 5.h,top: 5.h,right: 8.w,left: 8.w)),
                                  backgroundColor:
                                  WidgetStatePropertyAll(AppColors.darkPrimaryColor),
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.r)),
                                  )),
                              child: Text(
                                "Save changes",
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
            color: Colors.transparent,
            icon: Icon(
              Icons.edit,
              color: AppColors.greyColor,
              size: 15,
            ),
          ),
        ),
      ],
    );
  }
}
//   Card(
//   color: AppColors.lightGreyColor.withOpacity(.9),
//   elevation: 3,
//   shadowColor: AppColors.darkPrimaryColor.withOpacity(.5),
//
//   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
//   child: Center(
//     child: Text(
//       "category",
//       style: Theme.of(context)
//           .textTheme
//           .titleMedium!
//           .copyWith(
//           color: AppColors.darkPrimaryColor, fontSize: 25.sp),
//     ),
//   ),
// );