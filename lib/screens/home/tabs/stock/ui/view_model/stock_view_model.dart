
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';
import 'package:trade_mate/screens/home/tabs/stock/domain/use_case/stock_use_cases.dart';
import 'package:trade_mate/screens/home/tabs/stock/ui/view_model/stock_states.dart';

import '../../../../../../utils/failures.dart';
import '../../../suppliers/domain/entity/supplier_entity.dart';
import '../../../suppliers/domain/supplier_di.dart';
import '../../../suppliers/ui/view_model/supplier_view_model.dart';

class StockViewModel extends Cubit<StockStates>{
  StockViewModel({required this.stockUseCases}):super(StockInitState());
  StockUseCases stockUseCases;
  var search= TextEditingController();
   StreamController<List<ProductEntity>> productStreamController = StreamController.broadcast();
  List<SupplierEntity>suppliers=[];
  SupplierViewModel supplierViewModel=SupplierViewModel(supplierUseCases: injectSupplierUseCases());

  void getProducts() async {

    emit(StockLoadingState(load: "loading..."));

    stockUseCases.getProducts().listen((either) {
      either.fold(
            (failure) {
              print(failure.errorMsg);
          emit(StockErrorState(error: failure));
        },
            (products) {
          productStreamController.add(products);
          emit(StockSuccessState(products: products));
        },
      );
    }, onError: (error) {
      print(error.toString());
      emit(StockErrorState(error: error));
    });
  }

  void searchProducts(String query) async {
    emit(StockLoadingState(load: "Searching products..."));

    try {
      stockUseCases.getProducts().listen((either) {
        either.fold(
              (failure) {
            emit(StockErrorState(error: failure)); 
          },
              (products) {
            var filteredProducts = products
                .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()))
                .toList();

            productStreamController.add(filteredProducts); // Add filtered list to stream.
            emit(StockSuccessState(products: filteredProducts)); // Emit success state.
          },
        );
      });
    } catch (e) {
      emit(StockErrorState(error: NetworkError(errorMsg: e.toString()))); // Handle unexpected exceptions.
    }
  }

  void deleteProduct(String id)async{
    // if (isClosed) return;
    emit(DeleteProductLoadingState(load: "loading..."));
    try{
      await stockUseCases.deleteProduct(id);
      emit(DeleteProductSuccessState(success: "success"));
      print("view model delete product success");
      // if (!isClosed) {
      //   // getProducts();
      // }
    }catch(e){
      emit(DeleteProductErrorState(error: e.toString()));
      print("view model delete product error");
    }
  }
  void updateProduct(String id, ProductEntity product){
    // if (isClosed) return;
    emit(UpdateProductLoadingState(load: "loading..."));
    try{
      stockUseCases.updateProduct(id, product);
      emit(UpdateProductSuccessState(success: "success"));
      print("view model update product success");
      // if (!isClosed) {
      //   // getProducts();
      // }
    }catch(e){
      emit(UpdateProductErrorState(error: e.toString()));
      print(e.toString());
      print("view model update product error");
    }
  }

}



