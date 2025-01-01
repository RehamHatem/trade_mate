import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../widgets/add_product_text_field.dart';

class EditSupplier extends StatefulWidget {
  EditSupplier({required this.update,required this.supplierEntity}){

  }
  void Function(String,SupplierEntity)update;
  SupplierEntity supplierEntity;

  @override
  State<EditSupplier> createState() => _EditSupplierState();
}

class _EditSupplierState extends State<EditSupplier> {
  TextEditingController supplierName = TextEditingController();

  var formKey = GlobalKey<FormState>();

  TextEditingController supplierPhone= TextEditingController();

  TextEditingController supplierAddress = TextEditingController();

  TextEditingController supplierCity = TextEditingController();

  TextEditingController supplierNotes = TextEditingController();

  double total = 0.0;
  void initState() {
    super.initState();
    supplierName.text = widget.supplierEntity.name;
    supplierPhone.text = widget.supplierEntity.phone;
    supplierAddress.text = widget.supplierEntity.address ;
    supplierCity.text = widget.supplierEntity.city ;
    supplierNotes.text = widget.supplierEntity.notes ?? "";
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
              controller: supplierName,
              fieldName: "Supplier Name",
              hintText: "ex: reham",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'please enter supplier name';
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
              controller: supplierPhone,
              fieldName: "Phone",
              isEnabled: true,

              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'please enter supplier phone';
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
                    controller: supplierCity,
                    dropdownValue:supplierCity.text=="N/A"? null : supplierCity.text,
                    validator: (value) {
                      if (value == null || supplierCity.text.isEmpty ) {
                        supplierCity.text = value ?? "";
                        return ("please select a city");
                      }
                      return null;
                    },
                    dropdownItems: ["Cairo", "Giza", "Alexandria"],
                    onChanged: (value) {
                      supplierCity.text = value ?? "";
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
                      controller: supplierAddress,
                      isEnabled: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'please enter supplier address';
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
              hintText: "Leave note about the supplier ...",
              isEnabled: true,
              controller: supplierNotes,
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
                        final updatedSupplier = SupplierEntity(id:widget.supplierEntity.id,
                            name: supplierName.text,
                            edited: true,
                            notes: supplierNotes.text,
                            phone: supplierPhone.text,
                            address: supplierAddress.text,
                            city: supplierCity.text,
                            date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                            userId: FirebaseAuth.instance.currentUser!.uid);
                        widget.update(widget.supplierEntity.id, updatedSupplier);
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
