import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../widgets/add_product_text_field.dart';

class EditProduct extends StatefulWidget {
   EditProduct({required this.update,required this.productEntity}){

   }
   void Function(String,ProductEntity)update;
   ProductEntity productEntity;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController productName = TextEditingController();

   var formKey = GlobalKey<FormState>();

  TextEditingController productQuantity = TextEditingController();

  TextEditingController productCat = TextEditingController();

  TextEditingController productSup = TextEditingController();

  TextEditingController productTotal = TextEditingController();

  TextEditingController productPrice = TextEditingController();

  TextEditingController productNotes = TextEditingController();

  double total = 0.0;
  void initState() {
    super.initState();
    productName.text = widget.productEntity.name;
    productQuantity.text = widget.productEntity.quantity.toString();
    productCat.text = widget.productEntity.category ;
    productSup.text = widget.productEntity.supplier ;
    productPrice.text = widget.productEntity.price.toString();
    productTotal.text = widget.productEntity.total.toString();
    productNotes.text = widget.productEntity.notes ?? "";
    productQuantity.addListener(calculateTotal);
    productPrice.addListener(calculateTotal);

  }
   DateTime selectedDate=DateTime.now();
  void calculateTotal() {
    double quantity = double.tryParse(productQuantity.text) ?? 0.0;
    double price = double.tryParse(productPrice.text) ?? 0.0;

    setState(() {
      total = price * quantity;
      productTotal.text = total.toStringAsFixed(2);
      print('Updated Total: ${total}');
    });

  }
   @override
  Widget build(BuildContext context) {
    return
      Form(
        key: formKey,
        child: Column(
        mainAxisSize: MainAxisSize.min,
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
            height: 10.h,
          ),
          AddProductTextField(
            fieldName: "Category",
            hintText: "select category",
            isEnabled: true,
            isDropdown: true,
            controller: productCat,
            dropdownValue:productCat.text=="N/A"?null: productCat.text,
            validator: (value) {
              if (value == null || productCat.text.isEmpty ) {

                productCat.text = value ?? "";
                return ("please select a category");
              }
              return null;
            },
            dropdownItems: ["cat1", "cat2", "cat3", "cat4", "cat5"],
            onChanged: (value) {
              productCat.text = value ?? "";
              print("Selected Category: $value");
            },
        // dropdownValue: "cat1",
          ),
          SizedBox(
            height: 10.h,
          ),
          AddProductTextField(
            fieldName: "Supplier",
            hintText: "select supplier",
            isEnabled: true,
            isDropdown: true,
            dropdownValue: productSup.text=="N/A"?null:productSup.text,
            controller: productSup,
            validator: (value) {
              if (value == null || productSup.text.isEmpty) {
                productCat.text = value ?? "";
                return ("please select a supplier");
              }
            },
            dropdownItems: ["sup1", "sup2", "sup3", "sup4", "sup5"],
            onChanged: (value) {
              productSup.text = value ?? "";
              print("Selected Supplier: $value");
            },
          ),
          SizedBox(
            height: 10.h,
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
                      .copyWith(color: AppColors.primaryColor, fontSize: 16.sp),
                ),
              )),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                  child: AddProductTextField(
                controller: productTotal,
                fieldName: "Total",
                isEnabled: false,
                hintText: "${total.toStringAsFixed(2)} EGP",
              )),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          AddProductTextField(
            fieldName: "Notes",
            hintText: "Leave note about the product ...",
            isEnabled: true,
            controller: productNotes,
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
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
                          fontSize: 25.sp),
                    )),
              ),
              SizedBox(width: 10.w,),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      final updatedProduct = ProductEntity(
                        date: widget.productEntity.date,
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        id: widget.productEntity.id,
                        name: productName.text,
                        quantity: double.tryParse(productQuantity.text) ?? 1.0,
                        price: double.tryParse(productPrice.text) ?? 0.0,
                        total: productTotal.text.isNotEmpty ? double.tryParse(productTotal.text) ?? 0.0 : 0.0,
                        supplier: productSup.text,
                        category: productCat.text,
                        notes: productNotes.text,
                      );
                      widget.update(widget.productEntity.id, updatedProduct);
                      Navigator.pop(context);
                    }

                    // viewModel.formKey.currentState!.save();
                    // print("Product Name: ${viewModel.productName.text}");
                    // print("Product Quantity: ${viewModel.productQuantity.text}");
                    // print("Product Price: ${viewModel.productPrice.text}");
                    // print("Product Category: ${viewModel.productCat.text}");
                    // print("Product Supplier: ${viewModel.productSup.text}");
                    // if (viewModel.formKey.currentState!.validate()){
                    //   ProductEntity product=ProductEntity(name: viewModel.productName.text,
                    //       quantity: double.tryParse(viewModel.productQuantity.text)??1.0,
                    //       price: double.tryParse(viewModel.productPrice.text)??0.0,
                    //       total: viewModel.total,
                    //       supplier: viewModel.productSup.text,
                    //       category: viewModel.productCat.text,
                    //       date: DateUtils.dateOnly(viewModel.selectedDate).millisecondsSinceEpoch,
                    //       userId: FirebaseAuth.instance.currentUser!.uid);
                    //   viewModel.addProduct(product);
                    // }

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
                        color: AppColors.whiteColor, fontSize: 25.sp),
                  ),
                ),
              ),
            ],
          )
        ],
            ),
      );
  }
}
