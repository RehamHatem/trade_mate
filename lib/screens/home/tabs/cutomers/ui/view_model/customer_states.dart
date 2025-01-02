import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';

abstract class CustomerStates{

}
class CustomerInitState extends CustomerStates{

}
class AddCustomerLoadingState extends CustomerStates{
  AddCustomerLoadingState({required this.load});
  String load;
}
class AddCustomerErrorState extends CustomerStates{
  AddCustomerErrorState({required this.error});
  String error;
}
class AddCustomerSuccessState extends CustomerStates{
  AddCustomerSuccessState({required this.entity});
  SupplierEntity  entity;
}
class GetCustomerLoadingState extends CustomerStates{
  GetCustomerLoadingState({required this.load});
  String load;
}
class GetCustomerErrorState extends CustomerStates{
  GetCustomerErrorState({required this.error});
  String error;
}
class GetCustomerSuccessState extends CustomerStates{
  GetCustomerSuccessState({required this.entity});
  List<SupplierEntity>  entity;
}
class RemoveCustomerLoadingState extends CustomerStates{
  RemoveCustomerLoadingState({required this.load});
  String load;
}
class RemoveCustomerErrorState extends CustomerStates{
  RemoveCustomerErrorState({required this.error});
  String error;
}
class RemoveCustomerSuccessState extends CustomerStates{
  RemoveCustomerSuccessState({required this.success});
  String success;
}

class UpdateCustomerLoadingState extends CustomerStates{
  UpdateCustomerLoadingState({required this.load});
  String load;
}
class UpdateCustomerErrorState extends CustomerStates{
  UpdateCustomerErrorState({required this.error});
  String error;
}
class UpdateCustomerSuccessState extends CustomerStates{
  UpdateCustomerSuccessState({required this.success});
  String success;
}