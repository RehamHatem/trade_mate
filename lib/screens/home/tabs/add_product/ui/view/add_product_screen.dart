import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/utils/app_colors.dart';

import '../../../../../../utils/text_field_item.dart';
import '../../../../../widgets/add_product_text_field.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "addpro";

  AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var formKey = GlobalKey<FormState>();

  var productName = TextEditingController();

  var productQuantity = TextEditingController();

  var productPrice = TextEditingController();
  var productNotes = TextEditingController();
  double total = 0.0; // Variable to store total

  @override
  void initState() {
    super.initState();
    productQuantity.addListener(calculateTotal);
    productPrice.addListener(calculateTotal);
  }

  @override
  void dispose() {
    productQuantity.dispose();
    productPrice.dispose();
    super.dispose();
  }

  void calculateTotal() {
    double quantity = double.tryParse(productQuantity.text) ?? 0.0;
    double price = double.tryParse(productPrice.text) ?? 0.0;
    setState(() {
      total = price * quantity; // Update the total
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.darkPrimaryColor,
        title: Text(
          'Add Product',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: AppColors.whiteColor),
        ),
      ),
      body: Container(
height: double.infinity,
        margin:
            EdgeInsets.only(top: 20.h, right: 10.w, left: 10.w, bottom: 20.h),
        padding: EdgeInsets.only(
            right: 20.w, left: 20.w, ),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(

                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: AddProductTextField(
                          controller: productName,
                          fieldName: "Product Name",
                          hintText: "ex: USB-C",
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'please enter product name';
                            }
                            return null;
                          },
                          isEnabled: true,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(
                        child: AddProductTextField(
                          hintText: "1.0",
                          controller: productQuantity,
                          fieldName: "Quantity",
                          isEnabled: true,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'please enter product quantity';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  AddProductTextField(
                    fieldName: "Category",
                    hintText: "select category",
                    isEnabled: true,
                    isDropdown: true,
                    dropdownItems: ["cat1", "cat2", "cat3", "cat4", "cat5"],
                    onChanged: (value) {
                      print("Selected Category: $value");
                    },
                    // dropdownValue: "cat1",
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  AddProductTextField(
                    fieldName: "Supplier",
                    hintText: "select supplier",
                    isEnabled: true,
                    isDropdown: true,
                    dropdownItems: ["sup1", "sup2", "sup3", "sup4", "sup5"],
                    onChanged: (value) {
                      print("Selected Supplier: $value");
                    },
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: AddProductTextField(
                        fieldName: "Price",
                        hintText: "for one item",
                        controller: productPrice,
                        isEnabled: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'please enter product name';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        suffix: Text(
                          "EGP",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: AppColors.primaryColor,
                                  fontSize: 16.sp),
                        ),
                      )),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(
                          child: AddProductTextField(
                        fieldName: "Total",
                        isEnabled: false,
                        hintText: "${total} EGP",
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  AddProductTextField(
                    fieldName: "Notes",
                    hintText: "Leave note about the product ...",
                    isEnabled: true,
                    controller: productNotes,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {},

                            style: ButtonStyle(
                                padding: WidgetStatePropertyAll(EdgeInsets.only(bottom: 5.h,top: 5.h)),

                                backgroundColor: WidgetStatePropertyAll(
                                    AppColors.primaryColor),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.r)),
                                )),
                            child: Text(
                              "Clear",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: AppColors.whiteColor,
                                      fontSize: 30.sp),
                            )),
                      ),
                      SizedBox(width: 10.w,),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(EdgeInsets.only(bottom: 5.h,top: 5.h)),
                              backgroundColor:
                                  WidgetStatePropertyAll(AppColors.greenColor),
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
                                    color: AppColors.whiteColor, fontSize: 30.sp),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
