import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/use_case/supplier_use_cases.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view_model/supplier_states.dart';

import '../../../../../../utils/failures.dart';

class SupplierViewModel extends Cubit<SupplierStates> {
  SupplierViewModel({required this.supplierUseCases})
      :super(SupplierInitState());
  SupplierUseCases supplierUseCases;
  var formKey = GlobalKey<FormState>();

  var supplierName = TextEditingController();

  var supplierPhone = TextEditingController();

  var supplierAddress = TextEditingController();

  var supplierCity = TextEditingController();

  var supplierNotes = TextEditingController();
  var search = TextEditingController();
  List<SupplierEntity>suppliers = [];


  StreamController<
      List<SupplierEntity>> supplierStreamController = StreamController
      .broadcast();

  void addSupplier(SupplierEntity supplier) async {
    emit(AddSupplierLoadingState(load: "Loadin..."));
    var either = await supplierUseCases.addSupplier(supplier);
    return either.fold((l) {
      emit(AddSupplierErrorState(error: l.errorMsg!));
    }, (r) {
      emit(AddSupplierSuccessState(entity: supplier));
    },);
  }

  void getSuppliers() async {
    emit(GetSupplierLoadingState(load: "loading..."));

    supplierUseCases.getSuppliers().listen((either) {
      either.fold(
            (failure) {
          print(failure.errorMsg);
          emit(GetSupplierErrorState(error: failure.errorMsg!));
        },
            (suppliers) {
          supplierStreamController.add(suppliers);
          this.suppliers=suppliers;
          print("i'm in supviewmodel and this is the suppliers list ${this.suppliers}");
          emit(GetSupplierSuccessState(entity: suppliers));
        },
      );
    }, onError: (error) {
      print(error.toString());
      emit(GetSupplierErrorState(error: error));
    });
  }

  void searchSuppliers(String query) async {
    emit(GetSupplierLoadingState(load: "Searching suppliers..."));

    try {
      supplierUseCases.getSuppliers().listen((either) {
        either.fold(
              (failure) {
            emit(GetSupplierErrorState(error: failure.errorMsg!));
          },
              (products) {
            var filteredProducts = products
                .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()))
                .toList();

            supplierStreamController.add(
                filteredProducts); // Add filtered list to stream.
            emit(GetSupplierSuccessState(
                entity: filteredProducts)); // Emit success state.
          },
        );
      });
    } catch (e) {
      emit(GetSupplierErrorState(
          error: e.toString())); // Handle unexpected exceptions.
    }
  }

  void deleteSupplier(String id) async {
    // if (isClosed) return;
    emit(RemoveSupplierLoadingState(load: "loading..."));
    try {
      await supplierUseCases.deleteSupplier(id);
      emit(RemoveSupplierSuccessState(success: "success"));
      print("view model delete supplier success");
      // if (!isClosed) {
      //   // getProducts();
      // }
    } catch (e) {
      emit(RemoveSupplierErrorState(error: e.toString()));
      print("view model delete supplier error");
    }
  }

    void updateSupplier(String id, SupplierEntity supplier) {
      // if (isClosed) return;
      emit(UpdateSupplierLoadingState(load: "loading..."));
      try {
        supplierUseCases.updateProduct(id, supplier);
        emit(UpdateSupplierSuccessState(success: "success"));
        print("view model update product success");
        // if (!isClosed) {
        //   // getProducts();
        // }
      } catch (e) {
        emit(UpdateSupplierErrorState(error: e.toString()));
        print(e.toString());
        print("view model update product error");
      }
    }

}


  // final StreamController<List<SupplierEntity>> supplierStreamController =
  // StreamController.broadcast();
  // Stream<List<SupplierEntity>> get supplierStream => supplierStreamController.stream;
  // void addSupplier(SupplierEntity supplier){
  //   emit(AddSupplierLoadingState(load: "loading..."));
  //   try{
  //       supplierUseCases.addSupplier(supplier);
  //       suppliers.add(supplier);
  //       supplierStreamController.add(suppliers);
  //       emit(AddSupplierSuccessState(entity: supplier));
  //     print(supplier);
  //   }catch(e){
  //     emit(AddSupplierErrorState(error: e.toString()));
  //
  //   }
  // }
  // void getSuppliers() async {
  //   try {
  //     emit(GetSupplierLoadingState(load: "loading..."));
  //     final fetchedSuppliers = await supplierUseCases.getSupplier();
  //     suppliers = fetchedSuppliers;
  //     print("Fetched suppliers: $suppliers");
  //     supplierStreamController.add(suppliers); // Emit to stream
  //     emit(GetSupplierSuccessState(entity: suppliers));
  //   } catch (e) {
  //     print("Error fetching suppliers: $e");
  //     emit(GetSupplierErrorState(error: e.toString()));
  //   }
  // }
  // void searchSuppliers(String query) {
  //   final filteredSuppliers = suppliers
  //       .where((supplier) => supplier.name.toLowerCase().contains(query.toLowerCase()))
  //       .toList();
  //   supplierStreamController.add(filteredSuppliers); // Emit filtered list
  //   print("Filtered suppliers: $filteredSuppliers");
  // }
  // void removeSupplier(String index){
  //   emit(RemoveSupplierLoadingState(load: "loading.."));
  //   try{
  //     supplierUseCases.removeSupplier(index);
  //     suppliers.remove((s) => s.name == index);
  //     supplierStreamController.add(suppliers);
  //     emit(RemoveSupplierSuccessState(success: "success"));
  //
  //   }catch(e){
  //     emit(RemoveSupplierErrorState(error: e.toString()));
  //
  //   }
  // }




