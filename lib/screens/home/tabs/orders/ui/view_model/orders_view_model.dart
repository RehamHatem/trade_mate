import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/entity/bill_entity.dart';
import 'package:trade_mate/screens/home/tabs/bill/ui/view/bill_tab.dart';
import 'package:trade_mate/screens/home/tabs/home_tab/domain/home_tab_di.dart';
import 'package:trade_mate/screens/home/tabs/home_tab/ui/view_model/home_tab_view_model.dart';
import 'package:trade_mate/screens/home/tabs/orders/domain/use_case/orders_use_cases.dart';
import 'package:trade_mate/screens/home/tabs/orders/ui/view_model/orders_states.dart';

class OrdersViewModel extends Cubit<OrdersStates>{
  OrdersViewModel({required this.ordersUseCases}):super(OrdersInitState());
  OrdersUseCases ordersUseCases;
  List<BillEntity>bills = [];
  var search = TextEditingController();
  String selectedButton = "All";
  int notPaidCount = 0;
  int completedCount = 0;
  double youWillPay=0;
  double youWillGet=0;
  double newBalance=0;
  var payOrCollectController=TextEditingController();

  StreamController<List<BillEntity>> orderStreamController = StreamController.broadcast();
  StreamController<List<BillEntity>> npaidOrderStreamController = StreamController.broadcast();
  StreamController<List<BillEntity>> completedOrderStreamController = StreamController.broadcast();
  StreamController<List<BillEntity>> supplierOrderStreamController = StreamController.broadcast();
  StreamController<List<BillEntity>> customerOrderStreamController = StreamController.broadcast();
  HomeTabViewModel homeTabViewModel=HomeTabViewModel(homeTabUseCases: injectHomeTabUseCases());
  double supplierShouldReceive=0;
  double customerShouldGive=0;
  void getOrders() async {
    emit(GetOrdersLoadingState(load: "loading..."));
    ordersUseCases.getBills().listen((either) {
      either.fold(
            (failure) {
          print(failure.errorMsg);
          emit(GetOrdersErrorState(error: failure.errorMsg!));
        },
            (bills) {
              if (!orderStreamController.isClosed) {
                orderStreamController.add(bills);
              }
          this.bills=bills;
              final unpaidOrders = bills.where((bill) => bill.remain != 0).toList();
              if (!npaidOrderStreamController.isClosed) {
                npaidOrderStreamController.add(unpaidOrders);
              }
              final completedOrders = bills.where((bill) => bill.remain == 0).toList();
              if (!completedOrderStreamController.isClosed) {
                completedOrderStreamController.add(completedOrders);
              }
              final inBills = bills.where((bill) => bill.billType == BillType.inBill).toList();
              youWillPay = inBills.fold(0, (sum, bill) => sum + bill.remain);

              final outBills = bills.where((bill) => bill.billType ==BillType.outBill).toList();
              youWillGet = outBills.fold(0, (sum, bill) => sum + bill.remain);

          emit(GetOrdersSuccessState(bills: bills));
        },
      );
    }, onError: (error) {
      print(error.toString());
      emit(GetOrdersErrorState(error: error));
    });
  }

  void searchOrders(String query) async {
    emit(GetOrdersLoadingState(load: "Searching suppliers..."));

    try {

      ordersUseCases.getBills().listen((either) {
        either.fold(
              (failure) {
            emit(GetOrdersErrorState(error: failure.errorMsg!));
          },
              (orders) {
            var filteredOrders = orders
                .where((order) =>
              order.supplierName==""? order.customerName.toLowerCase().contains(query.toLowerCase()): order.supplierName.toLowerCase().contains(query.toLowerCase()))
                .toList();
            if(selectedButton=="All"){
              orderStreamController.add(
                  filteredOrders);
            }else if(selectedButton=="Not Paid"){
              npaidOrderStreamController.add(
                  filteredOrders);
            }
            else if(selectedButton=="Completed"){
              completedOrderStreamController.add(
                  filteredOrders);
            }


            emit(GetOrdersSuccessState(
                bills: filteredOrders));
          },
        );
      });
    } catch (e) {
      emit(GetOrdersErrorState(
          error: e.toString())); // Handle unexpected exceptions.
    }
  }

  void deleteOrder(String id) async {
    emit(RemoveOrderLoadingState(load: "loading..."));
    try {
      await ordersUseCases.deleteBill(id);

      emit(RemoveOrderSuccessState(success: "success"));

    } catch (e) {
      emit(RemoveOrderErrorState(error: e.toString()));
    }
  }

  void updateOrder(String id, BillEntity bill) {
    emit(UpdateOrderLoadingState(load: "loading..."));
    try {
      ordersUseCases.updateBill(id, bill);
      emit(UpdateOrderSuccessState(bill: bill));

    } catch (e) {
      emit(UpdateOrderErrorState(error: e.toString()));}
  }
  void collectMoney(){
    newBalance=homeTabViewModel.myBalance + double.parse(payOrCollectController.text);
   homeTabViewModel.updateBalance(FirebaseAuth.instance.currentUser!.uid, newBalance);
  }
  void payMoney(){
   newBalance=homeTabViewModel.myBalance - double.parse(payOrCollectController.text);
    homeTabViewModel.updateBalance(FirebaseAuth.instance.currentUser!.uid, newBalance);
  }
  void getSupplierOrders(String supplierName) {
    emit(GetOrdersLoadingState(load: "Fetching supplier orders..."));

    try {
      ordersUseCases.getBills().listen((either) {
        either.fold(
              (failure) {
            emit(GetOrdersErrorState(error: failure.errorMsg!));
          },
              (orders) {
            var supplierOrders = orders
                .where((orders) => orders.supplierName == supplierName)
                .toList();
            supplierShouldReceive = supplierOrders.fold(0, (sum, bill) => sum + bill.remain);
            supplierOrderStreamController.add(supplierOrders);

            emit(GetOrdersSuccessState(bills: supplierOrders));
          },
        );
      });
    } catch (e) {
      emit(GetOrdersErrorState(error: e.toString()));
    }
  }
  void getCustomerOrders(String customerName) {
    emit(GetOrdersLoadingState(load: "Fetching customer orders..."));

    try {
      ordersUseCases.getBills().listen((either) {
        either.fold(
              (failure) {
            emit(GetOrdersErrorState(error: failure.errorMsg!));
          },
              (orders) {
            var customerOrders = orders
                .where((orders) => orders.customerName == customerName)
                .toList();
            customerShouldGive = customerOrders.fold(0, (sum, bill) => sum + bill.remain);
            customerOrderStreamController.add(customerOrders);

            emit(GetOrdersSuccessState(bills: customerOrders));
          },
        );
      });
    } catch (e) {
      emit(GetOrdersErrorState(error: e.toString()));
    }
  }





}