import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/entity/bill_entity.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/use_case/bill_use_cases.dart';
import 'package:trade_mate/screens/home/tabs/bill/ui/view_model/bill_states.dart';

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
  var quantityController=TextEditingController();
  var discountController=TextEditingController();
  var discountTypeController=TextEditingController();
  var totalController=TextEditingController();
  var balance=TextEditingController();
  var discountFormKey=GlobalKey<FormState>();
  var discountTypeControllerTotalBill=TextEditingController();
  var discountTotalBill=TextEditingController();
  List <ProductEntity>productsInBill=[];
  double totalBill=0;
  double totalBillAfterDiscount=0;

void addProductToBill(List <ProductEntity>products){
  emit(AddProductsInBillLoadingState(load: "load"));
  try{
    productsInBill.addAll(products);
    totalBill = productsInBill.fold(0, (sum, product) => sum + product.totalAfterDiscount);

    emit(AddProductsInBillSuccessState(products: productsInBill));
  }catch(e){
    emit(AddProductsInBillErrorState(error: e.toString()));
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


