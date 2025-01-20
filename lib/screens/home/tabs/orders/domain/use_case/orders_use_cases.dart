import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/orders/domain/repo/orders_repository.dart';

import '../../../../../../utils/failures.dart';
import '../../../bill/domain/entity/bill_entity.dart';

class OrdersUseCases{
  OrdersUseCases({required this.ordersRepository});
  OrdersRepository ordersRepository;

  Stream<Either<Failures,List<BillEntity>>>getBills(){
    return ordersRepository.getBills();

  }
  Future<void>deleteBill(String id){
    return ordersRepository.deleteBill(id);
  }
  Future<void>updateBill(String id,BillEntity bill){
    return ordersRepository.updateBill(id, bill);
  }
}