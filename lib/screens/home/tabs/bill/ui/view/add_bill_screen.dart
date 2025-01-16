import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/add_product/ui/view/add_product_screen.dart';
import 'package:trade_mate/screens/home/tabs/bill/ui/view_model/bill_view_model.dart';
import 'package:trade_mate/screens/home/tabs/stock/ui/view_model/stock_view_model.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../widgets/add_product_text_field.dart';
import '../../../add_product/domain/entity/product_entity.dart';
import '../../../stock/domain/stock_di.dart';
import '../../../stock/ui/view_model/stock_states.dart';
import '../../domain/bill_di.dart';
import 'bill_tab.dart';


class AddBillScreen extends StatefulWidget {
  static const String routeName="addBill";
   AddBillScreen({super.key});

  @override
  State<AddBillScreen> createState() => _AddBillScreenState();
}

class _AddBillScreenState extends State<AddBillScreen> {

  BillType? bill = BillType.inBill;
  BillViewModel billViewModel=BillViewModel(billUseCases: injectBillUseCases());


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    billViewModel. stockViewModel.getProducts();
    billViewModel.discountTypeController.text="%";
    billViewModel.quantityController.addListener(calculateTotal);
    billViewModel.priceController.addListener(calculateTotal);
    billViewModel.discountController.addListener(calculateTotal);
    billViewModel.discountTypeController.addListener(calculateTotal);
    billViewModel.quantityController.addListener(() {
      if (billViewModel.formKey.currentState != null) {
        billViewModel.formKey.currentState!.validate();
      }
    });


  }
  void calculateTotal() {
    double quantity = double.tryParse(billViewModel.quantityController.text) ?? 0.0;
    double price = double.tryParse(billViewModel.priceController.text) ?? 0;
    double discount = double.tryParse(billViewModel.discountController.text) ?? 0;


    setState(() {
      discount!=0&&billViewModel.discountTypeController.text=="%"?
      billViewModel.total = (price * quantity)-(price * quantity*discount)/100:
      discount!=0&&billViewModel.discountTypeController.text=="EGP"?
      billViewModel.total = (price * quantity)-(discount)
          :
      billViewModel.total = (price * quantity);
      print('Updated Total: ${billViewModel.total}');
    });

  }

  // void clearForm() {
  //   billViewModel.formKey.currentState?.reset();
  //   billViewModel.selectedProduct=null;
  //   billViewModel.quantityController.clear();
  //   billViewModel.priceController.clear();
  //   billViewModel.productController.clear();
  //   billViewModel.discountController.clear();
  //
  // }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.whiteColor),

          backgroundColor: AppColors.darkPrimaryColor,
          title: Text(
            'Out Bill',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.whiteColor),
          ),
          toolbarHeight: 100.h,


        ),
        backgroundColor: AppColors.lightGreyColor,
        resizeToAvoidBottomInset: true,
