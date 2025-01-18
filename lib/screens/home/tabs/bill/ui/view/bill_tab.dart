import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:trade_mate/screens/home/home.dart';
import 'package:trade_mate/screens/home/tabs/add_product/ui/view/add_product_screen.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/entity/bill_entity.dart';
import 'package:trade_mate/screens/home/tabs/bill/ui/view/add_bill_screen.dart';
import 'package:trade_mate/screens/home/tabs/bill/ui/view/bill_product_item.dart';
import 'package:trade_mate/screens/home/tabs/bill/ui/view_model/bill_states.dart';
import 'package:trade_mate/screens/home/tabs/bill/ui/view_model/bill_view_model.dart';
import 'package:trade_mate/screens/home/tabs/cutomers/ui/view/add_customer_screen.dart';
import 'package:trade_mate/screens/home/tabs/home_tab/ui/view/home_tab.dart';
import 'package:trade_mate/screens/widgets/add_product_text_field.dart';
import 'package:trade_mate/utils/app_colors.dart';

import '../../../../../../utils/text_field_item.dart';
import '../../../add_product/domain/entity/product_entity.dart';
import '../../../cutomers/ui/view_model/customer_states.dart';
import '../../../suppliers/ui/view/add_supplier_screen.dart';
import '../../../suppliers/ui/view_model/supplier_states.dart';
import '../../domain/bill_di.dart';
import 'bill_screen.dart';

enum BillType { inBill, outBill }

class BillTab extends StatefulWidget {
  final String billName;

  BillTab({Key? key, required this.billName}) : super(key: key);

  @override
  State<BillTab> createState() => _BillTabState();
}

class _BillTabState extends State<BillTab> {
  BillType? bill = BillType.inBill;
  int selectedIndex = 0;

