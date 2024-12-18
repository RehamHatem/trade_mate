import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_mate/screens/home/tabs/stock/domain/use_case/stock_use_cases.dart';
import 'package:trade_mate/screens/home/tabs/stock/ui/view_model/stock_states.dart';

import '../../../../../../utils/failures.dart';
import '../../../add_product/domain/entity/product_entity.dart';

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

}