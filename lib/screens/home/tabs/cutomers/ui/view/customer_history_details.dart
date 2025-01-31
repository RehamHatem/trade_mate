import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/cutomers/domain/customer_di.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../bill/domain/entity/bill_entity.dart';
import '../../../orders/ui/view/bill_view.dart';
import '../../../orders/ui/view/order_item.dart';
import '../../../suppliers/domain/entity/supplier_entity.dart';
import '../view_model/customer_view_model.dart';

class CustomerHistoryDetails extends StatelessWidget {
  static const String routeName="customerHistory";
   CustomerHistoryDetails({super.key});
  CustomerViewModel customerViewModel=CustomerViewModel(customerUseCases: injectCustomerUseCases());
  @override
  Widget build(BuildContext context) {
    var customer=ModalRoute.of(context)!.settings.arguments as SupplierEntity;
    customerViewModel.ordersViewModel.getCustomerOrders(customer.name);
    customerViewModel.ordersViewModel.homeTabViewModel.getBalance( FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.darkPrimaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          '${customer.name} history',
          maxLines: 2,
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
                child:
                Padding(
                  padding: EdgeInsets.only(
                      left: 15.w,
                      right: 15.w,
                      bottom: 15.h,
                      top: 15.h
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${customer.name} | ${customer.phone} | ${customer.city}",
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: AppColors.whiteColor.withOpacity(.8)
                            ,fontSize: 22.sp,overflow: TextOverflow.ellipsis ),),
                      Text("Should give ${customerViewModel.ordersViewModel.customerShouldGive.toStringAsFixed(2)} EGP",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.greenColor.withOpacity(.8)
                            ,fontSize: 22.sp,overflow: TextOverflow.ellipsis ),)
                    ],
                  ),
                )),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: [
            //         FilterButton(
            //           label: "All",
            //           isSelected: ordersViewModel.selectedButton == "All",
            //           onPressed: () {
            //             setState(() {
            //               ordersViewModel.selectedButton = "All";
            //               ordersViewModel.getOrders();
            //             });
            //           },
            //         ),
            //         SizedBox(width: 10),
            //         FilterButton(
            //           label: "Not Paid (${ordersViewModel.notPaidCount})",
            //           isSelected: ordersViewModel.selectedButton == "Not Paid",
            //           onPressed: () {
            //             setState(() {
            //               ordersViewModel.selectedButton = "Not Paid";
            //               ordersViewModel.getOrders();
            //             });
            //           },
            //         ),
            //         SizedBox(width: 10),
            //         FilterButton(
            //           label: "Completed (${ordersViewModel.completedCount})",
            //           isSelected: ordersViewModel.selectedButton == "Completed",
            //           onPressed: () {
            //             setState(() {
            //               ordersViewModel.selectedButton = "Completed";
            //               ordersViewModel.getOrders();
            //             });
            //           },
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Expanded(
              child: StreamBuilder<List<BillEntity>>(
                stream: customerViewModel.ordersViewModel.customerOrderStreamController.stream,
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
                            customerViewModel.ordersViewModel.deleteOrder(p0);
                          },update: (id, bill) {
                            customerViewModel.ordersViewModel.updateOrder(id, bill);
                          },ordersViewModel:  customerViewModel.ordersViewModel,
                            collectMoney:  customerViewModel.ordersViewModel.collectMoney,
                            payMoney:  customerViewModel.ordersViewModel.payMoney,),
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(height: 1.h),
                      itemCount: orders.length,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}
