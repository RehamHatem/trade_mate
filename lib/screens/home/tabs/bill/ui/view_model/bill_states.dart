import 'package:trade_mate/screens/home/tabs/bill/domain/entity/bill_entity.dart';

import '../../../add_product/domain/entity/product_entity.dart';

abstract class BillStates{

}
class BillInitState extends BillStates{}
class AddProductsInBillLoadingState extends BillStates{
  String? load;
  AddProductsInBillLoadingState({required this.load});
}
class AddProductsInBillErrorState extends BillStates{
  String? error;
  AddProductsInBillErrorState({required this.error});
}
class AddProductsInBillSuccessState extends BillStates{
  List<ProductEntity> products;
  AddProductsInBillSuccessState({required this.products});
}


class RemoveProductFromBillLoadingState extends BillStates{
  String? load;
  RemoveProductFromBillLoadingState({required this.load});
}
class RemoveProductFromBillErrorState extends BillStates{
  String? error;
  RemoveProductFromBillErrorState({required this.error});
}
class RemoveProductFromBillSuccessState extends BillStates{
  List<ProductEntity> products;
  RemoveProductFromBillSuccessState({required this.products});
}


class AddBillLoadingState extends BillStates{
  String? load;
  AddBillLoadingState({required this.load});
}
class AddBillErrorState extends BillStates{
  String? error;
  AddBillErrorState({required this.error});
}
class AddBillSuccessState extends BillStates{
 BillEntity bill;
  AddBillSuccessState({required this.bill});
}
class UpdateTotalBillSuccessState extends BillStates{
  double? total;
  UpdateTotalBillSuccessState({required this.total});
}
class RemoveDiscountTotalBillSuccessState extends BillStates{
  double? total;
  RemoveDiscountTotalBillSuccessState({required this.total});
}