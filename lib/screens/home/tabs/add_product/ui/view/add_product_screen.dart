import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:trade_mate/screens/home/home.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';
import 'package:trade_mate/screens/home/tabs/add_product/ui/view_model/add_product_states.dart';
import 'package:trade_mate/screens/home/tabs/bill/ui/view_model/bill_view_model.dart';
import 'package:trade_mate/screens/home/tabs/home_tab/ui/view/home_tab.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/supplier_di.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view/add_supplier_screen.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view_model/supplier_states.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view_model/supplier_view_model.dart';
import 'package:trade_mate/utils/app_colors.dart';

import '../../../../../../utils/dialog_utils.dart';
import '../../../../../../utils/text_field_item.dart';
import '../../../../../widgets/add_product_text_field.dart';
import '../../../bill/domain/bill_di.dart';
import '../../../suppliers/domain/entity/supplier_entity.dart';
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
  BillViewModel billViewModel=BillViewModel(billUseCases: injectBillUseCases());


  @override
  void initState() {
    super.initState();
     viewModel=AddProductViewModel(addProductUseCase:injectAddProductUseCase() );
    viewModel.totalAfterDiscount=viewModel.total;
    viewModel.productQuantity.addListener(calculateTotal);
    viewModel.productPrice.addListener(calculateTotal);
    // viewModel.productTotalAfterDiscount.addListener(calculateTotalAfterDiscount);
    viewModel.productTotal.addListener(calculateTotalAfterDiscount);
    viewModel.discountController.addListener(calculateTotalAfterDiscount);
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
      viewModel.totalAfterDiscount=viewModel.total;
    });

  }
  void calculateTotalAfterDiscount() {
    double total = double.tryParse(viewModel.total.toString()) ?? 0.0;
    double discount = double.tryParse(viewModel.discountController.text) ?? 0.0;
    String discountType = viewModel.discountTypeController.text;


    setState(() {
      viewModel.totalAfterDiscount=total;
      if (discount != 0 && discountType == "%") {
        viewModel.totalAfterDiscount = total - (total * discount / 100);
      } else if (discount != 0 && discountType == "EGP") {
        viewModel.totalAfterDiscount = total - discount;
      } else {
        viewModel.totalAfterDiscount = total;
      }

      print('Updated Total After Discount: ${viewModel.totalAfterDiscount}');
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
    viewModel.discountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var  bill= ModalRoute.of(context)!.settings.arguments;
    print(bill);

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
          title:bill=="bill"?  Text(
            'In Bill',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.whiteColor),
          ):
          Text(
            'Add Product To Stock',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.whiteColor),
          ),
          toolbarHeight: 100.h,
         leading: IconButton(icon:Icon(Icons.arrow_back,color: AppColors.whiteColor,) ,onPressed: () {
           if(bill=="bill"){
             Navigator.pop(context,viewModel.productsInBill);

           }else{
             Navigator.pop(context);
           }

         },),

        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  right: 20.w, left: 20.w, top: 5.h),              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: Image.asset("assets/images/product_preview_rev_1.png",width: 100.w,height: 100.h,fit: BoxFit.cover,)),
                  SizedBox(
                    width: 5.w,
                  ),

                  Expanded(
                    child: AddProductTextField(
                      hintText: "Category",
                      isEnabled: true,

                      controller: viewModel.productCat,
                      validator: (value) {
                        if(value==null|| viewModel.productCat.text.isEmpty){
                          viewModel.productCat.text = value ?? "";
                          return("please select a category");
                        }
                        return null;
                      },
                      onChanged: (value) {
                        viewModel.productCat.text = value ?? "";
                        print("Selected Category: $value");
                      },
                    ),
                  ),

                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(

                    margin:
                    EdgeInsets.only(top: 15.h, right: 10.w, left: 10.w, bottom: 15.h),
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
                              height: 25.h,
                            ),
                            AddProductTextField(
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
                            SizedBox(
                              height: 25.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
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
                                SizedBox(width: 15.w),
                                Expanded(
                                  child: AddProductTextField(
                                    fieldName: " ",
                                    hintText: "piece",
                                    isEnabled: true,
                                    isDropdown: true,
                                    dropdownValue: "piece",
                                    controller: viewModel.productQuantityType,
                                    validator: (value) {
                                      if(value==null|| viewModel.productQuantityType.text.isEmpty){
                                        viewModel.productQuantityType.text = value ?? "piece";
                                        return("please select a type");
                                      }
                                      return null;
                                    },
                                    dropdownItems: ["piece", "kg", "litre", "ton"],
                                    onChanged: (value) {
                                      viewModel.productQuantityType.text = value ?? "";
                                      print("Selected Type: $value");
                                    },
                                    // dropdownValue: "cat1",
                                  ),
                                ),
                              ],
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
                            bill=="bill"?
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: AddProductTextField(
                                      fieldName: "Discount",
                                      hintText: "ex: 20%",
                                      controller:viewModel. discountController,
                                      isEnabled: true,
                                      keyboardType: TextInputType.number,

                                    )),

                                SizedBox(
                                  width: 5.w,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: AddProductTextField(
                                    fieldName: " ",
                                    hintText: "%",
                                    isEnabled: true,
                                    isDropdown: true,
                                    dropdownValue: "%",
                                    controller: viewModel.discountTypeController,
                                    validator: (value) {
                                      if(value==null|| viewModel.discountTypeController.text.isEmpty){
                                        viewModel.discountTypeController.text = value ?? "piece";
                                        return("please select a type");
                                      }
                                      return null;
                                    },
                                    dropdownItems: ["%", "EGP"],
                                    onChanged: (value) {
                                      viewModel.discountTypeController.text = value ?? "";
                                      print("Selected Type: $value");
                                    },
                                    // dropdownValue: "cat1",
                                  ),
                                ),

                                SizedBox(
                                  width: 5.w,
                                ),
                                Expanded(
                                  flex: 3,

                                  child: AddProductTextField(

                                    controller:viewModel.discountController.text.isEmpty? viewModel.productTotal: viewModel.productTotalAfterDiscount,
                                    fieldName: "Total After Discount",
                                    isEnabled: false,
                                    hintText: "${viewModel.totalAfterDiscount.toStringAsFixed(2)} EGP",
                                    // billViewModel.selectedProduct==null?false:true,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                    },
                                    validator: (value) {
                                    },
                                  ),
                                ),

                              ],
                            ):
                            SizedBox.shrink(),
                            bill=="bill"?  SizedBox(
                              height: 25.h,
                            ):SizedBox.shrink(),
                            bill=="bill"?
                            SizedBox.shrink():
                            BlocBuilder(
                              bloc: viewModel.supplierViewModel,
                              builder: (context, state) {
                                if (state is GetSupplierSuccessState){

                                  viewModel.suppliers=state.entity;

                                  if(viewModel.suppliers.isNotEmpty){
                                    return AddProductTextField(
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
                                    );

                                  }else{
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context, AddSupplierScreen.routeName);
                                      },
                                      child: Expanded(
                                        flex: 2,
                                        child: AddProductTextField(
                                          controller: viewModel.productSup,
                                          fieldName: "Supplier",
                                          hintText: "enter supplier",

                                          validator: (value) {
                                            if(value==null|| viewModel.productSup.text.isEmpty ){
                                              viewModel.productCat.text = value ?? "";
                                              return("please select a supplier");
                                            }

                                          },
                                          isEnabled: false,
                                        ),
                                      ),
                                    );
                                  }

                                  print(viewModel.suppliers);
                                }
                                return SizedBox.shrink();
                              },

                            ),
                            bill=="bill"?
                            SizedBox.shrink():  SizedBox(
                              height: 25.h,
                            ),

                            AddProductTextField(
                              fieldName: "Notes",
                              hintText: "Leave note about the product ...",
                              isEnabled: true,
                              controller:viewModel. productNotes,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),

                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                  right: 20.w, left: 20.w, top: 5.h,bottom: 10.h),
              child: Row(
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
                        if(bill != "bill"){
                          viewModel.formKey.currentState!.save();
                          print("Product Name: ${viewModel.productName.text}");
                          print("Product Quantity: ${viewModel.productQuantity.text}");
                          print("Product Price: ${viewModel.productPrice.text}");
                          print("Product Category: ${viewModel.productCat.text}");
                          print("Product Supplier: ${viewModel.productSup.text}");
                          if (viewModel.formKey.currentState!.validate()){
                            ProductEntity product=ProductEntity(name: viewModel.productName.text,
                                quantity: double.tryParse(viewModel.productQuantity.text)??0.0,
                                quantityType: viewModel.productQuantityType.text,
                                price: double.tryParse(viewModel.productPrice.text)??0.0,
                                total: viewModel.total,
                                discount: double.tryParse(viewModel.discountController.text)??0.0,
                                totalAfterDiscount: double.tryParse(viewModel.productTotalAfterDiscount.text)??viewModel.total,
                                discountType: viewModel.discountTypeController.text??"%",
                                notes: viewModel.productNotes.text==""?"N/A":viewModel.productNotes.text,
                                supplier: viewModel.productSup.text==""?"N/A":viewModel.productSup.text,
                                category: viewModel.productCat.text==""?"N/A":viewModel.productCat.text,
                                date: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
                                userId: FirebaseAuth.instance.currentUser!.uid);
                            viewModel.addProduct(product);
                        }

                        }
                        else{
                          viewModel.formKey.currentState!.save();
                          print("Product Name: ${viewModel.productName.text}");
                          print("Product Quantity: ${viewModel.productQuantity.text}");
                          print("Product Price: ${viewModel.productPrice.text}");
                          print("Product Category: ${viewModel.productCat.text}");
                          print("Product Supplier: ${viewModel.productSup.text}");
                          if (viewModel.formKey.currentState!.validate()){
                            ProductEntity product=ProductEntity(name: viewModel.productName.text,
                                quantity: double.tryParse(viewModel.productQuantity.text)??0.0,
                                quantityType: viewModel.productQuantityType.text??"piece",
                                price: double.tryParse(viewModel.productPrice.text)??0.0,
                                total: viewModel.total,
                                discount: double.tryParse(viewModel.discountController.text)??0.0,
                                totalAfterDiscount: viewModel.discountController.text!=0?viewModel.totalAfterDiscount :viewModel.total,
                                discountType: viewModel.discountTypeController.text??"%",
                                notes: viewModel.productNotes.text==""?"N/A":viewModel.productNotes.text,
                                supplier: viewModel.productSup.text==""?"N/A":viewModel.productSup.text,
                                category: viewModel.productCat.text==""?"N/A":viewModel.productCat.text,
                                date: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
                                userId: FirebaseAuth.instance.currentUser!.uid);
                            viewModel.productsInBill.add(product);
                            print("added");
                            print(viewModel.productsInBill);
                            showDialog(barrierDismissible: false, context: context, builder: (context) {
                              return AlertDialog(

                                actions: [ElevatedButton(onPressed: () {
                                  Navigator.pop(context);
                                  clearForm();
                                },

                                  child: Text("Continue",style:
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

                                  ),)],backgroundColor: AppColors.lightGreyColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r),side: BorderSide(color: AppColors.primaryColor)),


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
                                    Text("${viewModel.productName.text} is added to list",style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: AppColors.primaryColor),
                                    ),
                                  ],
                                ),
                              ) ;
                            });
                            // SnackBar(width: 100.h,backgroundColor: Colors.grey,content:Text(
                            //   "${viewModel.productName.text} is added to list",
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .titleMedium!
                            //       .copyWith(
                            //       color: AppColors.greenColor,
                            //       fontSize: 25.sp),
                            // ) );
                          }

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
            ),




          ],
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