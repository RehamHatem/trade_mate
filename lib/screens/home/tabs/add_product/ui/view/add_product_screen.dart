import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:trade_mate/screens/home/home.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';
import 'package:trade_mate/screens/home/tabs/add_product/ui/view_model/add_product_states.dart';
import 'package:trade_mate/screens/home/tabs/home_tab/ui/view/home_tab.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/supplier_di.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view_model/supplier_states.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view_model/supplier_view_model.dart';
import 'package:trade_mate/utils/app_colors.dart';

import '../../../../../../utils/dialog_utils.dart';
import '../../../../../../utils/text_field_item.dart';
import '../../../../../widgets/add_product_text_field.dart';
import '../../domain/add_product_di.dart';
import '../view_model/add_product_view_model.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "addPro";

  AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late AddProductViewModel viewModel;
  @override
  void initState() {
    super.initState();
     viewModel=AddProductViewModel(addProductUseCase:injectAddProductUseCase() );
    viewModel.productQuantity.addListener(calculateTotal);
    viewModel.productPrice.addListener(calculateTotal);
    viewModel.supplierViewModel.getSuppliers();


  }

  @override
  void dispose() {
    viewModel.productQuantity.dispose();
    viewModel.productPrice.dispose();
    super.dispose();
  }

  void calculateTotal() {
    double quantity = double.tryParse(viewModel.productQuantity.text) ?? 0.0;
    double price = double.tryParse(viewModel.productPrice.text) ?? 0.0;

    setState(() {
      viewModel.total = price * quantity;
      print('Updated Total: ${viewModel.total}');
    });

  }

  void clearForm() {
    viewModel.formKey.currentState?.reset();
    viewModel.productName.clear();
    viewModel.productQuantity.clear();
    viewModel.productPrice.clear();
    viewModel.productNotes.clear();
    viewModel.productCat.clear();
    viewModel.productSup.clear();
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<AddProductViewModel, AddProductStates>(
          bloc: viewModel..supplierViewModel.suppliers,
          listener: (context, state) {
            if (state is AddProductLoadingState){
              return DialogUtils.showLoading(context, "Loading...");
            }
            else if (state is AddProductErrorState){
              DialogUtils.hideLoading(context);
              return DialogUtils.showMessage(context, state.error.errorMsg.toString(),title: "Error");

            }
            else if (state  is AddProductSuccessState){
              DialogUtils.hideLoading(context);

              showDialog(barrierDismissible: false, context: context, builder: (context) {
                return AlertDialog(

                  actions: [Row(
                    children: [
                      Icon(Icons.settings_backup_restore_rounded,size: 20.sp,color: AppColors.primaryColor
                        ,),
                      SizedBox(width: 5.w,),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, Home.routeName);
                        },
                        child: Text("back to home",style:
                        Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 16.sp,
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline,decorationColor: AppColors.darkPrimaryColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(onPressed: () {
                        Navigator.pop(context);
                        clearForm();
                      },

                        child: Text("OK",style:
                        Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 16.sp,
                          color: AppColors.whiteColor,
                        ),
                          textAlign: TextAlign.center,
                        ),
                        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),shape:
                        WidgetStatePropertyAll(RoundedRectangleBorder
                          (borderRadius: BorderRadius.circular(15.r),
                        ))

                        ),),
                    ],
                  )],backgroundColor: AppColors.lightGreyColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r),side: BorderSide(color: AppColors.primaryColor)),
                  title: Text("${state.productEntity.name}",style:
                  Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: AppColors.darkPrimaryColor),
                    textAlign: TextAlign.center,
                  ),

                  alignment: Alignment.center,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(onPressed: () {

                      },

                          child: Icon(Icons.check,size: 30.sp,color: AppColors.whiteColor,),
                          style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.greenColor),shape:
                          WidgetStatePropertyAll(RoundedRectangleBorder
                            (borderRadius: BorderRadius.circular(50.r),
                          )))

                      ),
                      SizedBox(height: 10.h,),
                      Text("The product is added successfully",style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ) ;
              },);

            }

          },


      child: Scaffold(
        backgroundColor: AppColors.lightGreyColor,
      resizeToAvoidBottomInset: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.whiteColor),

          backgroundColor: AppColors.darkPrimaryColor,
          title: Text(
            'Add Product To Stock',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.whiteColor),
          ),
          toolbarHeight: 100.h,

        ),
        body: Center(
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
                  key: viewModel.formKey,
                  child: Column(

                    children: [
                      SizedBox(
                        height: 35.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: AddProductTextField(
                              controller: viewModel.productName,
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
                              controller:viewModel.productQuantity,
                              fieldName: "Quantity",
                              isEnabled: true,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty  ) {
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
                        controller: viewModel.productCat,
                        validator: (value) {
                          if(value==null|| viewModel.productCat.text.isEmpty){
                            viewModel.productCat.text = value ?? "";
                            return("please select a category");
                          }
                          return null;
                        },
                        dropdownItems: ["cat1", "cat2", "cat3", "cat4", "cat5"],
                        onChanged: (value) {
                          viewModel.productCat.text = value ?? "";
                          print("Selected Category: $value");
                        },
                        // dropdownValue: "cat1",
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      BlocListener(
                        bloc: viewModel.supplierViewModel,
                        listener: (context, state) {
                          if (state is GetSupplierSuccessState){
                            setState(() {
                              viewModel.suppliers=state.entity;
                            });

                            print(viewModel.suppliers);
                          }
                        },
                        child: AddProductTextField(
                          fieldName: "Supplier",
                          hintText: "select supplier",
                          isEnabled: true,
                          isDropdown: true,
                          controller: viewModel.productSup,
                          validator: (value) {
                            if(value==null|| viewModel.productSup.text.isEmpty ){
                              viewModel.productCat.text = value ?? "";
                              return("please select a supplier");
                            }

                          },
                          dropdownItems: viewModel.suppliers.map((supplier) => supplier.name,).toList(),
                          onChanged: (value) {
                            viewModel.productSup.text = value ?? "";
                            print("Selected Supplier: $value");
                          },
                        ),
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
                            controller: viewModel.productPrice,
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
                                controller: viewModel.productTotal,
                            fieldName: "Total",
                            isEnabled: false,
                            hintText: "${viewModel.total.toStringAsFixed(2)} EGP",
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
                        controller:viewModel. productNotes,
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  clearForm();

                                },

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
                              onPressed: () {
                                viewModel.formKey.currentState!.save();
                                print("Product Name: ${viewModel.productName.text}");
                                print("Product Quantity: ${viewModel.productQuantity.text}");
                                print("Product Price: ${viewModel.productPrice.text}");
                                print("Product Category: ${viewModel.productCat.text}");
                                print("Product Supplier: ${viewModel.productSup.text}");
                                if (viewModel.formKey.currentState!.validate()){
                                  ProductEntity product=ProductEntity(name: viewModel.productName.text,
                                      quantity: double.tryParse(viewModel.productQuantity.text)??0.0,
                                      price: double.tryParse(viewModel.productPrice.text)??0.0,
                                      total: viewModel.total,
                                      notes: viewModel.productNotes.text==""?"N/A":viewModel.productNotes.text,
                                      supplier: viewModel.productSup.text==""?"N/A":viewModel.productSup.text,
                                      category: viewModel.productCat.text==""?"N/A":viewModel.productCat.text,
                                      date: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
                                      userId: FirebaseAuth.instance.currentUser!.uid);
                                  viewModel.addProduct(product);
                                }

                              },
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
                      ),SizedBox(
                        height: 35.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// BlocListener<SupplierViewModel, SupplierStates>(
// bloc: viewModel.supplierViewModel,
// listener: (context, state) {
// if (state is GetSupplierLoadingState){
// return DialogUtils.showLoading(context, "Loading...");
// }
// else if (state is GetSupplierErrorState){
// DialogUtils.hideLoading(context);
// return DialogUtils.showMessage(context, state.error.toString(),title: "Error");
//
// }
// else if (state is GetSupplierSuccessState) {
// DialogUtils.hideLoading(context);
// setState(() {
// viewModel.suppliers = state.entity;
// print("Suppliers Updated: ${viewModel.suppliers}");
// });
// }
// },
//
// )