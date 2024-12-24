

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view/suplliers_screen.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view_model/supplier_view_model.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/dialog_utils.dart';
import '../../../../../widgets/add_product_text_field.dart';
import '../../domain/supplier_di.dart';
import '../view_model/supplier_states.dart';

class AddSupplierScreen extends StatefulWidget {
  static const String routeName="addSupplier";
   AddSupplierScreen({super.key});

  @override
  State<AddSupplierScreen> createState() => _AddSupplierScreenState();
}

class _AddSupplierScreenState extends State<AddSupplierScreen> {

SupplierViewModel supplierViewModel=SupplierViewModel(supplierUseCases: injectSupplierUseCases());

   void clearForm() {
     supplierViewModel.formKey.currentState?.reset();
     supplierViewModel.supplierName.clear();
     supplierViewModel.supplierPhone.clear();
     supplierViewModel.supplierAddress.clear();
     supplierViewModel.supplierCity.clear();
     supplierViewModel.supplierNotes.clear();
   }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: supplierViewModel,
      listener: (context, state) {
        if (state is AddSupplierLoadingState){
          return DialogUtils.showLoading(context, "Loading...");
        }
        else if (state is AddSupplierErrorState){
          DialogUtils.hideLoading(context);
          return DialogUtils.showMessage(context, state.error,title: "Error");

        }
        else if (state  is AddSupplierSuccessState){
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
                      Navigator.pushReplacementNamed(context, SuplliersScreen.routeName);
                    },
                    child: Text("back to Suppliers",style:
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
              title: Text("${state.entity.name}",style:
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
                  Text("The supplier is added successfully",style: Theme.of(context)
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
            'Add Supplier',
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
              EdgeInsets.only(top: 20.h, right: 10.w, left: 10.w, bottom: 20.h),
              padding: EdgeInsets.only(
                right: 20.w, left: 20.w, ),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Center(
                child: Form(
                  key: supplierViewModel.formKey,
                  child: Column(

                    children: [
                      SizedBox(
                        height: 35.h,
                      ),
                      AddProductTextField(
                        controller: supplierViewModel.supplierName,
                        fieldName: "Supplier Name",
                        hintText: "enter name here",
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'please enter supplier name';
                          }
                          return null;
                        },
                        isEnabled: true,
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      AddProductTextField(
                        hintText: "enter phone number",
                        controller:supplierViewModel.supplierPhone,
                        fieldName: "Phone",
                        isEnabled: true,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty  ) {
                            return 'please enter supplier number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 25.h,
                      ),

                      AddProductTextField(
                        fieldName: "City",
                        hintText: "select City",
                        isEnabled: true,
                        isDropdown: true,
                        controller: supplierViewModel.supplierCity,
                        validator: (value) {
                          if(value==null|| supplierViewModel.supplierCity.text.isEmpty){
                            supplierViewModel.supplierCity.text = value ?? "";
                            return("please select a city");
                          }
                          return null;
                        },
                        dropdownItems: ["Cairo", "Giza", "Alexandria"],
                        onChanged: (value) {
                          supplierViewModel.supplierCity.text = value ?? "";
                          print("Selected city: $value");
                        },
                        // dropdownValue: "cat1",
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      AddProductTextField(
                        hintText: "enter address in details here",
                        controller:supplierViewModel.supplierAddress,
                        fieldName: "Address",
                        isEnabled: true,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty  ) {
                            return 'please enter supplier address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      AddProductTextField(
                        fieldName: "Notes",
                        hintText: "Leave note about the supplier ...",
                        isEnabled: true,
                        controller:supplierViewModel.supplierNotes,
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
                    supplierViewModel.formKey.currentState!.save();
                    print("Product Name: ${supplierViewModel.supplierName.text}");
                    print("Product Quantity: ${supplierViewModel.supplierAddress.text}");
                    print("Product Price: ${supplierViewModel.supplierCity.text}");
                    print("Product Category: ${supplierViewModel.supplierPhone.text}");
                    print("Product Supplier: ${supplierViewModel.supplierNotes.text}");
                    if (supplierViewModel.formKey.currentState!.validate()){
                      SupplierEntity supplier=SupplierEntity(name: supplierViewModel.supplierName.text
                          , notes: supplierViewModel.supplierNotes.text,
                          phone: supplierViewModel.supplierPhone.text
                          , address: supplierViewModel.supplierAddress.text
                          , city: supplierViewModel.supplierCity.text
                          , date: DateFormat('dd-MM-yyyy').format(DateTime.now()), userId: FirebaseAuth.instance.currentUser!.uid);
                      supplierViewModel.addSupplier(supplier);
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
                      ),
                      SizedBox(
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
