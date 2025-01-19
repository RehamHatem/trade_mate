import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/add_product_di.dart';
import 'package:trade_mate/screens/home/tabs/add_product/ui/view_model/add_product_view_model.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/entity/bill_entity.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/use_case/bill_use_cases.dart';
import 'package:trade_mate/screens/home/tabs/bill/ui/view/bill_tab.dart';
import 'package:trade_mate/screens/home/tabs/bill/ui/view_model/bill_states.dart';
import 'package:trade_mate/screens/home/tabs/home_tab/domain/home_tab_di.dart';
import 'package:trade_mate/screens/home/tabs/home_tab/ui/view_model/home_tab_view_model.dart';

import '../../../add_product/domain/entity/product_entity.dart';
import '../../../cutomers/domain/customer_di.dart';
import '../../../cutomers/ui/view_model/customer_view_model.dart';
import '../../../stock/domain/stock_di.dart';
import '../../../stock/ui/view_model/stock_view_model.dart';
import '../../../suppliers/domain/entity/supplier_entity.dart';
import '../../../suppliers/domain/supplier_di.dart';
import '../../../suppliers/ui/view_model/supplier_view_model.dart';

class BillViewModel extends Cubit<BillStates>{
  BillViewModel({required this.billUseCases}):super(BillInitState());
  BillUseCases billUseCases;

  List<SupplierEntity>suppliers=[];
  List<SupplierEntity>customers=[];
  SupplierViewModel supplierViewModel=SupplierViewModel(supplierUseCases: injectSupplierUseCases());
  CustomerViewModel customerViewModel=CustomerViewModel(customerUseCases: injectCustomerUseCases());
  var formKey=GlobalKey<FormState>();
  double total=0;


  List <ProductEntity>products=[];
  ProductEntity? selectedProduct;
  StockViewModel stockViewModel=StockViewModel(stockUseCases: injectStockUseCases());

