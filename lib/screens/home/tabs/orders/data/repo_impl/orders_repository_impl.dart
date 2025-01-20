import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/orders/domain/repo/orders_data_source.dart';
import 'package:trade_mate/screens/home/tabs/orders/domain/repo/orders_repository.dart';

import '../../../../../../utils/failures.dart';
import '../../../bill/domain/entity/bill_entity.dart';

class OrdersRepositoryImpl implements OrdersRepository{
  OrdersRepositoryImpl({required this.ordersDataSource});
  OrdersDataSource ordersDataSource;
  @override
  Future<void> deleteBill(String id) {
    return ordersDataSource.deleteBill(id);
  }

  @override
  Stream<Either<Failures, List<BillEntity>>> getBills() {
    return ordersDataSource.getBills();
  }

  @override
  Future<void> updateBill(String id, BillEntity bill) {
    return ordersDataSource.updateBill(id, bill);
  }
}