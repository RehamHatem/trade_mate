import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  BillViewModel():super(BillInitState());
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

}