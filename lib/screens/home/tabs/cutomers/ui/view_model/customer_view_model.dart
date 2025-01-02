import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/use_case/supplier_use_cases.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view_model/supplier_states.dart';

import '../../../../../../utils/failures.dart';
import '../../domain/use_case/customer_use_cases.dart';
import 'customer_states.dart';

class CustomerViewModel extends Cubit<CustomerStates> {
  CustomerViewModel({required this.customerUseCases})
      :super(CustomerInitState());
  CustomerUseCases customerUseCases;
  var formKey = GlobalKey<FormState>();

  var customerName = TextEditingController();

  var customerPhone = TextEditingController();

  var customerAddress = TextEditingController();

  var customerCity = TextEditingController();

  var customerNotes = TextEditingController();
  var search = TextEditingController();
  List<SupplierEntity>customers = [];


  StreamController<
      List<SupplierEntity>> customerStreamController = StreamController
      .broadcast();

  void addCustomer(SupplierEntity customer) async {
    emit(AddCustomerLoadingState(load: "Loadin..."));
    var either = await customerUseCases.addCustomer(customer);
    return either.fold((l) {
      emit(AddCustomerErrorState(error: l.errorMsg!));
    }, (r) {
      emit(AddCustomerSuccessState(entity: customer));
    },);
  }

  void getCustomer() async {
    emit(GetCustomerLoadingState(load: "loading..."));

    customerUseCases.getCustomers().listen((either) {
      either.fold(
            (failure) {
          print(failure.errorMsg);
          emit(GetCustomerErrorState(error: failure.errorMsg!));
        },
            (customers) {
              customerStreamController.add(customers);
          this.customers=customers;
          print("i'm in cusviewmodel and this is the customers list ${this.customers}");
          emit(GetCustomerSuccessState(entity: customers));
        },
      );
    }, onError: (error) {
      print(error.toString());
      emit(GetCustomerErrorState(error: error));
    });
  }

  void searchCustomers(String query) async {
    emit(GetCustomerLoadingState(load: "Searching Customers..."));

    try {
      customerUseCases.getCustomers().listen((either) {
        either.fold(
              (failure) {
            emit(GetCustomerErrorState(error: failure.errorMsg!));
          },
              (customers) {
            var filteredCustomers = customers
                .where((customer) =>
                customer.name.toLowerCase().contains(query.toLowerCase()))
                .toList();

            customerStreamController.add(
                filteredCustomers); // Add filtered list to stream.
            emit(GetCustomerSuccessState(
                entity: filteredCustomers)); // Emit success state.
          },
        );
      });
    } catch (e) {
      emit(GetCustomerErrorState(
          error: e.toString())); // Handle unexpected exceptions.
    }
  }

  void deleteCustomer(String id) async {
    // if (isClosed) return;
    emit(RemoveCustomerLoadingState(load: "loading..."));
    try {
      await customerUseCases.deleteCustomer(id);
      emit(RemoveCustomerSuccessState(success: "success"));
      print("view model delete Customer success");
      // if (!isClosed) {
      //   // getProducts();
      // }
    } catch (e) {
      emit(RemoveCustomerErrorState(error: e.toString()));
      print("view model delete Customer error");
    }
  }

    void updateCustomer(String id, SupplierEntity customer) {
      // if (isClosed) return;
      emit(UpdateCustomerLoadingState(load: "loading..."));
      try {
        customerUseCases.updateCustomer(id, customer);
        emit(UpdateCustomerSuccessState(success: "success"));
        print("view model update Customer success");
        // if (!isClosed) {
        //   // getProducts();
        // }
      } catch (e) {
        emit(UpdateCustomerErrorState(error: e.toString()));
        print(e.toString());
        print("view model update Customer error");
      }
    }

}


