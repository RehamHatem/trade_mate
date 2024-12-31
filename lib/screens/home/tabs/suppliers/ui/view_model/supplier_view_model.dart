import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/use_case/supplier_use_cases.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view_model/supplier_states.dart';

class SupplierViewModel extends Cubit<SupplierStates>{
  SupplierViewModel({required this.supplierUseCases}):super(SupplierInitState());
  SupplierUseCases supplierUseCases;
  var formKey=GlobalKey<FormState>();

  var supplierName=TextEditingController();

  var supplierPhone=TextEditingController();

  var supplierAddress=TextEditingController();

  var supplierCity=TextEditingController();

  var supplierNotes=TextEditingController();
  var search =TextEditingController();
 List<SupplierEntity>suppliers=[];
  final StreamController<List<SupplierEntity>> supplierStreamController =
  StreamController.broadcast();
  Stream<List<SupplierEntity>> get supplierStream => supplierStreamController.stream;
  void addSupplier(SupplierEntity supplier){
    emit(AddSupplierLoadingState(load: "loading..."));
    try{
        supplierUseCases.addSupplier(supplier);
        suppliers.add(supplier);
        supplierStreamController.add(suppliers);
        emit(AddSupplierSuccessState(entity: supplier));
      print(supplier);
    }catch(e){
      emit(AddSupplierErrorState(error: e.toString()));

    }
  }
  void getSuppliers() async {
    try {
      emit(GetSupplierLoadingState(load: "loading..."));
      final fetchedSuppliers = await supplierUseCases.getSupplier();
      suppliers = fetchedSuppliers;
      print("Fetched suppliers: $suppliers");
      supplierStreamController.add(suppliers); // Emit to stream
      emit(GetSupplierSuccessState(entity: suppliers));
    } catch (e) {
      print("Error fetching suppliers: $e");
      emit(GetSupplierErrorState(error: e.toString()));
    }
  }
  void searchSuppliers(String query) {
    final filteredSuppliers = suppliers
        .where((supplier) => supplier.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    supplierStreamController.add(filteredSuppliers); // Emit filtered list
    print("Filtered suppliers: $filteredSuppliers");
  }
  void removeSupplier(String index){
    emit(RemoveSupplierLoadingState(load: "loading.."));
    try{
      supplierUseCases.removeSupplier(index);
      suppliers.remove((s) => s.name == index);
      supplierStreamController.add(suppliers);
      emit(RemoveSupplierSuccessState(success: "success"));

    }catch(e){
      emit(RemoveSupplierErrorState(error: e.toString()));

    }
  }




}