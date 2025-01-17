import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../widgets/add_product_text_field.dart';

class EditProductInBill extends StatefulWidget {
  EditProductInBill(
      {super.key, required this.productEntity, required this.edit});

  ProductEntity productEntity;
  Function(ProductEntity product) edit;

  @override
  State<EditProductInBill> createState() => _EditProductInBillState();
}

class _EditProductInBillState extends State<EditProductInBill> {
  var formKey = GlobalKey<FormState>();

  TextEditingController productName = TextEditingController();

  TextEditingController productQuantity = TextEditingController();

  TextEditingController productQuantityType = TextEditingController();

  TextEditingController productCat = TextEditingController();


  TextEditingController productTotal = TextEditingController();

  TextEditingController productTotalAfterDiscount = TextEditingController();

  TextEditingController productPrice = TextEditingController();

  TextEditingController productNotes = TextEditingController();

  TextEditingController discountController = TextEditingController();

  TextEditingController discountTypeController = TextEditingController();

  double total = 0.0;
  double totalAfterDiscount = 0.0;
  void initState() {
    super.initState();
    productName.text = widget.productEntity.name;
    productQuantity.text = widget.productEntity.quantity.toString();
    productQuantityType.text = widget.productEntity.quantityType.toString();
    discountTypeController.text = widget.productEntity.discountType.toString();
    productCat.text = widget.productEntity.category ;

    productPrice.text = widget.productEntity.price.toString();
    discountController.text = widget.productEntity.discount.toString();
    productTotal.text = widget.productEntity.total.toString();
    productTotalAfterDiscount.text = widget.productEntity.totalAfterDiscount.toString();
    productNotes.text = widget.productEntity.notes ?? "";
    productQuantity.addListener(calculateTotal);
    productPrice.addListener(calculateTotal);
    discountController.addListener(calculateTotalAfterDiscount);
    productTotal.addListener(calculateTotalAfterDiscount);



  }
  DateTime selectedDate=DateTime.now();
  void calculateTotal() {

    double quantity = double.tryParse(productQuantity.text) ?? 0.0;
    double price = double.tryParse(productPrice.text) ?? 0.0;

    setState(() {
     total = price * quantity;
     productTotal.text=total.toString();

      print('Updated Total: ${total}');
    });

  }
  void calculateTotalAfterDiscount() {
    double totall = double.tryParse(total.toString()) ?? 0.0;
    double discount = double.tryParse(discountController.text) ?? 0.0;
    String discountType = discountTypeController.text;


    setState(() {

      if (discount != 0 && discountType == "%") {
        totalAfterDiscount = totall - (totall * discount / 100);
        productTotalAfterDiscount.text=totalAfterDiscount.toString();
      } else if (discount != 0 && discountType == "EGP") {
        totalAfterDiscount = totall - discount;
        productTotalAfterDiscount.text=totalAfterDiscount.toString();
      } else {
        totalAfterDiscount = totall;
        productTotalAfterDiscount.text=totalAfterDiscount.toString();
      }

      print('Updated Total After Discount: ${totalAfterDiscount}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: EdgeInsets.only(
              top: 15.h, right: 10.w, left: 10.w, bottom: 15.h),
          padding: EdgeInsets.only(
            right: 20.w,
            left: 20.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.primaryColor),
          ),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15.r),
                            child: Image.asset(
                              "assets/images/product_preview_rev_1.png",
                              width: 100.w,
                              height: 100.h,
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                          width: 5.w,
                        ),
                        Expanded(
                          child: AddProductTextField(
                            hintText: "Category",
                            isEnabled: true,
                            controller: productCat,
                            validator: (value) {
                              if (value == null || productCat.text.isEmpty) {
                                productCat.text = value ?? "";
                                return ("please select a category");
                              }
                              return null;
                            },
                            onChanged: (value) {
                              productCat.text = value ?? "";
                              print("Selected Category: $value");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  AddProductTextField(
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
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
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
                      SizedBox(width: 15.w),
                      Expanded(
                        child: AddProductTextField(
                          fieldName: " ",
                          hintText: "piece",
                          isEnabled: true,
                          isDropdown: true,
                          dropdownValue: "piece",
                          controller: productQuantityType,
                          validator: (value) {
                            if (value == null ||
                                productQuantityType.text.isEmpty) {
                              productQuantityType.text = value ?? "piece";
                              return ("please select a type");
                            }
                            return null;
                          },
                          dropdownItems: ["piece", "kg", "litre", "ton"],
                          onChanged: (value) {
                            productQuantityType.text = value ?? "";
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
                        controller: productTotal,
                        fieldName: "Total",
                        isEnabled: false,
                        hintText: "${total.toStringAsFixed(2)} EGP",
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 2,
                          child: AddProductTextField(
                            fieldName: "Discount",
                            hintText: "ex: 20%",
                            controller: discountController,
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
                          controller: discountTypeController,
                          validator: (value) {
                            if (value == null ||
                                discountTypeController.text.isEmpty) {
                              discountTypeController.text =
                                  value ?? "piece";
                              return ("please select a type");
                            }
                            return null;
                          },
                          dropdownItems: ["%", "EGP"],
                          onChanged: (value) {
                            discountTypeController.text = value ?? "";
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
                          controller: discountController.text.isEmpty
                              ? productTotal
                              : productTotalAfterDiscount,
                          fieldName: "Total After Discount",
                          isEnabled: false,
                          hintText:
                              "${totalAfterDiscount.toStringAsFixed(2)} EGP",
                          // billViewModel.selectedProduct==null?false:true,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {},
                          validator: (value) {},
                        ),
                      ),
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
                    height: 20.h,
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(right: 20.w, left: 20.w, top: 5.h, bottom: 10.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                  padding: WidgetStatePropertyAll(
                                      EdgeInsets.only(bottom: 5.h, top: 5.h)),
                                  backgroundColor:
                                  WidgetStatePropertyAll(AppColors.primaryColor),
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.r)),
                                  )),
                              child: Text(
                                "Cancel",
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: AppColors.whiteColor, fontSize: 30.sp),
                              )),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ProductEntity updatedProduct = ProductEntity(
                                  supplier: "",
                                  date: widget.productEntity.date,
                                  userId: widget.productEntity.userId,
                                  id: widget.productEntity.id,
                                  name: productName.text,
                                  quantity: double.tryParse(productQuantity.text) ?? 0.0,
                                  quantityType: productQuantityType.text,
                                  price: double.tryParse(productPrice.text) ?? 0.0,
                                  total: total,
                                  discount:
                                  double.tryParse(discountController.text) ?? 0.0,
                                  totalAfterDiscount: discountController.text.isEmpty
                                      ? total
                                      : totalAfterDiscount,
                                  discountType: discountTypeController.text,
                                  notes: productNotes.text.isEmpty
                                      ? "N/A"
                                      : productNotes.text,
                                  category:
                                  productCat.text.isEmpty ? "N/A" : productCat.text,
                                );
                              print("edit product in bill");
                              print(updatedProduct.name);
                                widget.edit(updatedProduct);
                                Navigator.pop(context);
                              }
                            },
                            style: ButtonStyle(
                                padding: WidgetStatePropertyAll(
                                    EdgeInsets.only(bottom: 5.h, top: 5.h)),
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
                                  .copyWith(color: AppColors.whiteColor, fontSize: 30.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
