import 'package:dartz/dartz.dart';

import '../../../../../../utils/failures.dart';
import '../entity/bill_entity.dart';

abstract class BillRepository{
  Future<Either<Failures,void>>addBill(BillEntity bill);
  Stream<Either<Failures,List<BillEntity>>>getBills();
  Future<void>deleteBill(String id);
  Future<void>updateBill(String id,BillEntity bill);
}