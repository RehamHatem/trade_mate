import '../../../bill/domain/entity/bill_entity.dart';

abstract class OrdersStates{

}
class OrdersInitState extends OrdersStates{}

class GetOrdersLoadingState extends OrdersStates{
  String load;
  GetOrdersLoadingState({required this.load});
}
class GetOrdersErrorState extends OrdersStates{
  String error;
  GetOrdersErrorState({required this.error});

}
class GetOrdersSuccessState extends OrdersStates{
  List<BillEntity>bills;
  GetOrdersSuccessState({required this.bills});
}


class RemoveOrderLoadingState extends OrdersStates{
  String load;
  RemoveOrderLoadingState({required this.load});
}
class RemoveOrderErrorState extends OrdersStates{
  String error;
  RemoveOrderErrorState({required this.error});

}
class RemoveOrderSuccessState extends OrdersStates{
  String success;
  RemoveOrderSuccessState({required this.success});
}



class UpdateOrderLoadingState extends OrdersStates{
  String load;
  UpdateOrderLoadingState({required this.load});
}
class UpdateOrderErrorState extends OrdersStates{
  String error;
  UpdateOrderErrorState({required this.error});

}
class UpdateOrderSuccessState extends OrdersStates{
  BillEntity bill;
  UpdateOrderSuccessState({required this.bill});
}