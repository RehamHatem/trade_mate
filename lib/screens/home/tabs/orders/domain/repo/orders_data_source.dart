import 'package:dartz/dartz.dart';

import '../../../../../../utils/failures.dart';
import '../../../bill/domain/entity/bill_entity.dart';

abstract class OrdersDataSource{
  Stream<Either<Failures,List<BillEntity>>>getBills();
  Future<void>deleteBill(String id);
  Future<void>updateBill(String id,BillEntity bill);
}