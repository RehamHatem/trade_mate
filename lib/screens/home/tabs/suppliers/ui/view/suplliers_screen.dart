import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view/supplier_item.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view_model/supplier_view_model.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/dialog_utils.dart';
import '../../../../../../utils/text_field_item.dart';
import '../../domain/supplier_di.dart';
import '../view_model/supplier_states.dart';
import 'add_supplier_screen.dart';

class SuplliersScreen extends StatelessWidget {
  static const String routeName="supplier";
   SuplliersScreen({super.key});
SupplierViewModel supplierViewModel=SupplierViewModel(supplierUseCases: injectSupplierUseCases());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.darkPrimaryColor,
        title: Text(
          'Suppliers',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: AppColors.whiteColor),
        ),
      ),
      body: Column(
        children: [
          Container(
              width: double.infinity,
              height: 110.h,
              decoration: BoxDecoration(color: AppColors.darkPrimaryColor),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                ),
                child: TextFieldItem(
                  controller: supplierViewModel.search,
                  change: (query) {
                    // stockViewModel.searchProducts(query);
                  },
                  hintText: "Search in suppliers ",
                  suffixIcon: Icon(
                    Icons.search,
                  ),
                ),
              )),
          Expanded(
            child: BlocProvider(
              create: (context) => supplierViewModel..getSuppliers(),
              child: BlocBuilder<SupplierViewModel, SupplierStates>(
                  builder: (context, state) {
                    if (state is GetSupplierLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is GetSupplierErrorState) {
                      print(state.error);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text("Something went wrong: ${state.error}"),

                          ElevatedButton(
                            onPressed: () =>
                                context.read<SupplierViewModel>().getSuppliers(),
                            child: const Text("Try Again"),
                          ),
                        ],
                      );
                    }

                    if (state is GetSupplierSuccessState) {
                      supplierViewModel.suppliers = state.entity;

                      if (supplierViewModel.suppliers.isEmpty) {
                        return const Center(child: Text("No Products Found"));
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.separated(
                          itemBuilder: (context, index) {

                            return InkWell(
                              onTap: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: AppColors.lightGreyColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.r),
                                      ),
                                      title: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Details",
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                    color: AppColors
                                                        .darkPrimaryColor),
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
                                                    color: AppColors.whiteColor),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: AppColors.darkPrimaryColor,
                                          )
                                        ],
                                      ),
                                      alignment: Alignment.center,

                                    );
                                  },
                                );
                              },
                              child: SupplierItem(supplierEntity:supplierViewModel.suppliers[index] ,),
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(height: 1.h),
                          itemCount: supplierViewModel.suppliers.length,
                        ),
                      );
                    }
                    return Container();
                  }
              ),
            ),
          ),


        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 16.w, bottom: 64.h),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddSupplierScreen.routeName);
          },
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
          child: Icon(
            Icons.add,
            size: 35.sp,
            color: AppColors.whiteColor,
          ),
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
        ),
      ),
    );
  }
}
