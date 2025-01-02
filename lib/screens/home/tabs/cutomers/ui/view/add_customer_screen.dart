

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:trade_mate/screens/home/tabs/cutomers/ui/view/customers_screen.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view/suplliers_screen.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view_model/supplier_view_model.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/dialog_utils.dart';
import '../../../../../../utils/shared_preference.dart';
import '../../../../../widgets/add_product_text_field.dart';
import '../../domain/customer_di.dart';
import '../view_model/customer_states.dart';
import '../view_model/customer_view_model.dart';

class AddCustomerScreen extends StatefulWidget {
  static const String routeName="addCustomer";
  AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {

  CustomerViewModel customerViewModel=CustomerViewModel(customerUseCases: injectCustomerUseCases());

   void clearForm() {
     customerViewModel.formKey.currentState?.reset();
     customerViewModel.customerName.clear();
     customerViewModel.customerPhone.clear();
     customerViewModel.customerAddress.clear();
     customerViewModel.customerCity.clear();
     customerViewModel.customerNotes.clear();
   }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: customerViewModel,
      listener: (context, state) {
        if (state is AddCustomerLoadingState){
          return DialogUtils.showLoading(context, "Loading...");
        }
        else if (state is AddCustomerErrorState){
          DialogUtils.hideLoading(context);
          return DialogUtils.showMessage(context, state.error,title: "Error");

        }
        else if (state  is AddCustomerSuccessState){
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
                      Navigator.pushReplacementNamed(context, CustomersScreen.routeName);
                    },
                    child: Text("back to Customers",style:
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
                  Center(
                    child: Text("The customer is added successfully",textAlign: TextAlign.center,style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: AppColors.primaryColor),
                    ),
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
            'Add Customer',
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
                  key: customerViewModel.formKey,
                  child: Column(

                    children: [
                      SizedBox(
                        height: 35.h,
                      ),
                      AddProductTextField(
                        controller: customerViewModel.customerName,
                        fieldName: "Customer Name",
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
                        controller:customerViewModel.customerPhone,
                        fieldName: "Phone",
                        isEnabled: true,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty  ) {
                            return 'please enter customer number';
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
                        controller: customerViewModel.customerCity,
                        validator: (value) {
                          if(value==null|| customerViewModel.customerCity.text.isEmpty){
                            customerViewModel.customerCity.text = value ?? "";
                            return("please select a city");
                          }
                          return null;
                        },
                        dropdownItems: ["Cairo", "Giza", "Alexandria"],
                        onChanged: (value) {
                          customerViewModel.customerCity.text = value ?? "";
                          print("Selected city: $value");
                        },
                        // dropdownValue: "cat1",
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      AddProductTextField(
                        hintText: "enter address in details here",
                        controller:customerViewModel.customerAddress,
                        fieldName: "Address",
                        isEnabled: true,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty  ) {
                            return 'please enter customer address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      AddProductTextField(
                        fieldName: "Notes",
                        hintText: "Leave note about the customer ...",
                        isEnabled: true,
                        controller:customerViewModel.customerNotes,
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
                              onPressed: () async{
                                await SharedPreference.init();
                                var user=SharedPreference.getData(key: 'email' );
                    customerViewModel.formKey.currentState!.save();
                    print("customer Name: ${customerViewModel.customerName.text}");
                    print("customer address: ${customerViewModel.customerAddress.text}");
                    print("customer city: ${customerViewModel.customerCity.text}");
                    print("customer phone: ${customerViewModel.customerPhone.text}");
                    print("customer notes: ${customerViewModel.customerNotes.text}");
                    if (customerViewModel.formKey.currentState!.validate()){
                      SupplierEntity customer=SupplierEntity(name: customerViewModel.customerName.text
                          , notes: customerViewModel.customerNotes.text??"N/A",
                          id: user.toString(),
                          phone: customerViewModel.customerPhone.text
                          , address: customerViewModel.customerAddress.text
                          , city: customerViewModel.customerCity.text
                          , date: DateFormat('dd-MM-yyyy').format(DateTime.now()), userId: FirebaseAuth.instance.currentUser!.uid);
                      customerViewModel.addCustomer(customer);
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
