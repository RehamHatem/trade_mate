
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
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
import 'bill_view.dart';
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


StreamSubscription? unpaidOrdersSubscription;
StreamSubscription? completedOrdersSubscription;

@override
void initState() {
  super.initState();
  ordersViewModel.getOrders();
  ordersViewModel.homeTabViewModel.getBalance( FirebaseAuth.instance.currentUser!.uid);


  unpaidOrdersSubscription=ordersViewModel.npaidOrderStreamController.stream.listen((bills) {
    if (mounted) {
    setState(() {
      ordersViewModel. notPaidCount = bills.length;
    });}
  });
  completedOrdersSubscription=ordersViewModel.completedOrderStreamController.stream.listen((bills) {
    if (mounted) {
      setState(() {
        ordersViewModel.completedCount = bills.length;
      });
    }
  });
}
@override
void dispose() {
ordersViewModel.npaidOrderStreamController.close();
ordersViewModel.completedOrderStreamController.close();
ordersViewModel.orderStreamController.close();


  unpaidOrdersSubscription?.cancel();
  completedOrdersSubscription?.cancel();
  super.dispose();

}




@override
  Widget build(BuildContext context) {
    // ordersViewModel.getOrders();
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

                decoration: BoxDecoration(color: AppColors.darkPrimaryColor),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 15.w,
                    right: 15.w,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h,),
                      BlocListener(
                        bloc: ordersViewModel,
                        listener: (context, state) {

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 30.w,right: 30.w,bottom: 20.h,top: 20.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: AppColors.whiteColor,

                                ),
                                child: Column(children: [
                                  Text(
                                    "You will give",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                        color: AppColors.redColor,
                                        fontSize: 16.sp,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  Text(
                                    "EGP ${ordersViewModel.youWillPay.toStringAsFixed(2)}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                        color: AppColors.darkPrimaryColor,
                                        fontSize: 20.sp,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],),
                              ),
                            ),
                            SizedBox(width: 10.w,),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 30.w,right: 30.w,bottom: 20.h,top: 20.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: AppColors.whiteColor,

                                ),
                                child: Column(children: [
                                  Text(
                                    "You will get",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                        color: AppColors.greenColor,
                                        fontSize: 16.sp,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  Text(
                                    "EGP ${ordersViewModel.youWillGet.toStringAsFixed(2)}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                        color: AppColors.darkPrimaryColor,
                                        fontSize: 20.sp,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextFieldItem(
                        controller: ordersViewModel.search,
                        change: (query) {
                          ordersViewModel.searchOrders(query);
                        },
                        hintText: "Search in orders ",
                        suffixIcon: Icon(
                          Icons.search,
                        ),
                      ),
                    ],
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
                      isSelected: ordersViewModel.selectedButton == "All",
                      onPressed: () {
                        setState(() {
                          ordersViewModel.selectedButton = "All";
                          ordersViewModel.getOrders();
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    FilterButton(
                      label: "Not Paid (${ordersViewModel.notPaidCount})",
                      isSelected: ordersViewModel.selectedButton == "Not Paid",
                      onPressed: () {
                        setState(() {
                          ordersViewModel.selectedButton = "Not Paid";
                          ordersViewModel.getOrders();
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    FilterButton(
                      label: "Completed (${ordersViewModel.completedCount})",
                      isSelected: ordersViewModel.selectedButton == "Completed",
                      onPressed: () {
                        setState(() {
                          ordersViewModel.selectedButton = "Completed";
                          ordersViewModel.getOrders();
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
                  stream: ordersViewModel.selectedButton=="All"?ordersViewModel.orderStreamController.stream:ordersViewModel.selectedButton=="Not Paid"?
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
                                    content: BillView(
                                      billEntity: orders[index],
                                    ),
                                  );
                                },
                              );
                            },
                            child: OrderItem(billEntity:orders[index] ,delete: (p0) {
                              ordersViewModel.deleteOrder(p0);
                            },update: (id, bill) {
                              ordersViewModel.updateOrder(id, bill);
                            },ordersViewModel: ordersViewModel,
                            collectMoney: ordersViewModel.collectMoney,
                            payMoney: ordersViewModel.payMoney,),
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
