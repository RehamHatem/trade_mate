import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/entity/bill_entity.dart';
import 'package:trade_mate/screens/home/tabs/orders/domain/use_case/orders_use_cases.dart';
import 'package:trade_mate/screens/home/tabs/orders/ui/view_model/orders_states.dart';

class OrdersViewModel extends Cubit<OrdersStates>{
  OrdersViewModel({required this.ordersUseCases}):super(OrdersInitState());
  OrdersUseCases ordersUseCases;
  List<BillEntity>bills = [];
  var search = TextEditingController();


  StreamController<List<BillEntity>> orderStreamController = StreamController.broadcast();
  StreamController<List<BillEntity>> npaidOrderStreamController = StreamController.broadcast();
  StreamController<List<BillEntity>> completedOrderStreamController = StreamController.broadcast();
  void getOrders() async {
    emit(GetOrdersLoadingState(load: "loading..."));
    ordersUseCases.getBills().listen((either) {
      either.fold(
            (failure) {
          print(failure.errorMsg);
          emit(GetOrdersErrorState(error: failure.errorMsg!));
        },
            (bills) {
              orderStreamController.add(bills);
          this.bills=bills;
              final unpaidOrders = bills.where((bill) => bill.remain != 0).toList();
              npaidOrderStreamController.add(unpaidOrders);
              final completedOrders = bills.where((bill) => bill.remain == 0).toList();
              completedOrderStreamController.add(completedOrders);
          print("i'm in supviewmodel and this is the suppliers list ${this.bills}");
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

            orderStreamController.add(
                filteredOrders); // Add filtered list to stream.
            emit(GetOrdersSuccessState(
                bills: filteredOrders)); // Emit success state.
          },
        );
      });
    } catch (e) {
      emit(GetOrdersErrorState(
          error: e.toString())); // Handle unexpected exceptions.
    }
  }

  void deleteOrder(String id) async {
    // if (isClosed) return;
    emit(RemoveOrderLoadingState(load: "loading..."));
    try {
      await ordersUseCases.deleteBill(id);
      emit(RemoveOrderSuccessState(success: "success"));
      print("view model delete supplier success");
      // if (!isClosed) {
      //   // getProducts();
      // }
    } catch (e) {
      emit(RemoveOrderErrorState(error: e.toString()));
      print("view model delete supplier error");
    }
  }

  void updateOrder(String id, BillEntity bill) {
    // if (isClosed) return;
    emit(UpdateOrderLoadingState(load: "loading..."));
    try {
      ordersUseCases.updateBill(id, bill);
      emit(UpdateOrderSuccessState(bill: bill));
      print("view model update supplier success");
      // if (!isClosed) {
      //   // getProducts();
      // }
    } catch (e) {
      emit(UpdateOrderErrorState(error: e.toString()));
      print(e.toString());
      print("view model update product error");
    }
  }
}