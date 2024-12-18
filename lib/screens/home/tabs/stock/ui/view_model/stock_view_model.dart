
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';
import 'package:trade_mate/screens/home/tabs/stock/domain/use_case/stock_use_cases.dart';
import 'package:trade_mate/screens/home/tabs/stock/ui/view_model/stock_states.dart';

import '../../../../../../utils/failures.dart';

class StockViewModel extends Cubit<StockStates>{
  StockViewModel({required this.stockUseCases}):super(StockInitState());
  StockUseCases stockUseCases;
  var search= TextEditingController();
  void getProducts() async {

    emit(StockLoadingState(load: "loading..."));

    try {
      await for (final result in stockUseCases.getProducts()) {

        result.fold(
              (failure) => emit(StockErrorState(error: failure)),
              (products) => emit(StockSuccessState(products: products)),
        );
      }
    } catch (error) {

        emit(StockErrorState(error: Failures(errorMsg: error.toString())));
    }
  }
  void deleteProduct(String id)async{
    if (isClosed) return;
    emit(DeleteProductLoadingState(load: "loading..."));
    try{
      await stockUseCases.deleteProduct(id);
      emit(DeleteProductSuccessState(success: "success"));
      print("view model delete product success");
      if (!isClosed) {
        // getProducts();
      }
    }catch(e){
      emit(DeleteProductErrorState(error: e.toString()));
      print("view model delete product error");
    }
  }
  void updateProduct(String id, ProductEntity product)async{
    if (isClosed) return;
    emit(UpdateProductLoadingState(load: "loading..."));
    try{
      await stockUseCases.updateProduct(id, product);
      emit(UpdateProductSuccessState(success: "success"));
      print("view model update product success");
      if (!isClosed) {
        // getProducts();
      }
    }catch(e){
      emit(UpdateProductErrorState(error: e.toString()));
      print("view model update product error");
    }
  }

}