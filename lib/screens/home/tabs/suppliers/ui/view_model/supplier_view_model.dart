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

  void addSupplier(SupplierEntity supplier){
    emit(AddSupplierLoadingState(load: "loading..."));
    try{
        supplierUseCases.addSupplier(supplier);
      emit(AddSupplierSuccessState(entity: supplier));
      print(supplier);
    }catch(e){
      emit(AddSupplierErrorState(error: e.toString()));

    }
  }
  void getSuppliers()async{
    emit(GetSupplierLoadingState(load: "loading..."));
    try{
      suppliers = await supplierUseCases.getSupplier();
      emit(GetSupplierSuccessState(entity: suppliers));

    }catch(e){
      emit(GetSupplierErrorState(error: e.toString()));

    }
  }


}