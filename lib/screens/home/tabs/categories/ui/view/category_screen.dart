import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:trade_mate/screens/home/tabs/categories/domain/entity/category_entity.dart';
import 'package:trade_mate/screens/home/tabs/categories/ui/view_model/categories_view_model.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/dialog_utils.dart';
import '../../../../../../utils/text_field_item.dart';
import '../../../../../widgets/add_product_text_field.dart';
import '../../../../../widgets/container_icon_txt.dart';
import '../../domain/category_di.dart';
import '../view_model/categories_states.dart';
import 'category_item.dart';
import 'category_products.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName="category";
   CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
CategoriesViewModel categoriesViewModel=CategoriesViewModel(categoryUseCases: injectCategoryUseCases());

  @override
  Widget build(BuildContext context) {
    categoriesViewModel.getCategorys();
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.darkPrimaryColor,
        title: Text(
          'Categories',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: AppColors.whiteColor),
        ),
      ),
      body: Column(
        children: [
          Container(
              width: double.infinity,
              height: 110.h,
              decoration: BoxDecoration(color: AppColors.darkPrimaryColor),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                ),
                child: TextFieldItem(
                  controller: categoriesViewModel.searchController,
                  change: (query) {
                    categoriesViewModel.searchCategoryies(query);
                  },
                  hintText: "Search in categories ",
                  suffixIcon: Icon(
                    Icons.search,
                  ),
                ),
              )),
          Expanded(
            child: BlocListener(
              bloc: categoriesViewModel,
              listener: (context, state) {
                if (state is RemoveCategoryLoadingState) {
                  DialogUtils.showLoading(context, "Deleting category...");
                } else if (state is RemoveCategoryErrorState) {
                  DialogUtils.hideLoading(context);
                  DialogUtils.showMessage(context, state.error);
                } else if (state is RemoveCategorySuccessState) {
                  DialogUtils.hideLoading(context);
                  DialogUtils.showMessage(
                      context, "Category deleted successfully",
                      title: "Note");

                }
                else if (state is UpdateCategoryLoadingState) {
                  DialogUtils.showLoading(context, "Updating Category...");
                } else if (state is UpdateCategoryErrorState) {
                  DialogUtils.hideLoading(context);
                  DialogUtils.showMessage(context, state.error);
                } else if (state is UpdateCategorySuccessState) {
                  DialogUtils.hideLoading(context);
                  DialogUtils.showMessage(
                      context, "Category updated successfully",
                      title: "Note");
                }
              },
              child: StreamBuilder<List<CategoryEntity>>(
                stream: categoriesViewModel.categoryStreamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No Categories Found"));
                  }
                  final categories = snapshot.data!;
                  return Padding(
                    padding:  EdgeInsets.only(right: 10.w,left: 10.w,top: 10.h,bottom: 5.h),
                    child: GridView.builder(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, CategoryProducts.routeName,arguments: categories[index]);

                          },
                          child: CategoryItem(
                            entity: categories[index],
                            update: (p0, p1) {
                              categoriesViewModel.updateCategory(p0, p1);
                            },
                            delete: (p0) {
                              categoriesViewModel.deleteCategory(p0);},

                            index: index,
                          ),
                        );
                      },
                      itemCount:categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, mainAxisSpacing: 20.h, crossAxisSpacing: 20.w),
                    ),
                  );
                },
              ),
            ),
          ),


        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 16.w, bottom: 64.h),
        child: FloatingActionButton(
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
                            "Enter Category",
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

                              controller:categoriesViewModel.categoryNameController,
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
                                color: categoriesViewModel.selectedColor,
                                onColorChanged: (Color color) =>
                                    setState(() => categoriesViewModel.selectedColor = color),

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

                              if (categoriesViewModel.categoryNameController.text.isNotEmpty) {
                                CategoryEntity category=CategoryEntity(id: "",
                                    name: categoriesViewModel.categoryNameController.text,
                                    color: categoriesViewModel.selectedColor,
                                    date: DateFormat.yMd().add_jm().format(DateTime.now()),
                                    userId: FirebaseAuth.instance.currentUser!.uid);

                                categoriesViewModel.addCategory(category);
                                categoriesViewModel.selectedColor=Colors.transparent;
                                categoriesViewModel.categoryNameController.clear();

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
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
          child: Icon(
            Icons.add,
            size: 35.sp,
            color: AppColors.whiteColor,
          ),
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
        ),
      ),

    );
  }
}