  TextEditingController paymentType = TextEditingController();
  TextEditingController searchController = TextEditingController();
  BillViewModel billViewModel =
      BillViewModel(billUseCases: injectBillUseCases());
  String? supplier;
  String? customer;
  List<ProductEntity> productsInBill = [];
  String paymentMethod = "Cash";
  double totalBill = 0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    billViewModel.supplierViewModel.getSuppliers();
    billViewModel.customerViewModel.getCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: billViewModel..addBill,
      builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: Column(
                children: [
                  Container(
                    height: 145.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            bill == BillType.outBill
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: AppColors.greenColor,
                                        size: 18.sp,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Text(
                                        "customer",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontSize: 22.sp,
                                                color: AppColors.greenColor),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      BlocBuilder(
                                          bloc: billViewModel.customerViewModel,
                                          builder: (context, state) {
                                            if (state
                                                is GetCustomerSuccessState) {
                                              billViewModel.customers =
                                                  state.entity;

                                              if (billViewModel
                                                  .customers.isNotEmpty) {
                                                return Container(
                                                  width: 95.w,
                                                  height: 25.h,
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: AppColors
                                                                  .primaryColor,
                                                              width: 1.w))),
                                                  child: DropdownButton<String>(
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(
                                                            fontSize: 18.sp,
                                                            color: AppColors
                                                                .primaryColor),
                                                    isExpanded: true,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.r),
                                                    alignment: Alignment.center,
                                                    dropdownColor: AppColors
                                                        .lightGreyColor,
                                                    underline: Container(
                                                      color: Colors.transparent,
                                                    ),
                                                    padding: EdgeInsets.only(
                                                        left: 10.h,
                                                        right: 10.h),
                                                    value: customer,
                                                    items: billViewModel
                                                        .customers
                                                        .map((e) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: e.name,
                                                              child:
                                                                  Text(e.name),
                                                            ))
                                                        .toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        customer = value;
                                                      });
                                                    },
                                                  ),
                                                );
                                              } else {
                                                return InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        AddCustomerScreen
                                                            .routeName);
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.w),
                                                    child: Icon(
                                                      Icons.add_circle,
                                                      color: AppColors
                                                          .primaryColor,
                                                      size: 22.sp,
                                                    ),
                                                  ),
                                                );
                                              }
                                            }
                                            return SizedBox.shrink();
                                          }),
                                      billViewModel.customers.isNotEmpty
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    AddCustomerScreen
                                                        .routeName);
                                              },
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.w),
                                                child: Icon(
                                                  Icons.add_circle,
                                                  color: AppColors.primaryColor,
                                                  size: 22.sp,
                                                ),
                                              ),
                                            )
                                          : SizedBox.shrink()
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: AppColors.greenColor,
                                        size: 18.sp,
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Text(
                                        "supplier",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontSize: 22.sp,
                                                color: AppColors.greenColor),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      BlocBuilder(
                                          bloc: billViewModel.supplierViewModel,
                                          builder: (context, state) {
                                            if (state
                                                is GetSupplierSuccessState) {
                                              billViewModel.suppliers =
                                                  state.entity;

                                              if (billViewModel
                                                  .suppliers.isNotEmpty) {
                                                return Container(
                                                  width: 100.w,
                                                  height: 25.h,
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                          bottom: BorderSide(
                                                              color: AppColors
                                                                  .primaryColor,
                                                              width: 1.w))),
                                                  child: DropdownButton<String>(
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(
                                                            fontSize: 18.sp,
                                                            color: AppColors
                                                                .primaryColor),
                                                    isExpanded: true,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.r),
                                                    alignment: Alignment.center,
                                                    dropdownColor: AppColors
                                                        .lightGreyColor,
                                                    underline: Container(
                                                      color: Colors.transparent,
                                                    ),
                                                    padding: EdgeInsets.only(
                                                        left: 10.h,
                                                        right: 10.h),
                                                    value: supplier,
                                                    items: billViewModel
                                                        .suppliers
                                                        .map((e) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: e.name,
                                                              child:
                                                                  Text(e.name),
                                                            ))
                                                        .toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        supplier = value;
                                                      });
                                                    },
                                                  ),
                                                );
                                              } else {
                                                return InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        AddSupplierScreen
                                                            .routeName);
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.w),
                                                    child: Icon(
                                                      Icons.add_circle,
                                                      color: AppColors
                                                          .primaryColor,
                                                      size: 22.sp,
                                                    ),
                                                  ),
                                                );
                                              }
                                            }
                                            return SizedBox.shrink();
                                          }),
                                      billViewModel.suppliers.isNotEmpty
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    AddSupplierScreen
                                                        .routeName);
                                              },
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.w),
                                                child: Icon(
                                                  Icons.add_circle,
                                                  color: AppColors.primaryColor,
                                                  size: 22.sp,
                                                ),
                                              ),
                                            )
                                          : SizedBox.shrink()
                                    ],
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio<BillType>(
                                  value: BillType.inBill,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  groupValue: bill,
                                  fillColor: bill == BillType.inBill
                                      ? MaterialStateProperty.all(
                                          AppColors.greenColor)
                                      : MaterialStateProperty.all(
                                          AppColors.blackColor),
                                  onChanged: (BillType? newValue) {
                                    setState(() {
                                      bill = newValue;
                                    });
                                  },
                                ),
                                Text(
                                  "In Bill",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: AppColors.darkPrimaryColor,
                                          fontSize: 16.sp),
                                ),
                                Radio<BillType>(
                                  value: BillType.outBill,
                                  groupValue: bill,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  fillColor: bill == BillType.outBill
                                      ? MaterialStateProperty.all(
                                          AppColors.greenColor)
                                      : MaterialStateProperty.all(
                                          AppColors.blackColor),
                                  onChanged: (BillType? newValue) {
                                    setState(() {
                                      bill = newValue;
                                    });
                                  },
                                ),
                                Text(
                                  "Out Bill",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: AppColors.darkPrimaryColor,
                                          fontSize: 16.sp),
                                )
                              ],
                            ),
                            Container(
                              width: 210.w,
                              height: 30.h,
                              margin: EdgeInsets.only(bottom: 5.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: Colors.transparent,
                                border: Border.all(
                                    color: AppColors.darkPrimaryColor),
                              ),
                              child: DropdownButton<String>(
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontSize: 18.sp,
                                        color: AppColors.primaryColor),
                                isExpanded: true,
                                borderRadius: BorderRadius.circular(15.r),
                                alignment: Alignment.center,
                                dropdownColor: AppColors.lightGreyColor,
                                underline: Container(
                                  color: Colors.transparent,
                                ),
                                padding:
                                    EdgeInsets.only(left: 10.h, right: 10.h),
                                value: "Cash",
                                items: ["Cash", "Card"]
                                    .map((e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  paymentMethod = value ?? "Cash";
                                },
                              ),
                            ),
                            Container(
                              height: 30.h,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(25.0),
                                  border: Border.all(
                                      color: AppColors.darkPrimaryColor,
                                      width: 2.w)),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = 0;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 15.w, right: 15.w),
                                      decoration: BoxDecoration(
                                        color: selectedIndex == 0
                                            ? AppColors.darkPrimaryColor
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25.r),
                                          bottomRight: Radius.circular(25.r),
                                          topRight: Radius.circular(25.r),
                                          bottomLeft: Radius.circular(25.r),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Retail",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: 16.sp,
                                              color: selectedIndex == 0
                                                  ? Colors.white
                                                  : AppColors.darkPrimaryColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = 1;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 15.w, right: 15.w),
                                      decoration: BoxDecoration(
                                        color: selectedIndex == 1
                                            ? AppColors.darkPrimaryColor
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25.r),
                                          bottomRight: Radius.circular(25.r),
                                          topRight: Radius.circular(25.r),
                                          bottomLeft: Radius.circular(25.r),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Wholesale",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: 16.sp,
                                              color: selectedIndex == 1
                                                  ? Colors.white
                                                  : AppColors.darkPrimaryColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        BlocListener(
                          bloc: billViewModel,
                          listener: (context, state) {
                            if (state is UpdateTotalBillSuccessState) {
                              totalBill = state.total!;
                            } else if (state
                                is RemoveDiscountTotalBillSuccessState) {
                              totalBill = state.total!;
                            }
                          },
                          child: InkWell(
                            onTap: () {
                              if (billViewModel.totalBill != 0) {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: AppColors.lightGreyColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                      ),
                                      title: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Add Bill Discount ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                        color: AppColors
                                                            .darkPrimaryColor,
                                                        fontSize: 27.sp),
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
                                                    color:
                                                        AppColors.whiteColor),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Form(
                                            key: billViewModel.discountFormKey,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "discount: ",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge!
                                                        .copyWith(
                                                            color: AppColors
                                                                .darkPrimaryColor,
                                                            fontSize: 25.sp),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: AddProductTextField(
                                                    controller: billViewModel
                                                        .discountTotalBill,
                                                    hintText: "0.00",
                                                    keyboardType:
                                                        TextInputType.number,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value
                                                              .trim()
                                                              .isEmpty) {
                                                        return 'please enter  discount';
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
                                                    hintText: "%",
                                                    isEnabled: true,
                                                    isDropdown: true,
                                                    dropdownValue: billViewModel
                                                                .discountTypeControllerTotalBill
                                                                .text !=
                                                            ""
                                                        ? billViewModel
                                                            .discountTypeControllerTotalBill
                                                            .text
                                                        : "%",
                                                    controller: billViewModel
                                                        .discountTypeControllerTotalBill,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          billViewModel
                                                              .discountTypeControllerTotalBill
                                                              .text
                                                              .isEmpty) {
                                                        billViewModel
                                                            .discountTypeControllerTotalBill
                                                            .text = value ?? "%";
                                                        return ("please select a type");
                                                      }
                                                      return null;
                                                    },
                                                    dropdownItems: ["%", "EGP"],
                                                    onChanged: (value) {
                                                      billViewModel
                                                          .discountTypeControllerTotalBill
                                                          .text = value ?? "%";
                                                      print(
                                                          "Selected Type: $value");
                                                    },
                                                    // dropdownValue: "cat1",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (billViewModel
                                                      .discountFormKey
                                                      .currentState!
                                                      .validate()) {
                                                    billViewModel
                                                        .discountFormKey
                                                        .currentState!
                                                        .save();
                                                    billViewModel
                                                        .updateTotalBill();

                                                    print(
                                                        'Updated Total: ${totalBill}');
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                style: ButtonStyle(
                                                    padding:
                                                        WidgetStatePropertyAll(
                                                            EdgeInsets.only(
                                                                bottom: 5.h,
                                                                top: 5.h)),
                                                    backgroundColor:
                                                        WidgetStatePropertyAll(
                                                            AppColors
                                                                .darkPrimaryColor),
                                                    shape:
                                                        WidgetStatePropertyAll(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.r)),
                                                    )),
                                                child: Text(
                                                  "Save",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                          color: AppColors
                                                              .whiteColor,
                                                          fontSize: 25.sp),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.h, vertical: 5.w),
                              width: 180.w,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  AppColors.darkPrimaryColor,
                                  AppColors.primaryColor
                                ]),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Total (${billViewModel.productsInBill.length})",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            fontSize: 18.sp,
                                            color: AppColors.whiteColor),
                                  ),
                                  Text(
                                    "  ${billViewModel.discountTotalBill.text.isEmpty ? billViewModel.totalBill : billViewModel.totalBillAfterDiscount} EGP",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            fontSize: 20.sp,
                                            color: AppColors.whiteColor),
                                  ),
                                  billViewModel.discountTotalBill.text != ""
                                      ? Text(
                                          "${billViewModel.totalBill} EGP",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontSize: 14.sp,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: AppColors.whiteColor),
                                        )
                                      : SizedBox.shrink(),
                                  billViewModel.discountTotalBill.text == ""
                                      ? Text(
                                          "+ tab to add Discount",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontSize: 14.sp,
                                                  color: AppColors.whiteColor),
                                        )
                                      : Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "discount: ${billViewModel.discountTotalBill.text} "
                                              "${billViewModel.discountTypeControllerTotalBill.text}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      fontSize: 14.sp,
                                                      color:
                                                          AppColors.whiteColor),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  billViewModel
                                                      .removeDiscountTotalBill();
                                                },
                                                child: Icon(
                                                  Icons
                                                      .remove_circle_outline_outlined,
                                                  size: 20.sp,
                                                  color: AppColors.redColor,
                                                ))
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Expanded(
                    child: BlocBuilder(
                      bloc: billViewModel..addProductToBill,
                      builder: (context, state) {
                        if (state is AddProductsInBillSuccessState) {
                          if (state.products.isNotEmpty &&
                              bill == BillType.inBill) {
                            return ListView.builder(
                              itemCount: billViewModel.productsInBill.length,
                              itemBuilder: (context, index) {
                                final product =
                                    billViewModel.productsInBill[index];
                                return BlocListener(
                                  bloc: billViewModel,
                                  listener: (context, state) {
                                    if (state is UpdateProductInBillSuccessState) {
                                      print(state.products);
                                      billViewModel.updateTotalBill();
                                      billViewModel.totalBillAfterDiscount;
                                    }
                                  },
                                  child: BillProductItem(
                                    productEntity: product,
                                    update: (p0) {
                                      billViewModel.updateProductInBill(
                                          index, p0);
                                    },
                                    remove: billViewModel.removeProductFromBill,
                                  ),
                                );
                              },
                            );
                          } else
                            return Center(
                              child: Text(
                                "No products in bill",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        fontSize: 22.sp,
                                        color: AppColors.darkPrimaryColor),
                              ),
                            );
                        }
                        if (state is AddProductsInBillErrorState) {
                          return Center(
                            child: Text(
                              state.error.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontSize: 22.sp,
                                      color: AppColors.darkPrimaryColor),
                            ),
                          );
                        }
                        if (bill == BillType.inBill &&
                            (state is UpdateProductInBillSuccessState ||
                                state is UpdateTotalBillSuccessState ||
                                state is RemoveDiscountTotalBillSuccessState)) {
                          return BlocListener(
                            bloc: billViewModel,
                            listener: (context, state) {
                              if (state is UpdateProductInBillSuccessState) {
                                print(state.products);
                                billViewModel.updateTotalBill();
                              }
                            },
                            child: ListView.builder(
                              itemCount: billViewModel.productsInBill.length,
                              itemBuilder: (context, index) {
                                final product =
                                    billViewModel.productsInBill[index];
                                return BillProductItem(
                                  productEntity: product,
                                  remove: billViewModel.removeProductFromBill,
                                  update: (p0) {
                                    billViewModel.updateProductInBill(
                                        index, p0);
                                  },
                                );
                              },
                            ),
                          );
                        }
                        return Center(
                          child: Text(
                            "No products in bill",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontSize: 22.sp,
                                    color: AppColors.darkPrimaryColor),
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 250.w,
                      margin: EdgeInsets.only(right: 10.w),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                      child: ValueListenableBuilder(
                        valueListenable: billViewModel.paidController,
                        builder: (context, paidValue, child) {
                          double paid = paidValue.text.isEmpty
                              ? 0
                              : double.parse(paidValue.text);
                          double remain =
                              billViewModel.discountTotalBill.text.isEmpty
                                  ? billViewModel.totalBill - paid
                                  : billViewModel.totalBillAfterDiscount - paid;
                          billViewModel.remain=remain;
                          print(billViewModel.remain);

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      "Paid: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontSize: 20.sp,
                                            color:
                                                billViewModel.productsInBill.isEmpty
                                                    ? AppColors.greyColor
                                                    : AppColors.greenColor,
                                          ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        cursorHeight: 15.h,
                                        cursorColor: AppColors.primaryColor,
                                        keyboardType: TextInputType.number,
                                        controller: billViewModel.paidController,
                                        enabled: billViewModel.productsInBill.isEmpty
                                            ? false
                                            : true,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0.h, horizontal: 2.w),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.primaryColor),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.primaryColor),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.primaryColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 10.w),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      "Remain:",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,

                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!

                                          .copyWith(
                                            fontSize: 20.sp,
                                            color: AppColors.greyColor,
                                          ),
                                    ),
                                    SizedBox(width: 5.w),
                                    Expanded(
                                      child: Text(
                                        "${remain.toStringAsFixed(2)}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 20.sp,
                                          color: AppColors.greyColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 8.w, right: 8.w, bottom: 10.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () async {
                                if (bill == BillType.outBill) {
                                  Navigator.pushNamed(
                                      context, AddBillScreen.routeName);
                                } else if (bill == BillType.inBill) {
                                  // Navigator.pushNamed(context, AddProductScreen.routeName,arguments:"bill");
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddProductScreen(),
                                      settings:
                                          RouteSettings(arguments: "bill"),
                                    ),
                                  );
                                  if (result is List<ProductEntity>) {
                                    setState(() {
                                      productsInBill = result;
                                      print(productsInBill);
                                      billViewModel
                                          .addProductToBill(productsInBill);
                                    });
                                  }
                                }
                              },
                              style: ButtonStyle(
                                  elevation: WidgetStatePropertyAll(5),
                                  shadowColor: WidgetStatePropertyAll(
                                      AppColors.coffeColor),
                                  padding: WidgetStatePropertyAll(
                                      EdgeInsets.only(
                                          bottom: 10.h,
                                          top: 10.h,
                                          right: 15.w,
                                          left: 15.w)),
                                  backgroundColor: WidgetStatePropertyAll(
                                      AppColors.coffeColor),
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.r)),
                                  )),
                              child: Text(
                                "Quick add",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: AppColors.whiteColor,
                                        fontSize: 20.sp),
                              )),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                              onPressed: () {
                                var bill = BillEntity(
                                    id: "",
                                    remain: billViewModel.remain,
                                    paid: double.tryParse(billViewModel.paidController.text)??0,
                                    supplierName: this.bill == BillType.inBill
                                        ? supplier!
                                        : "",
                                    customerName: this.bill == BillType.inBill
                                        ? ""
                                        : customer!,
                                    billType: this.bill ?? BillType.inBill,
                                    paymentMethod: paymentMethod,
                                    retailOrWholesale: selectedIndex == 0
                                        ? "Retail"
                                        : "Wholesale",
                                    products: billViewModel.productsInBill,
                                    discountBill: double.tryParse(billViewModel.discountTotalBill.text)??0,
                                    totalBill: billViewModel.totalBill,
                                    date: DateFormat('yyyy-MM-dd HH:mm:ss')
                                        .format(DateTime.now()),
                                    userId:
                                        FirebaseAuth.instance.currentUser!.uid);
                                final currentUser = FirebaseAuth.instance.currentUser;

                                if (currentUser != null) {
                                  billViewModel.homeTabViewModel.getBalance(currentUser.uid);
                                }
                                print(billViewModel.homeTabViewModel.myBalance);
                                if(billViewModel.homeTabViewModel.myBalance!=0){
                                  if (supplier != null &&
                                      billViewModel.productsInBill.isNotEmpty) {
                                    billViewModel.addBill(bill);
                                    billViewModel.newBalance=billViewModel.homeTabViewModel.myBalance-double.parse(billViewModel.paidController.text);

                                    billViewModel.homeTabViewModel.updateBalance(currentUser!.uid, billViewModel.newBalance);
                                    for (int i = 0;
                                    i < billViewModel.productsInBill.length;
                                    i++) {
                                      billViewModel.addProductViewModel
                                          .addProduct(productsInBill[i]);

                                    }
                                  } else {
                                    print("enter supplier or products");
                                    SnackBar(
                                      content: Text(
                                        "enter supplier or products",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                            color: AppColors.darkPrimaryColor,
                                            fontSize: 20.sp),
                                      ),
                                    );
                                  }
                                }

                              },
                              style: ButtonStyle(
                                  elevation: WidgetStatePropertyAll(5),
                                  shadowColor: WidgetStatePropertyAll(
                                      AppColors.greenColor),
                                  padding: WidgetStatePropertyAll(
                                      EdgeInsets.only(bottom: 10.h, top: 10.h)),
                                  backgroundColor: WidgetStatePropertyAll(
                                      AppColors.greenColor),
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.r)),
                                  )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Create bill",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: AppColors.whiteColor,
                                            fontSize: 20.sp),
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: AppColors.whiteColor,
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      height: 106.h,
                      decoration:
                          BoxDecoration(color: AppColors.darkPrimaryColor),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 15.w,
                          right: 15.w,
                        ),
                        child: TextFieldItem(
                          controller: searchController,

                          // change: (query) {
                          //   stockViewModel.searchProducts(query);
                          // },
                          hintText: "Search name ",
                          suffixIcon: Icon(
                            Icons.search,
                          ),
                        ),
                      )),
                ],
              ),
            ),

            if (state is AddBillSuccessState)
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: AppColors.whiteColor,
                  width: MediaQuery.of(context).size.width * 0.75,
                  // Adjust width as needed
                  height: MediaQuery.of(context).size.height,

                  padding: EdgeInsets.only(
                      right: 30.w, left: 30.w, top: 16.h, bottom: 16.h),
                  child: Column(
                    children: [
                      // Drag handle
                      Container(
                        height: 4,
                        width: 40,
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                          height: 100.h,
                          child: Image.asset(
                            "assets/images/onlylog.png",
                            fit: BoxFit.cover,
                          )),

                      Container(
                          height: 60.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              border: Border.all(
                                color: AppColors.greenColor,
                                width: 2.w,
                              ),
                              color: Colors.transparent),
                          child: Icon(
                            Icons.check,
                            size: 35.sp,
                            color: AppColors.greenColor,
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Order Completed !',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Total Bill Amount : ${billViewModel.discountController.text.isEmpty ? billViewModel.totalBill : billViewModel.totalBillAfterDiscount} EGP',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 20.sp, color: AppColors.blackColor),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      AppColors.greenColor),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.r))))),
                              icon: Icon(
                                Icons.share,
                                color: AppColors.whiteColor,
                                size: 22.sp,
                              ),
                              label: Text(
                                'Share ',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        fontSize: 20.sp,
                                        color: AppColors.whiteColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      AppColors.blackColor),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.r))))),
                              icon: Icon(
                                Icons.print,
                                color: AppColors.whiteColor,
                                size: 22.sp,
                              ),
                              label: Text(
                                'Print ',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        fontSize: 20.sp,
                                        color: AppColors.whiteColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: ()  {
                                  setState(() {
                                   Navigator.pushReplacementNamed(context, BillScreen.routeName);


                                  });
                                },
                                style: ButtonStyle(
                                    elevation: WidgetStatePropertyAll(5),
                                    shadowColor: WidgetStateColor.transparent,
                                    padding: WidgetStatePropertyAll(
                                        EdgeInsets.only(
                                            bottom: 15.h,
                                            top: 15.h,
                                            right: 15.w,
                                            left: 15.w)),
                                    backgroundColor: WidgetStatePropertyAll(
                                        AppColors.primaryColor),
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.r)),
                                    )),
                                child: Text(
                                  "Create New Bill",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: AppColors.whiteColor,
                                          fontSize: 22.sp),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () async {},
                                style: ButtonStyle(
                                    elevation: WidgetStatePropertyAll(5),
                                    padding: WidgetStatePropertyAll(
                                        EdgeInsets.only(
                                            bottom: 15.h,
                                            top: 15.h,
                                            right: 15.w,
                                            left: 15.w)),
                                    shadowColor: WidgetStateColor.transparent,
                                    backgroundColor: WidgetStatePropertyAll(
                                        AppColors.whiteColor),
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(15.r)),
                                    )),
                                child: Text(
                                  "Edit order",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: AppColors.blackColor,
                                          fontSize: 22.sp),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, Home.routeName);
                        },
                        child: Text(
                          "Go To Homepage",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  decoration: TextDecoration.underline,
                                  color: AppColors.primaryColor,
                                  fontSize: 22.sp),
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
