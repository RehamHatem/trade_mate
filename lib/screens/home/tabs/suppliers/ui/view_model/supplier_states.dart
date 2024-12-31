import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';

abstract class SupplierStates{

}
class SupplierInitState extends SupplierStates{

}
class AddSupplierLoadingState extends SupplierStates{
  AddSupplierLoadingState({required this.load});
  String load;
}
class AddSupplierErrorState extends SupplierStates{
  AddSupplierErrorState({required this.error});
  String error;
}
class AddSupplierSuccessState extends SupplierStates{
  AddSupplierSuccessState({required this.entity});
  SupplierEntity  entity;
}
class GetSupplierLoadingState extends SupplierStates{
  GetSupplierLoadingState({required this.load});
  String load;
}
class GetSupplierErrorState extends SupplierStates{
  GetSupplierErrorState({required this.error});
  String error;
}
class GetSupplierSuccessState extends SupplierStates{
  GetSupplierSuccessState({required this.entity});
  List<SupplierEntity>  entity;
}
class RemoveSupplierLoadingState extends SupplierStates{
  RemoveSupplierLoadingState({required this.load});
  String load;
}
class RemoveSupplierErrorState extends SupplierStates{
  RemoveSupplierErrorState({required this.error});
  String error;
}
class RemoveSupplierSuccessState extends SupplierStates{
  RemoveSupplierSuccessState({required this.success});
  String success;
}