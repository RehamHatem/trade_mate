import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/use_case/add_product_use_case.dart';
import 'package:trade_mate/screens/home/tabs/add_product/ui/view_model/add_product_states.dart';
import 'package:trade_mate/screens/home/tabs/categories/domain/category_di.dart';
import 'package:trade_mate/screens/home/tabs/categories/domain/entity/category_entity.dart';
import 'package:trade_mate/screens/home/tabs/categories/ui/view_model/categories_view_model.dart';

import '../../../suppliers/domain/entity/supplier_entity.dart';
import '../../../suppliers/domain/supplier_di.dart';
import '../../../suppliers/ui/view_model/supplier_view_model.dart';

class AddProductViewModel extends Cubit<AddProductStates>{
  AddProductViewModel({required this.addProductUseCase}):super(AddProductInitState());
  AddProductUseCase addProductUseCase;
  var formKey = GlobalKey<FormState>();
  TextEditingController productName = TextEditingController();

  TextEditingController productQuantity = TextEditingController();
  TextEditingController productQuantityType = TextEditingController();
  TextEditingController productCat = TextEditingController();
  TextEditingController productSup = TextEditingController();
  TextEditingController productTotal = TextEditingController();
  TextEditingController productTotalAfterDiscount = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productNotes = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController discountTypeController = TextEditingController();
  double total = 0.0;
  double totalAfterDiscount = 0.0;
  List<SupplierEntity>suppliers=[];
  List<CategoryEntity>categories=[];
  SupplierViewModel supplierViewModel=SupplierViewModel(supplierUseCases: injectSupplierUseCases());
  CategoriesViewModel categoriesViewModel=CategoriesViewModel(categoryUseCases: injectCategoryUseCases());
List<ProductEntity>productsInBill=[];
  void addProduct(ProductEntity product) async{
    emit(AddProductLoadingState(load: "Loadin..."));
    var either=await addProductUseCase.addProduct(product);
    return either.fold((l) {
      emit(AddProductErrorState(error: l));
    }, (r) {
      emit(AddProductSuccessState(productEntity: product));
    },);

  }



}