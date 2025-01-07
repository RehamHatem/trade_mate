import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../widgets/add_product_text_field.dart';

class InBillScreen extends StatelessWidget {
   InBillScreen({super.key});
var formKey=GlobalKey<FormState>();
var productController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(

          margin:
          EdgeInsets.only(top: 25.h, right: 10.w, left: 10.w, bottom: 25.h),
          padding: EdgeInsets.only(
            right: 20.w, left: 20.w, ),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.primaryColor),
          ),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(

                children: [
                  SizedBox(
                    height: 35.h,
                  ),
                  Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15.r),
                          child: Image.asset("assets/images/product_preview_rev_1.png",width: 100.w,height: 100.h,fit: BoxFit.cover,)),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(
                        flex: 2,
                        child: AddProductTextField(
                          controller: productController,
                          fieldName: "Product",
                          hintText: "ex: USB-C",
                          isDropdown: true,

                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'please choose a product';
                            }
                            return null;
                          },
                          isEnabled: true,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      // Expanded(
                      //   child: AddProductTextField(
                      //     hintText: "1.0",
                      //     controller:viewModel.productQuantity,
                      //     fieldName: "Quantity",
                      //     isEnabled: true,
                      //     keyboardType: TextInputType.number,
                      //     validator: (value) {
                      //       if (value == null || value.trim().isEmpty  ) {
                      //         return 'please enter product quantity';
                      //       }
                      //       return null;
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 25.h,
                  // ),
                  // AddProductTextField(
                  //   fieldName: "Category",
                  //   hintText: "select category",
                  //   isEnabled: true,
                  //   isDropdown: true,
                  //   controller: viewModel.productCat,
                  //   validator: (value) {
                  //     if(value==null|| viewModel.productCat.text.isEmpty){
                  //       viewModel.productCat.text = value ?? "";
                  //       return("please select a category");
                  //     }
                  //     return null;
                  //   },
                  //   dropdownItems: ["cat1", "cat2", "cat3", "cat4", "cat5"],
                  //   onChanged: (value) {
                  //     viewModel.productCat.text = value ?? "";
                  //     print("Selected Category: $value");
                  //   },
                  //   // dropdownValue: "cat1",
                  // ),
                  // SizedBox(
                  //   height: 25.h,
                  // ),
                  // BlocListener(
                  //   bloc: viewModel.supplierViewModel,
                  //   listener: (context, state) {
                  //     if (state is GetSupplierSuccessState){
                  //       setState(() {
                  //         viewModel.suppliers=state.entity;
                  //       });
                  //
                  //       print(viewModel.suppliers);
                  //     }
                  //   },
                  //   child: AddProductTextField(
                  //     fieldName: "Supplier",
                  //     hintText: "select supplier",
                  //     isEnabled: true,
                  //     isDropdown: true,
                  //     controller: viewModel.productSup,
                  //     validator: (value) {
                  //       if(value==null|| viewModel.productSup.text.isEmpty ){
                  //         viewModel.productCat.text = value ?? "";
                  //         return("please select a supplier");
                  //       }
                  //
                  //     },
                  //     dropdownItems: viewModel.suppliers.map((supplier) => supplier.name,).toList(),
                  //     onChanged: (value) {
                  //       viewModel.productSup.text = value ?? "";
                  //       print("Selected Supplier: $value");
                  //     },
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 25.h,
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //         child: AddProductTextField(
                  //           fieldName: "Price",
                  //           hintText: "for one item",
                  //           controller: viewModel.productPrice,
                  //           isEnabled: true,
                  //           validator: (value) {
                  //             if (value == null || value.trim().isEmpty) {
                  //               return 'please enter product name';
                  //             }
                  //             return null;
                  //           },
                  //           keyboardType: TextInputType.number,
                  //           suffix: Text(
                  //             "EGP",
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .titleMedium!
                  //                 .copyWith(
                  //                 color: AppColors.primaryColor,
                  //                 fontSize: 16.sp),
                  //           ),
                  //         )),
                  //     SizedBox(
                  //       width: 5.w,
                  //     ),
                  //     Expanded(
                  //         child: AddProductTextField(
                  //           controller: viewModel.productTotal,
                  //           fieldName: "Total",
                  //           isEnabled: false,
                  //           hintText: "${viewModel.total.toStringAsFixed(2)} EGP",
                  //         )),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 25.h,
                  // ),
                  // AddProductTextField(
                  //   fieldName: "Notes",
                  //   hintText: "Leave note about the product ...",
                  //   isEnabled: true,
                  //   controller:viewModel. productNotes,
                  // ),
                  // SizedBox(
                  //   height: 50.h,
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: ElevatedButton(
                  //           onPressed: () {
                  //             clearForm();
                  //
                  //           },
                  //
                  //           style: ButtonStyle(
                  //               padding: WidgetStatePropertyAll(EdgeInsets.only(bottom: 5.h,top: 5.h)),
                  //
                  //               backgroundColor: WidgetStatePropertyAll(
                  //                   AppColors.primaryColor),
                  //               shape: WidgetStatePropertyAll(
                  //                 RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(15.r)),
                  //               )),
                  //           child: Text(
                  //             "Clear",
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .titleMedium!
                  //                 .copyWith(
                  //                 color: AppColors.whiteColor,
                  //                 fontSize: 30.sp),
                  //           )),
                  //     ),
                  //     SizedBox(width: 10.w,),
                  //     Expanded(
                  //       child: ElevatedButton(
                  //         onPressed: () {
                  //           viewModel.formKey.currentState!.save();
                  //           print("Product Name: ${viewModel.productName.text}");
                  //           print("Product Quantity: ${viewModel.productQuantity.text}");
                  //           print("Product Price: ${viewModel.productPrice.text}");
                  //           print("Product Category: ${viewModel.productCat.text}");
                  //           print("Product Supplier: ${viewModel.productSup.text}");
                  //           if (viewModel.formKey.currentState!.validate()){
                  //             ProductEntity product=ProductEntity(name: viewModel.productName.text,
                  //                 quantity: double.tryParse(viewModel.productQuantity.text)??0.0,
                  //                 price: double.tryParse(viewModel.productPrice.text)??0.0,
                  //                 total: viewModel.total,
                  //                 notes: viewModel.productNotes.text==""?"N/A":viewModel.productNotes.text,
                  //                 supplier: viewModel.productSup.text==""?"N/A":viewModel.productSup.text,
                  //                 category: viewModel.productCat.text==""?"N/A":viewModel.productCat.text,
                  //                 date: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
                  //                 userId: FirebaseAuth.instance.currentUser!.uid);
                  //             viewModel.addProduct(product);
                  //           }
                  //
                  //         },
                  //         style: ButtonStyle(
                  //             padding: WidgetStatePropertyAll(EdgeInsets.only(bottom: 5.h,top: 5.h)),
                  //             backgroundColor:
                  //             WidgetStatePropertyAll(AppColors.greenColor),
                  //             shape: WidgetStatePropertyAll(
                  //               RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(15.r)),
                  //             )),
                  //         child: Text(
                  //           "Save",
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .titleMedium!
                  //               .copyWith(
                  //               color: AppColors.whiteColor, fontSize: 30.sp),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 35.h,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