  var productController=TextEditingController();
  var priceController=TextEditingController();
  var categoryController=TextEditingController();
  var notesController=TextEditingController();
  var supplierController=TextEditingController();
  var quantityController=TextEditingController();
  var quantityTypeController=TextEditingController();
  var discountController=TextEditingController();
  var discountTypeController=TextEditingController();
  var productAfterDiscountController=TextEditingController();
  double totalProductAfterDiscount=0;
  var totalController=TextEditingController();
  var balance=TextEditingController();
  var discountFormKey=GlobalKey<FormState>();
  var discountTypeControllerTotalBill=TextEditingController();
  var discountTotalBill=TextEditingController();
  var paidController=TextEditingController();
  double remain=0;
  List <ProductEntity>productsInBill=[];
  List <ProductEntity>productsOutBill=[];
  double totalBill=0;
  double totalBillAfterDiscount=0;
  double newBalance=0;
  AddProductViewModel addProductViewModel =AddProductViewModel(addProductUseCase: injectAddProductUseCase());
HomeTabViewModel homeTabViewModel=HomeTabViewModel(homeTabUseCases: injectHomeTabUseCases());
  void addProducttToBill(ProductEntity product,BillType bill){

    emit(AddProductsInBillLoadingState(load: "load"));
    try{
      if(bill==BillType.inBill){
        productsInBill.add(product);
        totalBill = productsInBill.fold(0, (sum, product) => sum + product.totalAfterDiscount);
        emit(AddProductsInBillSuccessState(products: productsInBill));
      }else if(bill==BillType.outBill){
        productsOutBill.add(product);
        totalBill = productsOutBill.fold(0, (sum, product) => sum + product.totalAfterDiscount);
        emit(AddProductsInBillSuccessState(products: productsOutBill));
      }


    }catch(e){
      emit(AddProductsInBillErrorState(error: e.toString()));
    }
  }
void addProductToBill(List <ProductEntity>products,BillType bill){

  emit(AddProductsInBillLoadingState(load: "load"));
  try{
    if(bill==BillType.inBill){
      productsInBill.addAll(products);
      totalBill = productsInBill.fold(0, (sum, product) => sum + product.totalAfterDiscount);
      emit(AddProductsInBillSuccessState(products: productsInBill));
    }else if(bill==BillType.outBill){
      productsOutBill.addAll(products);
      totalBill = productsOutBill.fold(0, (sum, product) => sum + product.totalAfterDiscount);
      emit(AddProductsInBillSuccessState(products: productsOutBill));
    }


  }catch(e){
    emit(AddProductsInBillErrorState(error: e.toString()));
  }
}
  void removeProductFromBill(ProductEntity product,BillType bill) {
    emit(RemoveProductFromBillLoadingState(load: "removing"));
    try {
      if(bill==BillType.inBill){
        productsInBill.remove(product);
        totalBill = productsInBill.fold(0, (sum, item) => sum + item.totalAfterDiscount);
        emit(RemoveProductFromBillSuccessState(products: productsInBill));
      }else if(bill==BillType.outBill){
        productsOutBill.remove(product);
        totalBill = productsOutBill.fold(0, (sum, item) => sum + item.totalAfterDiscount);
        emit(RemoveProductFromBillSuccessState(products: productsOutBill));
      }



    } catch (e) {
      emit(RemoveProductFromBillErrorState(error: e.toString()));
    }
  }
  void updateProductInBill(int index, ProductEntity updatedProduct,BillType bill) {
    emit(UpdateProductInBillLoadingState(load: "updating"));
    try {
      if(bill==BillType.inBill){
        if (index >= 0 && index < productsInBill.length) {
          productsInBill[index] = updatedProduct;
          totalBill = productsInBill.fold(0, (sum, item) => sum + item.totalAfterDiscount);
          print(productsInBill[index].name);
          emit(UpdateProductInBillSuccessState(products: productsInBill));
        } else {
          emit(UpdateProductInBillErrorState(error: "Invalid index"));
        }
      }else if(bill==BillType.outBill){
        if (index >= 0 && index < productsOutBill.length) {
          productsOutBill[index] = updatedProduct;
          totalBill = productsOutBill.fold(0, (sum, item) => sum + item.totalAfterDiscount);
          print(productsOutBill[index].name);
          emit(UpdateProductInBillSuccessState(products: productsOutBill));
        } else {
          emit(UpdateProductInBillErrorState(error: "Invalid index"));
        }
      }


    } catch (e) {
      emit(UpdateProductInBillErrorState(error: e.toString()));
    }
  }



  void addBill(BillEntity bill) async {
    emit(AddBillLoadingState(load: "Loadin..."));
    var either = await billUseCases.addBill(bill);
    return either.fold((l) {
      emit(AddBillErrorState(error: l.errorMsg!));
    }, (r) {
      print(bill.products);
      emit(AddBillSuccessState(bill: bill));
    },);
  }
  void updateTotalBill() {
    double discount = double.tryParse(discountTotalBill.text) ?? 0;
    totalBillAfterDiscount = totalBill;
    String type=discountTypeControllerTotalBill.text;
    print(discount);
    print(totalBillAfterDiscount);
    print(type);
try{
  if (discount != 0) {
    if (discountTypeControllerTotalBill.text == "%") {
      totalBillAfterDiscount = totalBill-(totalBill * discount) / 100;

    } else if (discountTypeControllerTotalBill.text == "EGP") {
      totalBillAfterDiscount = totalBill-discount;

    }
  }

    print(totalBillAfterDiscount);
    emit(UpdateTotalBillSuccessState(total: totalBillAfterDiscount));
  }catch(e){
  print(e.toString());

  }

}
  void removeDiscountTotalBill() {
    discountTotalBill.clear();
    discountTypeControllerTotalBill.clear();
    totalBillAfterDiscount = totalBill; // Reset to original bill
    emit(RemoveDiscountTotalBillSuccessState(total: totalBill));
  }



  }