body: Padding(
  padding:  EdgeInsets.only(left:8.w,right: 8.w,top: 8.h,bottom: MediaQuery.paddingOf(context).bottom),
  child: Column(
    children: [
      // Row(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     SizedBox(width: 5.w,),
      //     Text(
      //       "Choose bill type:",
      //       style: Theme.of(context)
      //           .textTheme
      //           .titleMedium!
      //           .copyWith(
      //           color: AppColors.darkPrimaryColor,
      //           fontSize: 25.sp),
      //     ),
      //     Container(
      //       margin:
      //       EdgeInsets.only(top: 15.h, right: 5.w, left: 10.w, bottom: 15.h),
      //       padding: EdgeInsets.only(
      //         right: 20.w, left: 5.w, ),
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(10.r),
      //         border: Border.all(color: AppColors.primaryColor),
      //       ),
      //       child: Row(
      //         children: [
      //           Radio<BillType>(
      //             value: BillType.inBill,
      //             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //             groupValue:bill,
      //             fillColor: bill==BillType.inBill?MaterialStateProperty.all(AppColors.greenColor):MaterialStateProperty.all(AppColors.blackColor),
      //             onChanged: (BillType? newValue) {
      //               setState(() {
      //                 bill = newValue;
      //               });
      //             },
      //           ),
      //           Text(
      //             "In Bill",
      //             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
      //               color: AppColors.darkPrimaryColor,
      //             ),
      //           ),
      //           Radio<BillType>(
      //             value: BillType.outBill,
      //             groupValue:bill,
      //
      //             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //             fillColor: bill==BillType.outBill?MaterialStateProperty.all(AppColors.greenColor):MaterialStateProperty.all(AppColors.blackColor),
      //
      //             onChanged: (BillType? newValue) {
      //               setState(() {
      //                 bill = newValue;
      //               });
      //             },
      //           ),
      //           Text(
      //             "Out Bill",
      //             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
      //               color: AppColors.darkPrimaryColor,
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //
      //   ],
      // ),

      Container(
        margin:
        EdgeInsets.only( right: 10.w, left: 10.w, bottom: 25.h),
        padding: EdgeInsets.only(
          right: 20.w, left: 20.w,bottom: MediaQuery.viewPaddingOf(context).bottom),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: billViewModel.formKey,
                child: Column(

                  children: [

                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15.r),
                            child: Image.asset(
                              "assets/images/product_preview_rev_1.png",width:
                            100.w,height: 100.h,fit: BoxFit.cover,)),
                        SizedBox(
                          width: 5.w,
                        ),
                        BlocBuilder(
                          bloc: billViewModel.stockViewModel,
                          builder: (context, state) {
                            if (state is StockSuccessState){
                              billViewModel.products=state.products;
                              print("Products loaded: ${billViewModel.products.map((e) => e.name)}");
                              if (billViewModel.products.isNotEmpty){
                                return Expanded(
                                  flex: 2,
                                  child: AddProductTextField(
                                    controller: billViewModel.productController,

                                    fieldName: "Product",
                                    hintText: "ex: USB-C",
                                    isDropdown: true,
                                    dropdownItems:billViewModel. products.map((e) => e.name).toList(),
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return 'please choose a product';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        billViewModel. productController.text = value ?? "";
                                        // Find the selected product and set its price in the price controller
                                        var selectedProduct = billViewModel.products.firstWhere(
                                              (product) => product.name == value,

                                        );
                                        billViewModel.selectedProduct=selectedProduct;

                                        billViewModel. priceController.text = selectedProduct.price.toString();
                                        billViewModel.quantityController.text = "1.0";
                                        print("Selected product: $value, Price: ${selectedProduct.price}");
                                      }
                                      );
                                    },

                                    isEnabled: true,
                                  ),
                                );
                              }else{
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, AddProductScreen.routeName);
                                  },
                                  child: Expanded(
                                    flex: 2,
                                    child: AddProductTextField(
                                      controller: billViewModel.productController,
                                      fieldName: "Product",
                                      hintText: "ex: USB-C",

                                      validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return 'please choose a product';
                                        }
                                        return null;
                                      },
                                      isEnabled: false,
                                    ),
                                  ),
                                );
                              }

                            }return SizedBox.shrink();

                          },

                        ),

                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
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
                    Row(
                      children: [
                        Expanded(
                            child: AddProductTextField(
                              fieldName: "Price",
                              hintText: "for one item",
                              controller: billViewModel.priceController,
                              isEnabled: billViewModel.selectedProduct==null?false:true,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'please enter product price';
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
                            hintText: billViewModel.selectedProduct==null?"0.0":"1.0",
                            controller:billViewModel.quantityController,
                            suffix:  Text(
                              billViewModel.selectedProduct?.quantityType??"piece",
                              style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                color: AppColors.primaryColor,
                                fontSize: 16.sp),
                            ),
                            fieldName: "Quantity",
                            isEnabled: billViewModel.selectedProduct==null?false:true,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              print(billViewModel.selectedProduct);
                              if (billViewModel.selectedProduct != null) {
                                double enteredQuantity = double.tryParse(value!) ?? 0.0;
                                if (enteredQuantity > billViewModel.selectedProduct!.quantity) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Entered quantity exceeds available stock (${billViewModel.selectedProduct!.quantity})',
                                        style: TextStyle(color: AppColors.whiteColor),
                                      ),
                                      backgroundColor: AppColors.redColor,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              }
                            },
                            validator: (value) {

                              if (value == null  ) {
                                return 'please enter product quantity';
                              }
                              double? enteredQuantity = double.tryParse(value)??1.0;
                              if (billViewModel.selectedProduct != null && enteredQuantity >billViewModel. selectedProduct!.quantity) {
                                return 'exceeds available stock (${billViewModel.selectedProduct!.quantity})';
                              }
                              return null;
                            },
                          ),
                        ),


                        // Expanded(
                        //     child: AddProductTextField(
                        //       controller: totalPriceController,
                        //       fieldName: "Total",
                        //       isEnabled: false,
                        //       hintText:
                        //       // "${viewModel.total.toStringAsFixed(2)} "
                        //           "EGP",
                        //     )),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 2,
                            child: AddProductTextField(
                              fieldName: "Discount",
                              hintText: "ex: 20%",
                              controller:billViewModel. discountController,
                              isEnabled: billViewModel.selectedProduct==null?false:true,
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
                            controller: billViewModel.discountTypeController,
                            validator: (value) {
                              if(value==null|| billViewModel.discountTypeController.text.isEmpty){
                                billViewModel.discountTypeController.text = value ?? "piece";
                                return("please select a type");
                              }
                              return null;
                            },
                            dropdownItems: ["%", "EGP"],
                            onChanged: (value) {
                              billViewModel.discountTypeController.text = value ?? "";
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
                            hintText: billViewModel.selectedProduct==null?"0.0":billViewModel.total.toStringAsFixed(2),
                            controller:billViewModel.totalController,
                            fieldName: "Total",
                            isEnabled: false,
                            // billViewModel.selectedProduct==null?false:true,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                            },
                            validator: (value) {
                            },
                          ),
                        ),


                        // Expanded(
                        //     child: AddProductTextField(
                        //       controller: totalPriceController,
                        //       fieldName: "Total",
                        //       isEnabled: false,
                        //       hintText:
                        //       // "${viewModel.total.toStringAsFixed(2)} "
                        //           "EGP",
                        //     )),
                      ],
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
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
      ),
      Row(
        children: [
          Expanded(
            child: ElevatedButton(
                onPressed: () {
                  // clearForm();
                  Navigator.pop(context);

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
                  "Cancel",
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
              //   viewModel.formKey.currentState!.save();
              //   print("Product Name: ${viewModel.productName.text}");
              //   print("Product Quantity: ${viewModel.productQuantity.text}");
              //   print("Product Price: ${viewModel.productPrice.text}");
              //   print("Product Category: ${viewModel.productCat.text}");
              //   print("Product Supplier: ${viewModel.productSup.text}");
              //   if (viewModel.formKey.currentState!.validate()){
              //     ProductEntity product=ProductEntity(name: viewModel.productName.text,
              //         quantity: double.tryParse(viewModel.productQuantity.text)??0.0,
              //         price: double.tryParse(viewModel.productPrice.text)??0.0,
              //         total: viewModel.total,
              //         notes: viewModel.productNotes.text==""?"N/A":viewModel.productNotes.text,
              //         supplier: viewModel.productSup.text==""?"N/A":viewModel.productSup.text,
              //         category: viewModel.productCat.text==""?"N/A":viewModel.productCat.text,
              //         date: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
              //         userId: FirebaseAuth.instance.currentUser!.uid);
              //     viewModel.addProduct(product);
              //   }
              //
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

    ],
  ),
),

      ),
    );
  }
}
