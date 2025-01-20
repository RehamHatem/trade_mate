import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/entity/bill_entity.dart';
import 'package:trade_mate/screens/home/tabs/orders/domain/orders_di.dart';
import 'package:trade_mate/screens/home/tabs/orders/ui/view_model/orders_view_model.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/dialog_utils.dart';
import '../../../../../../utils/text_field_item.dart';
import '../../../../home.dart';
import '../view_model/orders_states.dart';
import 'filterd_button.dart';
import 'order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName="order";
   OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
OrdersViewModel ordersViewModel=OrdersViewModel(ordersUseCases: injectOrdersUseCases());

  String selectedButton = "All";

  @override
  Widget build(BuildContext context) {
    ordersViewModel.getOrders();
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
          'Orders',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: AppColors.whiteColor),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.only(bottom: 8.h),
        child: Column(
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
                    controller: ordersViewModel.search,
                    change: (query) {
                      ordersViewModel.searchOrders(query);
                    },
                    hintText: "Search in orders ",
                    suffixIcon: Icon(
                      Icons.search,
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterButton(
                      label: "All",
                      isSelected: selectedButton == "All",
                      onPressed: () {
                        setState(() {
                          selectedButton = "All";
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    // FilterButton(
                    //   label: "Delivery",
                    //   isSelected: selectedButton == "Delivery",
                    //   onPressed: () {
                    //     setState(() {
                    //       selectedButton = "Delivery";
                    //     });
                    //   },
                    // ),
                    // SizedBox(width: 10),
                    // FilterButton(
                    //   label: "Pickup",
                    //   isSelected: selectedButton == "Pickup",
                    //   onPressed: () {
                    //     setState(() {
                    //       selectedButton = "Pickup";
                    //     });
                    //   },
                    // ),
                    // SizedBox(width: 10),
                    FilterButton(
                      label: "Not Paid",
                      isSelected: selectedButton == "Not Paid",
                      onPressed: () {
                        setState(() {
                          selectedButton = "Not Paid";
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    FilterButton(
                      label: "Completed",
                      isSelected: selectedButton == "Completed",
                      onPressed: () {
                        setState(() {
                          selectedButton = "Completed";
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: BlocListener(
                bloc: ordersViewModel,
                listener: (context, state) {
                  if (state is RemoveOrderLoadingState) {
                    DialogUtils.showLoading(context, "Deleting Order...");
                  } else if (state is RemoveOrderErrorState) {
                    DialogUtils.hideLoading(context);
                    DialogUtils.showMessage(context, state.error);
                  } else if (state is RemoveOrderSuccessState) {
                    DialogUtils.hideLoading(context);
                    DialogUtils.showMessage(
                        context, "Order deleted successfully",
                        title: "Note");

                  }
                  else if (state is UpdateOrderLoadingState) {
                    DialogUtils.showLoading(context, "Updating Order...");
                  } else if (state is UpdateOrderErrorState) {
                    DialogUtils.hideLoading(context);
                    DialogUtils.showMessage(context, state.error);
                  } else if (state is UpdateOrderSuccessState) {
                    DialogUtils.hideLoading(context);
                    DialogUtils.showMessage(
                        context, "Order updated successfully",
                        title: "Note");
                  }
                },
                child: StreamBuilder<List<BillEntity>>(
                  stream: selectedButton=="All"?ordersViewModel.orderStreamController.stream:selectedButton=="Not Paid"?
                  ordersViewModel.npaidOrderStreamController.stream:ordersViewModel.completedOrderStreamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("No Orders Found"));
                    }
                    final orders = snapshot.data!;
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
                                    // content: SupplierView(
                                    //   supplierEntity: suppliers[index],
                                    // ),
                                  );
                                },
                              );
                            },
                            child: OrderItem(billEntity:orders[index] ,delete: (p0) {
                              ordersViewModel.deleteOrder(p0);
                            },),
                          );
                        },
                        separatorBuilder: (_, __) => SizedBox(height: 1.h),
                        itemCount: orders.length,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
