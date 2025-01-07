import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../widgets/add_product_text_field.dart';

class EditCustomer extends StatefulWidget {
  EditCustomer({required this.update,required this.customerEntity}){

  }
  void Function(String,SupplierEntity)update;
  SupplierEntity customerEntity;

  @override
  State<EditCustomer> createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  TextEditingController customerName = TextEditingController();

  var formKey = GlobalKey<FormState>();

  TextEditingController customerPhone= TextEditingController();

  TextEditingController customerAddress = TextEditingController();

  TextEditingController customerCity = TextEditingController();

  TextEditingController customerNotes = TextEditingController();


  double total = 0.0;
  void initState() {
    super.initState();
    customerName.text = widget.customerEntity.name;
    customerPhone.text = widget.customerEntity.phone;
    customerAddress.text = widget.customerEntity.address ;
    customerCity.text = widget.customerEntity.city ;
    customerNotes.text = widget.customerEntity.notes ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return
      Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AddProductTextField(
              controller: customerName,
              fieldName: "Customer Name",
              hintText: "ex: reham",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'please enter customer name';
                }
                return null;
              },
              isEnabled: true,
            ),
            SizedBox(
              width: 5.w,
            ),
            AddProductTextField(
              hintText: "0111565585",
              controller: customerPhone,
              fieldName: "Phone",
              isEnabled: true,

              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'please enter customer phone';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Expanded(
                  child: AddProductTextField(
                    fieldName: "City",
                    hintText: "select city",
                    isEnabled: true,
                    isDropdown: true,
                    controller: customerCity,
                    dropdownValue:customerCity.text=="N/A"? null : customerCity.text,
                    validator: (value) {
                      if (value == null || customerCity.text.isEmpty ) {
                        customerCity.text = value ?? "";
                        return ("please select a city");
                      }
                      return null;
                    },
                    dropdownItems: ["Cairo", "Giza", "Alexandria"],
                    onChanged: (value) {
                      customerCity.text = value ?? "";
                      print("Selected city: $value");
                    },
                    // dropdownValue: "cat1",
                  ),
                ),
                SizedBox(width: 10
                  .w,),
                Expanded(
                  flex: 2,
                    child: AddProductTextField(
                      fieldName: "Address",
                      hintText: "address",
                      controller: customerAddress,
                      isEnabled: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter customer address';
                        }
                        return null;
                      },
                    )),
              ],
            ),



            SizedBox(
              height: 10.h,
            ),
            AddProductTextField(
              fieldName: "Notes",
              hintText: "Leave note about the customer ...",
              isEnabled: true,
              controller: customerNotes,
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
                        final updatedCustomer = SupplierEntity(id:widget.customerEntity.id,
                            name: customerName.text,
                            edited: true,
                            notes: customerNotes.text,
                            phone: customerPhone.text,
                            address: customerAddress.text,
                            city: customerCity.text,
                            date: widget.customerEntity.date,
                            userId: FirebaseAuth.instance.currentUser!.uid);
                        widget.update(widget.customerEntity.id, updatedCustomer);
                        Navigator.pop(context);

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
