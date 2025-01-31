import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/cutomers/ui/view/add_customer_screen.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view/supplier_item.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view/supplier_view.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/dialog_utils.dart';
import '../../../../../../utils/text_field_item.dart';
import '../../../../home.dart';
import '../../domain/customer_di.dart';
import '../view_model/customer_states.dart';
import '../view_model/customer_view_model.dart';
import 'customer_item.dart';
import 'customer_view.dart';

class CustomersScreen extends StatelessWidget {
  static const String routeName = "customer";

  CustomersScreen({super.key});

  CustomerViewModel customerViewModel =
  CustomerViewModel(customerUseCases: injectCustomerUseCases());

  @override
  Widget build(BuildContext context) {
    customerViewModel.getCustomer();
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.darkPrimaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Home.routeName,
              (route) {
                return false;
              },
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Customers',
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

              decoration: BoxDecoration(color: AppColors.darkPrimaryColor),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                ),
                child: TextFieldItem(
                  controller: customerViewModel.search,
                  change: (query) {
                    customerViewModel.searchCustomers(query);
                  },
                  hintText: "Search in customers ",
                  suffixIcon: Icon(
                    Icons.search,
                  ),
                ),
              )),
          Expanded(
            child: BlocListener(
              bloc: customerViewModel,
              listener: (context, state) {
                if (state is RemoveCustomerLoadingState) {
                  DialogUtils.showLoading(context, "Deleting customer...");
                } else if (state is RemoveCustomerErrorState) {
                  DialogUtils.hideLoading(context);
                  DialogUtils.showMessage(context, state.error);
                } else if (state is RemoveCustomerSuccessState) {
                  DialogUtils.hideLoading(context);
                  DialogUtils.showMessage(
                      context, "Customer deleted successfully",
                      title: "Note");

                }
                else if (state is UpdateCustomerLoadingState) {
                  DialogUtils.showLoading(context, "Updating Customer...");
                } else if (state is UpdateCustomerErrorState) {
                  DialogUtils.hideLoading(context);
                  DialogUtils.showMessage(context, state.error);
                } else if (state is UpdateCustomerSuccessState) {
                  DialogUtils.hideLoading(context);
                  DialogUtils.showMessage(
                      context, "Customer updated successfully",
                      title: "Note");
                }
              },
              child: StreamBuilder<List<SupplierEntity>>(
                stream: customerViewModel.customerStreamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No Customers Found"));
                  }
                  final customers = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                            style: Theme.of(context)
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
                                  content: CustomerView(
                                   customerEntity : customers[index],
                                  ),
                                );
                              },
                            );
                          },
                          child: CustomerItem(
                            customerEntity: customers[index],
                            delete: (p0) {
                              customerViewModel.deleteCustomer(customers[index].id);
                            },
                            update: customerViewModel.updateCustomer,
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(height: 1.h),
                      itemCount: customers.length,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 16.w, bottom: 64.h),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddCustomerScreen.routeName);
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
